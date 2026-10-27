`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2026 15:05:56
// Design Name: 
// Module Name: PC_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PC_tb;
reg clk,reset;
reg [31:0] pcnext;
wire [31:0] pcout;
PC dut(clk,reset,pcnext,pcout);
always
#5 clk = ~clk;
initial
begin
clk = 0;
reset = 0; pcnext = 32'd23;
#10 reset = 0; pcnext = 32'd33;
#10 reset = 1; pcnext = 32'd31;
#10 reset = 0; pcnext = 32'd31;
end
endmodule 

