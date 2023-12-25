module Top_level_TwoThreeBitsAdder(
input [2:0] I1,   
input [2:0] I2,   
output [6:0] BCD1,
output [6:0] BCD2,
output [6:0] BCD3);

wire [3:0] Osum;

two_threebitsadder_BCD_Code inst (
	.I1 (I1),
	.I2(I2),
	.O(Osum),
);

bcd_code inst11
(	.in(I1),
	.out(BCD1)
);
bcd_code inst12
(	.in(I2),
	.out(BCD2)
);
bcd_code inst13
(	.in(Osum),
	.out(BCD3)
);
endmodule 