

module M8_3(
    input [7:0] a,
    input [7:0] b,
    output [15:0] Y
);

    // Split inputs into lower and higher 4 bits
    wire [3:0] a_L = a[3:0];
    wire [3:0] a_H = a[7:4];
    wire [3:0] b_L = b[3:0];
    wire [3:0] b_H = b[7:4];

    // Partial product wires
    wire [7:0] aL_bL;
    wire [7:0] aL_bH;
    wire [7:0] aH_bL;
    wire [7:0] aH_bH;

    // Instantiate M1_4x4 for each partial product
    Exact_4x4 M1_1 (.a(a_L), .b(b_L), .Y(aL_bL)); // Lower 4 bits of a and b
    M1_4x4 M1_2 (.a(a_L), .b(b_H), .Y(aL_bH)); // Lower 4 bits of a, Higher 4 bits of b
    M1_4x4 M1_3 (.a(a_H), .b(b_L), .Y(aH_bL)); // Higher 4 bits of a, Lower 4 bits of b
    M1_4x4 M1_4 (.a(a_H), .b(b_H), .Y(aH_bH)); // Higher 4 bits of a and b

    // Combine partial products with proper shifting
    assign Y = {aH_bH, 8'b0} + {4'b0, aL_bH, 4'b0} + {4'b0, aH_bL, 4'b0} + {8'b0, aL_bL};

endmodule

