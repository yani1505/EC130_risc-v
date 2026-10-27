`timescale 1ns / 1ps

module ALU_main_tb;
    reg [6:0] op;
    wire [1:0] ResultSrc;
    wire       MemWrite;
    wire       Branch;
    wire       ALUSrc;
    wire       RegWrite;
    wire       Jump;
    wire [1:0] ImmSrc;
    wire [1:0] ALUOp;
    ALU_main uut (op,ResultSrc,MemWrite,Branch,ALUSrc,RegWrite,Jump,ImmSrc,ALUOp);

    initial begin
        $display("Starting ALU_main Testbench...");

        //---------------------------------------------------------
        // 1. Test R-Type (Opcode: 7'b0110011)
        //---------------------------------------------------------
        op = 7'b0110011;
        #10;
        $display("R-Type: RegWrite=%b, ALUSrc=%b, ALUOp=%b (Expected: RegW=1, ALUSrc=0, ALUOp=10)", 
                 RegWrite, ALUSrc, ALUOp);
        assert (RegWrite === 1'b1 && ALUSrc === 1'b0 && ALUOp === 2'b10) else $error("R-Type test failed!");

        //---------------------------------------------------------
        // 2. Test I-Type ALU (Opcode: 7'b0010011)
        //---------------------------------------------------------
        op = 7'b0010011;
        #10;
        $display("I-Type: RegWrite=%b, ALUSrc=%b, ALUOp=%b (Expected: RegW=1, ALUSrc=1, ALUOp=10)", 
                 RegWrite, ALUSrc, ALUOp);
        assert (RegWrite === 1'b1 && ALUSrc === 1'b1 && ALUOp === 2'b10) else $error("I-Type test failed!");

        //---------------------------------------------------------
        // 3. Test LW - Load Word (Opcode: 7'b0000011)
        //---------------------------------------------------------
        op = 7'b0000011;
        #10;
        $display("LW: ResultSrc=%b, ALUSrc=%b, ALUOp=%b (Expected: ResSrc=01, ALUSrc=1, ALUOp=00)", 
                 ResultSrc, ALUSrc, ALUOp);
        assert (ResultSrc === 2'b01 && ALUSrc === 1'b1 && ALUOp === 2'b00) else $error("LW test failed!");

        //---------------------------------------------------------
        // 4. Test SW - Store Word (Opcode: 7'b0100011)
        //---------------------------------------------------------
        op = 7'b0100011;
        #10;
        $display("SW: MemWrite=%b, ImmSrc=%b, ALUOp=%b (Expected: MemW=1, ImmSrc=01, ALUOp=00)", 
                 MemWrite, ImmSrc, ALUOp);
        assert (MemWrite === 1'b1 && ImmSrc === 2'b01 && ALUOp === 2'b00) else $error("SW test failed!");

        //---------------------------------------------------------
        // 5. Test BEQ - Branch Equal (Opcode: 7'b1100011)
        //---------------------------------------------------------
        op = 7'b1100011;
        #10;
        $display("BEQ: Branch=%b, ImmSrc=%b, ALUOp=%b (Expected: Branch=1, ImmSrc=10, ALUOp=01)", 
                 Branch, ImmSrc, ALUOp);
        assert (Branch === 1'b1 && ImmSrc === 2'b10 && ALUOp === 2'b01) else $error("BEQ test failed!");

        //---------------------------------------------------------
        // 6. Test JAL - Jump and Link (Opcode: 7'b1101111)
        //---------------------------------------------------------
        op = 7'b1101111;
        #10;
        $display("JAL: Jump=%b, ResultSrc=%b, ImmSrc=%b (Expected: Jump=1, ResSrc=10, ImmSrc=11)", 
                 Jump, ResultSrc, ImmSrc);
        assert (Jump === 1'b1 && ResultSrc === 2'b10 && ImmSrc === 2'b11) else $error("JAL test failed!");

        // Finish simulation
        $display("All ALU_main tests passed successfully!");
        $finish;
    end

endmodule