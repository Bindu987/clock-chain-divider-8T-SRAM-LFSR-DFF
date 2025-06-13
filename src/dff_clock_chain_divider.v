
module dff_clock_chain_divider (
    input clk,
    input rst,
    output [7:0] out
);

    reg [7:0] dc;

    assign out = dc;

    always @(posedge clk or posedge rst) begin
        if (rst)
            dc <= 8'b00000000;
        else
            dc <= {dc[6:0], ~dc[7]};  // Shift + toggle MSB
    end

endmodule
