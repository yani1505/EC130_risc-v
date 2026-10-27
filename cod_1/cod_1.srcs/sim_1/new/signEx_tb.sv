`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2026 22:37:51
// Design Name: 
// Module Name: signEx_tb
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


module signEx_tb;
    reg [31:7] instr;
    reg [1:0]  immsrc;
    wire [31:0] immext;
    signEx uut (instr,immsrc,immext);
    initial begin
        // Initialize inputs
        instr  = 25'b0;
        immsrc = 2'b00;

        $display("Starting signEx Testbench...");

        // 1. Test I-Type (immsrc = 2'b00)
        immsrc = 2'b00;
        
        // Case 1a: Positive immediate (e.g., 12'h01F -> +31)
        instr[31:20] = 12'h01F;
        instr[31]    = 1'b0; // sign bit
        #10;
        $display("I-Type (+): instr[31:20] = %h | immext = %0d (Hex: %h)", instr[31:20], $signed(immext), immext);
        assert (immext === 32'h0000001F) else $error("I-Type positive failed!");

        // 2. Test S-Type (immsrc = 2'b01)
        immsrc = 2'b01;
        
        // Case 2a: Positive offset (instr[31:25] = 7'h05, instr[11:7] = 5'h0A)
        instr[31]    = 1'b0;
        instr[31:25] = 7'h05;
        instr[11:7]  = 5'h0A;
        #10;
        $display("S-Type (+): immext = %0d (Hex: %h)", $signed(immext), immext);
        assert (immext === 32'h000000AF) else $error("S-Type positive failed!");

        // 3. Test B-Type (immsrc = 2'b10)
        immsrc = 2'b10;
        
        // Case 3a: Branch offset check (Note: LSB should be 0)
        instr[31]    = 1'b1; // Negative offset
        instr[7]     = 1'b1;
        instr[30:25] = 6'h3F;
        instr[11:8]  = 4'hF;
        #10;
        $display("B-Type (-): immext = %0d (Hex: %h)", $signed(immext), immext);
        // LSB must be 0
        assert (immext[0] === 1'b0) else $error("B-Type LSB alignment failed!");

        // 4. Test J-Type (immsrc = 2'b11)
        immsrc = 2'b11;
        
        // Case 4a: Jump offset check (Note: LSB should be 0)
        instr[31]    = 1'b0; // Positive offset
        instr[19:12] = 8'h12;
        instr[20]    = 1'b1;
        instr[30:21] = 10'h345;
        #10;
        $display("J-Type (+): immext = %0d (Hex: %h)", $signed(immext), immext);
        // LSB must be 0
        assert (immext[0] === 1'b0) else $error("J-Type LSB alignment failed!");


        $display("All tests completed successfully!");
        $finish;
    end

endmodule

