`timescale 1ns / 1ps
module adder(input logic[31:0]a,
output logic [31:0]y);
  logic[31:0]b;
 assign b=32'd04;
 assign y=a+b;
endmodule