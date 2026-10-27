`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2026 21:28:50
// Design Name: 
// Module Name: reg_dec
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


module reg_dec(
    input  logic        clk,      // clock
    input  logic        we3,      // write enable for port 3
    input  logic [4:0]  a1,       // read address 1
    input  logic [4:0]  a2,       // read address 2
    input  logic [4:0]  a3,       // write address 3
    input  logic [31:0] wd3,      // write data for port 3
    output logic [31:0] rd1,      // read data output 1
    output logic [31:0] rd2       // read data output 2
);

    // 32 registers, each 32 bits wide
    logic [31:0] rf [31:0]; // rf == register file
    
    always_ff @(posedge clk) begin
    //if write enable true AND A3(i.e rd) != 0 (as always 0 no need to write)
        if (we3 && (a3 != 5'd0)) begin
            rf[a3] <= wd3; // write into a3 of rf 
        end
    end
    assign rd1 = (a1 == 5'd0) ? 32'h00000000 : rf[a1]; // if a1 ip is zero op rd is set to 0
    assign rd2 = (a2 == 5'd0) ? 32'h00000000 : rf[a2];// else op rd is set to value at a1/a2

endmodule
