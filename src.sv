`timescale 1ns / 1ps

module rotate_shift(
    input  logic        clk,
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic        side,
    input  logic [5:0]  shift,
    output logic [63:0] out
);

logic [63:0] inter_out_reg;
logic [5:0]  s_reg;
logic [63:0] pre_out_reg;

// --------------------
// Stage 1: Register inputs
// --------------------
always_ff @(posedge clk) begin
    inter_out_reg <= {a, b};
    s_reg         <= shift % 64;
end

// --------------------
// Stage 2: Perform rotate
// --------------------
always_ff @(posedge clk) begin
    if (side)
        pre_out_reg <= (inter_out_reg << s_reg) |
                       (inter_out_reg >> (64 - s_reg));
    else
        pre_out_reg <= (inter_out_reg >> s_reg) |
                       (inter_out_reg << (64 - s_reg));
end

assign out = pre_out_reg;

endmodule