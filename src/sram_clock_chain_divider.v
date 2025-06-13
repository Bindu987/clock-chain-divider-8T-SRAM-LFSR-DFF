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

