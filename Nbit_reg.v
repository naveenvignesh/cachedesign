module Nbit_reg( 
in,
out,
clk,
we,
gwe,
rst
);

parameter n=1;

  input  [n-1:0] in;
  output reg [n-1:0] out;
  input          clk;
  input          we;
  input          gwe;
  input          rst;

always @(posedge clk) begin
   if(rst) begin
              out <= #1 0;
   end else begin
              out <= #1 we ? in : out;     
	    end
end
   //Nbit_reg #(n) stage_1 (.in(in_value), .out(value_1_2), .clk(clk), .we(1'd1), .gwe(gwe), .rst(rst));


endmodule 
