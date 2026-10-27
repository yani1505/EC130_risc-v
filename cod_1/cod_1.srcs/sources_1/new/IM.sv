`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2026 15:38:42
// Design Name: 
// Module Name: IM
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


module IM(
    input  logic [31:0] addr,
    output logic [31:0] instn
);
    logic [31:0] rom [63:0];
    initial begin
        $readmemh("instructions.txt", rom);
    end
    assign instn = rom[addr[7:2]];

endmodule
