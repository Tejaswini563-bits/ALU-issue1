`timescale 1ns / 1ps

module rotate_shift_tb;

logic clk;
logic [31:0] a, b;
logic side;
logic [5:0] shift;
logic [63:0] out;

// Instantiate DUT
rotate_shift DUT (
    .clk(clk),
    .a(a),
    .b(b),
    .side(side),
    .shift(shift),
    .out(out)
);

// Clock generation (10ns period)
always #5 clk = ~clk;

initial begin
    clk = 0;

    // Test 1: Left rotate
    #10;
    a = 32'hAAAA_AAAA;
    b = 32'h5555_5555;
    shift = 6'd4;
    side = 1'b1;

    // Test 2: Right rotate
    #20;
    shift = 6'd8;
    side = 1'b0;

    // Test 3: Another value
    #20;
    a = 32'h1234_5678;
    b = 32'h8765_4321;
    shift = 6'd16;
    side = 1'b1;

    #50;
    $finish;
end

endmodule