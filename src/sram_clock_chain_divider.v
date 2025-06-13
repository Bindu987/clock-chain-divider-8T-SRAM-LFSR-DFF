module sram_clock_chain_divider (
    input clk,
    input rst,
    input en_clk,
    input en_pwr,
    input test_mode,
    output [7:0] out
);

    reg [2:0] stage;
    reg bit_in;

    wire gated_clk;
    wire [7:0] bl, wwl, rwl;
    wire [7:0] out_wires;

    assign out = out_wires;
    assign gated_clk = (test_mode || en_clk) ? clk : 1'b0;
    assign bl = {8{bit_in}};
    assign wwl = (en_pwr || test_mode) ? (8'b00000001 << stage) : 8'b00000000;
    assign rwl = wwl;  // Read and write same stage in this design

    // Manually instantiate 8 SRAM bitcells
    sram_8t_bitcell u0 (.bl(bl[0]), .wwl(wwl[0]), .rwl(rwl[0]), .q(out_wires[0]));
    sram_8t_bitcell u1 (.bl(bl[1]), .wwl(wwl[1]), .rwl(rwl[1]), .q(out_wires[1]));
    sram_8t_bitcell u2 (.bl(bl[2]), .wwl(wwl[2]), .rwl(rwl[2]), .q(out_wires[2]));
    sram_8t_bitcell u3 (.bl(bl[3]), .wwl(wwl[3]), .rwl(rwl[3]), .q(out_wires[3]));
    sram_8t_bitcell u4 (.bl(bl[4]), .wwl(wwl[4]), .rwl(rwl[4]), .q(out_wires[4]));
    sram_8t_bitcell u5 (.bl(bl[5]), .wwl(wwl[5]), .rwl(rwl[5]), .q(out_wires[5]));
    sram_8t_bitcell u6 (.bl(bl[6]), .wwl(wwl[6]), .rwl(rwl[6]), .q(out_wires[6]));
    sram_8t_bitcell u7 (.bl(bl[7]), .wwl(wwl[7]), .rwl(rwl[7]), .q(out_wires[7]));

    // Control logic
    always @(posedge gated_clk or posedge rst) begin
        if (rst) begin
            stage <= 3'b000;
            bit_in <= 1'b1;
        end else begin
            stage <= (stage + 1) % 8;
            bit_in <= ~out_wires[7];  // Toggle input based on last bit
        end
    end

endmodule
module sram_8t_bitcell (
    input bl,
    input wwl,
    input rwl,
    output reg q
);

    reg stored_bit;

    // Write operation
    always @(posedge wwl) begin
        stored_bit <= bl;
    end

    // Read operation — directly assign to q
    always @(*) begin
        if (rwl)
            q = stored_bit;
        else
            q = 1'b0;  // or retain previous value or force low
    end

endmodule
`timescale 1ns / 1ps

module tb_sram_clock_chain_divider;

    reg clk, rst, en_clk, en_pwr, test_mode;
    wire [7:0] out;
    reg [7:0] prev_out;

    sram_clock_chain_divider uut (
        .clk(clk),
        .rst(rst),
        .en_clk(en_clk),
        .en_pwr(en_pwr),
        .test_mode(test_mode),
        .out(out)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (rst)
            $display("%0t ns | RESET         | out = %b", $time, out);
        else if (test_mode)
            $display("%0t ns | TEST MODE     | out = %b", $time, out);
        else if (!en_clk)
            $display("%0t ns | CLOCK GATED   | out = %b", $time, out);
        else if (!en_pwr)
            $display("%0t ns | POWER GATED   | out = %b", $time, out);
        else if (out != prev_out)
            $display("%0t ns | UPDATING      | out = %b", $time, out);
        else
            $display("%0t ns | HOLDING       | out = %b", $time, out);

        prev_out <= out;
    end

    initial begin
        $dumpfile("sram_chain.vcd");
        $dumpvars(0, tb_sram_clock_chain_divider);

        rst = 1; en_clk = 0; en_pwr = 0; test_mode = 0;
        prev_out = 0;
        #12 rst = 0;

        #10 en_clk = 1; en_pwr = 1;
        #100;

        #10 en_clk = 0;  // Clock gating
        #30 en_clk = 1;

        #10 en_pwr = 0;  // Power gating
        #30 en_pwr = 1;

        #10 test_mode = 1;  // Test override
        #40 test_mode = 0;

        #20;
        $display("=== Simulation Complete ===");
        $finish;
    end

endmodule
