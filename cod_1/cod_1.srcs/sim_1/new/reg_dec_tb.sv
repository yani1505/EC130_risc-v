`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2026 21:40:45
// Design Name: 
// Module Name: reg_dec_tb
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


module reg_dec_tb;
    reg        clk;
    reg        we3;
    reg [4:0]  a1;
    reg [4:0]  a2;
    reg [4:0]  a3;
    reg [31:0] wd3;
    wire [31:0] rd1;
    wire [31:0] rd2;

    reg_dec uut (clk,we3,a1,a2,a3,wd3,rd1,rd2);
    always begin
        #5 clk = ~clk;
    end

    initial begin
        // Initialize signals
        clk = 0;
        we3 = 0;
        a1  = 5'd0;
        a2  = 5'd0;
        a3  = 5'd0;
        wd3 = 32'h00000000;

        // Wait for global reset / initial stabilization
        #10;

        $display("--- Starting Register File Tests ---");

        // Test 1: Try writing to Register 0
        @(negedge clk);
        we3 = 1;
        a3  = 5'd0;          // Register x0
        wd3 = 32'hDEADBEEF;  // Attempt to write non-zero value
        @(posedge clk);
        #1; // Wait slightly past clock edge for update

        // Read back register 0 via a1
        a1 = 5'd0;
        #5;
        $display("Time=%0t ns | Read x0 (rd1) = %h (Expected: 00000000)", $time, rd1);


        // Test 2: Write data to a normal register (e.g., x1 = 12345678)
        @(negedge clk);
        we3 = 1;
        a3  = 5'd1;          // Register x1
        wd3 = 32'h12345678;
        @(posedge clk);
        #1;

        // Write data to another register (e.g., x2 = CAFEBABE)
        @(negedge clk);
        a3  = 5'd2;          // Register x2
        wd3 = 32'hCAFEBABE;
        @(posedge clk);
        #1;

        // Disable writing
        we3 = 0;


        // Test 3: Read back x1 and x2 simultaneously using port 1 and port 2
        @(negedge clk);
        a1 = 5'd1;          // Should read x1
        a2 = 5'd2;          // Should read x2
        #5;
        $display("Time=%0t ns | Read x1 (rd1) = %h (Expected: 12345678)", $time, rd1);
        $display("Time=%0t ns | Read x2 (rd2) = %h (Expected: CAFEBABE)", $time, rd2);


        // Test 4: Check combinational behavior (reading unwritten register x3 should be 0)
        a1 = 5'd3;
        #5;
        $display("Time=%0t ns | Read x3 (rd1) = %h (Expected: 00000000)", $time, rd1);

        $display("--- Tests Completed Successfully ---");
        $finish;
    end

endmodule
