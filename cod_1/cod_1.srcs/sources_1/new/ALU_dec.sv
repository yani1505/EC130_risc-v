`timescale 1ns / 1ps

module ALU_dec(
    input  logic       opb5,      // instruction bit [5] of opcode
    input  logic [2:0] funct3,    // funct3 field of instruction
    input  logic       funct7b5,  // bit 5 of funct7 field
    input  logic [1:0] ALUOp,     // high-level ALU operation
    output logic [2:0] ALUControl // ALU operation code
);

    // R-type subtraction indicator: 
    // R-type instructions have op[5] = 1, and SUB requires funct7[5] = 1.
    logic RtypeSub;
    assign RtypeSub = opb5 & funct7b5;

    always_comb begin
        case (ALUOp)
            2'b00:   // Loads and Stores (LW, SW) -> Add
                ALUControl = 3'b000;
                
            2'b01:   // Branches (BEQ) -> Subtract (for comparison)
                ALUControl = 3'b001;
                
            2'b10:   // R-type and I-type Arithmetic/Logic instructions
                case (funct3)
                    3'b000:  begin // ADD, ADDI, or SUB
                                 if (RtypeSub) 
                                     ALUControl = 3'b001; // SUB
                                 else          
                                     ALUControl = 3'b000; // ADD, ADDI
                             end
                    3'b010:  ALUControl = 3'b101; // SLT, SLTI
                    3'b110:  ALUControl = 3'b011; // OR, ORI
                    3'b111:  ALUControl = 3'b010; // AND, ANDI
                    default: ALUControl = 3'b000;
                endcase
                
            default: 
                ALUControl = 3'b000;
        endcase
    end

endmodule