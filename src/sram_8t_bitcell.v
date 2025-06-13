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
