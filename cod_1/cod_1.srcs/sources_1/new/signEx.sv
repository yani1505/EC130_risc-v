`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2026 22:34:41
// Design Name: 
// Module Name: signEx
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


module signEx(
    input  logic [31:7] instr,    // Instruction bits [31:7]
    input  logic [1:0]  immsrc,    // Immediate type selector
    output logic [31:0] immext     // Sign-extended immediate
);

    always_comb begin
        case (immsrc)
            2'b00:   // I-type (e.g., lw, addi, jalr)
                immext = {{20{instr[31]}}, instr[31:20]};
                
            2'b01:   // S-type (e.g., sw)
                immext = {{20{instr[31]}}, instr[31:25], instr[11:7]};
                
            2'b10:   // B-type (e.g., beq, bne) - includes implicit LSB 0
                immext = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
                
            2'b11:   // J-type (e.g., jal) - includes implicit LSB 0
                immext = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
                
            default: 
                immext = 32'b0;
        endcase
    end

endmodule
