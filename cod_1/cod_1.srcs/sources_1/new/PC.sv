`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2026 15:05:07
// Design Name: 
// Module Name: PC
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


module PC(
input logic clk,reset,
input logic[31:0]pcnext,
output logic[31:0]pcout
    );
 always_ff @(posedge clk)
 begin
 if(reset)
 pcout<=32'd0;
 else
 pcout<=pcnext;
 end      
endmodule