`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2026 22:45:28
// Design Name: 
// Module Name: ALU_dec_tb
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


module ALU_dec_tb;
    reg       opb5;
    reg [2:0] funct3;
    reg       funct7b5;
    reg [1:0] ALUOp;
    wire [2:0] ALUControl;
    ALU_dec uut (opb5,funct3,funct7b5,ALUOp,ALUControl);

    initial begin
        $display("Starting aludec Testbench...");

        //---------------------------------------------------------
        // 1. Test Loads and Stores (ALUOp = 2'b00) -> ADD (3'b000)
        //---------------------------------------------------------
        ALUOp = 2'b00;
        opb5     = 1'b0;
        funct3   = 3'b000;
        funct7b5 = 1'b0;
        #10;
        $display("LW/SW (ALUOp=00): ALUControl = %b (Expected: 000)", ALUControl);
        assert (ALUControl === 3'b000) else $error("LW/SW test failed!");


        //---------------------------------------------------------
        // 2. Test Branches (ALUOp = 2'b01) -> SUB (3'b001)
        //---------------------------------------------------------
        ALUOp = 2'b01;
        opb5     = 1'b0;
        funct3   = 3'b000;
        funct7b5 = 1'b0;
        #10;
        $display("BEQ (ALUOp=01): ALUControl = %b (Expected: 001)", ALUControl);
        assert (ALUControl === 3'b001) else $error("BEQ test failed!");


        //---------------------------------------------------------
        // 3. Test R-Type / I-Type Arithmetic & Logic (ALUOp = 2'b10)
        //---------------------------------------------------------
        ALUOp = 2'b10;

        // 3a. ADDI / ADD (opb5=0 for I-type or R-type add)
        opb5     = 1'b0; 
        funct3   = 3'b000;
        funct7b5 = 1'b0;
        #10;
        $display("ADD/ADDI (funct3=000, opb5=0): ALUControl = %b (Expected: 000)", ALUControl);
        assert (ALUControl === 3'b000) else $error("ADD/ADDI test failed!");

        // 3b. SUB (R-type: opb5=1, funct7[5]=1)
        opb5     = 1'b1; 
        funct3   = 3'b000;
        funct7b5 = 1'b1;
        #10;
        $display("SUB (funct3=000, opb5=1, funct7[5]=1): ALUControl = %b (Expected: 001)", ALUControl);
        assert (ALUControl === 3'b001) else $error("SUB test failed!");

        // 3c. AND / ANDI (funct3=3'b111)
        opb5     = 1'b0;
        funct3   = 3'b111;
        funct7b5 = 1'b0;
        #10;
        $display("AND/ANDI (funct3=111): ALUControl = %b (Expected: 010)", ALUControl);
        assert (ALUControl === 3'b010) else $error("AND/ANDI test failed!");

        // 3d. OR / ORI (funct3=3'b110)
        funct3   = 3'b110;
        #10;
        $display("OR/ORI (funct3=110): ALUControl = %b (Expected: 011)", ALUControl);
        assert (ALUControl === 3'b011) else $error("OR/ORI test failed!");

        // 3e. SLT / SLTI (funct3=3'b010)
        funct3   = 3'b010;
        #10;
        $display("SLT/SLTI (funct3=010): ALUControl = %b (Expected: 101)", ALUControl);
        assert (ALUControl === 3'b101) else $error("SLT/SLTI test failed!");


        // Finish simulation
        $display("All aludec tests passed successfully!");
        $finish;
    end

endmodule