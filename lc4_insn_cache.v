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

//tag + data + valid
//2^7 16-bit blocks
wire  [6:0]  blockid;
wire  [7:0]  tag;
//reg          valid;
reg   [16:0] cmem    [127:0];
reg   [7:0]  tagcmem [127:0];
reg          hit;
reg          cmp;
reg   [15:0] miss_addr,miss_addr_1d,miss_addr_2d,miss_addr_3d,miss_addr_4d,miss_addr_5d,miss_addr_6d,miss_addr_7d,miss_addr_8d;
reg   [16:0] mem0;
wire         cvld;
reg miss,miss_1d,miss_2d,miss_3d,miss_4d,miss_5d,miss_6d,miss_7d,miss_8d;

assign blockid = addr[6:0];
assign tag     = addr[15:7];
assign vld     = cmem[blockid][16];

always @(*) begin
   cmp =  (tagcmem[blockid] == tag);
   hit =  cmp & vld ;
   miss= ~hit;
end

always @(posedge clk) begin
  if(rst) begin
     //miss    <= 0;
     miss_1d <= 0;
     miss_2d <= 0;
     miss_3d <= 0;
     miss_4d <= 0;
     miss_5d <= 0;
     miss_6d <= 0;
     miss_7d <= 0;
     miss_8d <= 0;
     miss_addr    <= 0;
     miss_addr_1d <= 0;
     miss_addr_2d <= 0;
     miss_addr_3d <= 0;
     miss_addr_4d <= 0;
     miss_addr_5d <= 0;
     miss_addr_6d <= 0;
     miss_addr_7d <= 0;
     miss_addr_8d <= 0;
  end else begin
     //miss         <= #1 ~hit;
     miss_1d      <= #1 miss;
     miss_2d      <= #1 miss_1d;
     miss_3d      <= #1 miss_2d;
     miss_4d      <= #1 miss_3d;
     miss_5d      <= #1 miss_4d;
     miss_6d      <= #1 miss_5d;
     miss_7d      <= #1 miss_6d;
     miss_8d      <= #1 miss_7d;
     //miss_addr    <= #1 miss ? addr : 16'h0;
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

assign cvld    = cmem[miss_addr_7d[6:0]][16];
always @(posedge clk) begin
  if(rst) begin
     for(integer i=0;i<128;i=i+1) begin
            cmem[i]    <= #0 16'b0;
            tagcmem[i] <= #0 8'h0; 
     end
  end else begin
            cmem[miss_addr_8d[6:0]]     <= #1 miss_8d  ? {1'b1,mem_idata}:cmem[miss_addr_8d[6:0]];
            tagcmem[miss_addr_8d[6:0]]  <= #1 miss_8d  ? miss_addr_8d[15:7]:tagcmem[miss_addr_8d[6:0]]; 
           end
end

assign data      = hit ? cmem[blockid] : 16'h0;
assign valid     = hit;
assign mem_iaddr = ~hit ? addr : 16'h0;
assign mem0      = cmem[0];

endmodule 


