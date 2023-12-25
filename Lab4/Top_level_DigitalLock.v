module Top_level_DigitalLock (
	
input clock_in,
input sys_reset,
input reset_clk,
input w,
output f_out,
output [6:0] out,
output [3:0] leds);

wire sys_clk;
wire [3:0] bcd_in;

assign leds = bcd_in;


clock_divider  inst1 (
	.clock_in  (clock_in),
	.reset   (~reset_clk),
	.clock_out (sys_clk));
	
DigitalLock_code digital_lock_inst (
	.sys_clk (sys_clk),
	.reset   (~sys_reset),
	.w       (w),
	.F       (f_out),
	.led_out   (bcd_in)
);

bcd_code inst3 
(	.in(bcd_in),
	.out(out)
);

endmodule 