`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2026 22:43:34
// Design Name: 
// Module Name: ALU_main
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


module ALU_main(
    input  logic [6:0] op,        // Opcode of the instruction
    output logic [1:0] ResultSrc, // Selects ALU, memory, or PC+4 for writeback
    output logic       MemWrite,   // Enable writing to data memory
    output logic       Branch,     // Branch instruction flag
    output logic       ALUSrc,     // ALU source select (register vs immediate)
    output logic       RegWrite,   // Enable writing to register file
    output logic       Jump,       // Jump instruction flag
    output logic [1:0] ImmSrc,     // Immediate type selector
    output logic [1:0] ALUOp       // ALU operation selector
);

    always_comb begin
        case (op)
            7'b0110011: begin // R-type (e.g., add, sub, and, or)
                RegWrite  = 1'b1;
                ImmSrc    = 2'b00; // Don't care
                ALUOp     = 2'b10;
                MemWrite  = 1'b0;
                ResultSrc = 2'b00;
                Branch    = 1'b0;
                Jump      = 1'b0;
                ALUSrc    = 1'b0;
            end
            
            7'b0010011: begin // I-type ALU (e.g., addi, andi, ori)
                RegWrite  = 1'b1;
                ImmSrc    = 2'b00;
                ALUOp     = 2'b10;
                MemWrite  = 1'b0;
                ResultSrc = 2'b00;
                Branch    = 1'b0;
                Jump      = 1'b0;
                ALUSrc    = 1'b1;
            end
            
            7'b0000011: begin // LW (Load Word)
                RegWrite  = 1'b1;
                ImmSrc    = 2'b00;
                ALUOp     = 2'b00; // Add for address calculation
                MemWrite  = 1'b0;
                ResultSrc = 2'b01; // Select memory data
                Branch    = 1'b0;
                Jump      = 1'b0;
                ALUSrc    = 1'b1; // Immediate offset
            end
            
            7'b0100011: begin // SW (Store Word)
                RegWrite  = 1'b0;
                ImmSrc    = 2'b01; // S-type immediate
                ALUOp     = 2'b00; // Add for address calculation
                MemWrite  = 1'b1;
                ResultSrc = 2'b00; // Don't care
                Branch    = 1'b0;
                Jump      = 1'b0;
                ALUSrc    = 1'b1; // Immediate offset
            end
            
            7'b1100011: begin // BEQ (Branch Equal)
                RegWrite  = 1'b0;
                ImmSrc    = 2'b10; // B-type immediate
                ALUOp     = 2'b01; // Subtract for comparison
                MemWrite  = 1'b0;
                ResultSrc = 2'b00; // Don't care
                Branch    = 1'b1;
                Jump      = 1'b0;
                ALUSrc    = 1'b0; // Register comparison
            end
            
            7'b1101111: begin // JAL (Jump and Link)
                RegWrite  = 1'b1;
                ImmSrc    = 2'b11; // J-type immediate
                ALUOp     = 2'b00; // Don't care
                MemWrite  = 1'b0;
                ResultSrc = 2'b10; // Select PC+4 for return address
                Branch    = 1'b0;
                Jump      = 1'b1;
                ALUSrc    = 1'b0; // Don't care
            end
            
            default: begin
                RegWrite  = 1'b0;
                ImmSrc    = 2'b00;
                ALUOp     = 2'b00;
                MemWrite  = 1'b0;
                ResultSrc = 2'b00;
                Branch    = 1'b0;
                Jump      = 1'b0;
                ALUSrc    = 1'b0;
            end
        endcase
    end
endmodule
