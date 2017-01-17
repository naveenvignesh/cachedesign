`timescale 1ns/1ps
module lc4_insn_cache (
//global wires
input clk,
input gwe,
input rst,
//wires to acces instruction memory 
input [15:0] mem_idata,
output [15:0] mem_iaddr,
//interface for lc4_processor
input [15:0] addr,
output valid,
output [15:0] data
);

// cache structures 
reg   [16:0] cmem    [127:0]; // valid + data
reg   [1:0]  lru_bit [63:0];  // 2 lru bits/set          
reg   [9:0]  tagcmem [127:0]; // 10 bit tag for comparison

//address = tag + setid (10 bit + 6bit) 
//2^7 16-bit blocks
wire         mblockid;
wire  [9:0]  tag,stag0,stag1,mtag,mstag0,mstag1;
wire         cmp0,cmp1,blockindex;
wire  [6:0]  cmemindex,mcmemindex,mbaddr0,mbaddr1,tag_index0,tag_index1;
wire  [5:0]  setid,msetid;
wire         rblock0,rblock1,replaceblock;
wire  [16:0] cdata,mcdata;
wire  [1:0]  mlru_bit;
reg          dvalid;

reg          hit;
reg          cmp;
reg   [15:0] miss_addr,miss_addr_1d,miss_addr_2d,miss_addr_3d,miss_addr_4d,miss_addr_5d,miss_addr_6d,miss_addr_7d,miss_addr_8d;
reg   [16:0] mem0;
reg miss,miss_1d,miss_2d,miss_3d,miss_4d,miss_5d,miss_6d,miss_7d,miss_8d;
reg  mhit,mmiss;
wire mcmp0,mcmp1,mblockindex,mcvalid;

assign {tag,setid}         = addr;
assign tag_index0          = {setid,1'b0};
assign tag_index1          = {setid,1'b1};
assign stag0               = tagcmem[tag_index0];
assign stag1               = tagcmem[tag_index1];
assign cmp0                = (tag == stag0);
assign cmp1                = (tag == stag1);
assign blockindex          = (~cmp0 & cmp1);
assign cmemindex           = {setid,blockindex};
assign cdata               = cmem[cmemindex];
assign cvalid              = cdata[16];

always @(*) begin
   hit  = ( (cmp0 & cvalid) | (cmp1 & cvalid) );
   miss = ~hit;
end

assign {vld,data}      = hit ? cdata : 17'h0;
assign valid           = hit;

//logic to update lru in cache
always @(posedge clk) begin
  if(rst) begin
     for(integer i=0;i<64;i=i+1) begin
          lru_bit [i] <= #0 2'b10;  // 2 lru bits/set          
     end
  end else begin
             lru_bit[setid] <= #1 hit ? (blockindex ? 2'b10: 2'b01) : lru_bit[setid]; 
/*             if(hit) begin
               $display("%t RTL LRU_BIT[%h]=%b UPDATED FOR HIT ADDR:%h",$time,setid,lru_bit[setid],addr);
             end else begin

               $display("%t RTL LRU_BIT[%h]=%b FOR MISS ADDR:%h",$time,setid,lru_bit[setid],addr);
                      end
*/
             if(replaceblock & rblock0 & mmiss) begin
                lru_bit[msetid] <= #1 2'b01;
//               $display("%t RTL LRU_BIT[%h]=%b UPDATED FOR BLOCK0 REPLACE ADDR:%h",$time,msetid,lru_bit[msetid],miss_addr_8d);
             end
             if(replaceblock & rblock1 & mmiss) begin
                lru_bit[msetid] <= #1 2'b10;
//               $display("%t RTL LRU_BIT[%h]=%b UPDATED FOR BLOCK1 REPLACE ADDR:%h",$time,msetid,lru_bit[msetid],miss_addr_8d);
             end
           end
end 

// data fetched from memory to cache
assign mem_iaddr = miss ? addr : 16'h0;
always @(posedge clk) begin
  if(rst) begin
     miss_1d      <= #0  0;
     miss_2d      <= #0  0;
     miss_3d      <= #0  0;
     miss_4d      <= #0  0;
     miss_5d      <= #0  0;
     miss_6d      <= #0  0;
     miss_7d      <= #0  0;
     miss_8d      <= #0  0;
     miss_addr    <= #0  0;
     miss_addr_1d <= #0  0;
     miss_addr_2d <= #0  0;
     miss_addr_3d <= #0  0;
     miss_addr_4d <= #0  0;
     miss_addr_5d <= #0  0;
     miss_addr_6d <= #0  0;
     miss_addr_7d <= #0  0;
     miss_addr_8d <= #0  0;
  end else begin
     miss_1d      <= #1 miss;
     miss_2d      <= #1 miss_1d;
     miss_3d      <= #1 miss_2d;
     miss_4d      <= #1 miss_3d;
     miss_5d      <= #1 miss_4d;
     miss_6d      <= #1 miss_5d;
     miss_7d      <= #1 miss_6d;
     miss_8d      <= #1 miss_7d;
     miss_addr_1d <= #1 miss ? addr : 16'h0;
     miss_addr_2d <= #1 miss_addr_1d;
     miss_addr_3d <= #1 miss_addr_2d;
     miss_addr_4d <= #1 miss_addr_3d;
     miss_addr_5d <= #1 miss_addr_4d;
     miss_addr_6d <= #1 miss_addr_5d;
     miss_addr_7d <= #1 miss_addr_6d;
     miss_addr_8d <= #1 miss_addr_7d;
           end
end

assign {mtag,msetid}          = miss_addr_8d;
assign mbaddr0                = {msetid,1'b0};
assign mbaddr1                = {msetid,1'b1};
assign mlru_bit               = lru_bit[msetid];
assign rblock0                = (mlru_bit == 2'b10);
assign rblock1                = (mlru_bit == 2'b01);
assign replaceblock           =  miss_8d;
//assign tag_index0          = {setid,1'b0};
//assign tag_index1          = {setid,1'b1};
assign mstag0               = tagcmem[mbaddr0];
assign mstag1               = tagcmem[mbaddr1];
assign mcmp0                = (mtag == mstag0);
assign mcmp1                = (mtag == mstag1);
assign mblockindex          = (~mcmp0 & mcmp1);
assign mcmemindex           = {msetid,mblockindex};
assign mcdata               = cmem[mcmemindex];
assign mcvalid              = mcdata[16];

always @(*) begin
   mhit  = ( (mcmp0 & mcvalid) | (mcmp1 & mcvalid) );
   mmiss = ~mhit;
end

always @(posedge clk) begin
  if(rst) begin
     for(integer i=0;i<128;i=i+1) begin
            cmem[i]    <= #0 17'b0;
            tagcmem[i] <= #0 9'h0; 
     end
  end else begin
            if(replaceblock & rblock0 & mmiss) begin
            cmem[mbaddr0]     <= #1 {1'b1,mem_idata};
            tagcmem[mbaddr0]  <= #1 mtag; 
            end 
            if(replaceblock & rblock1 & mmiss) begin
            cmem[mbaddr1]               <= #1 {1'b1,mem_idata};
            tagcmem[mbaddr1]            <= #1  mtag; 
            end
           end
end


endmodule 


