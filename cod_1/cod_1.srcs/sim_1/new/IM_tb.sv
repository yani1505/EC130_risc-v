`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2026 19:52:33
// Design Name: 
// Module Name: IM_tb
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


module IM_tb;
    reg [31:0] addr;
    wire [31:0] instn;
    IM dut (addr,instn);
    initial begin
        // Monitor changes
        $display("Time\t\tAddress (Hex)\tInstruction (Hex)");
        $monitor("%0t ns\t\t%h\t\t%h", $time, addr, instn);
        addr = 32'h00000000;
        #10;

        // Test sequential word-aligned addresses (0, 4, 8, 12, etc.)
        addr = 32'h00000004;
        #10;

        addr = 32'h00000008;
        #10;

        addr = 32'h0000000C;
        #10;

        // Test a higher address index (e.g., index 10 -> byte address 40 / 0x28)
        addr = 32'h00000028;
        #10;
        $finish;
    end
endmodule