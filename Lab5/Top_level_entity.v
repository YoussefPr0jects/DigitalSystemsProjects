module Top_level_entity(
    input valid,
    input sys_rst,
    input sys_clk,
    input  [2:0] SW,
output [7:0] LCD_DATA,
output LCD_RW,
output LCD_EN,
output LCD_RS,
output [6:0] BCD1,
output [6:0] BCD2
);
wire flag_1s;
wire flag_2s;
wire flag_4s;
wire rst_1;
wire rst_2;
wire rst_4;
wire Door_status;
wire [2:0] current_floor;
wire iRST_N;
wire [3:0] state;

pulse_generator  inst1 (
	.sys_clk  (sys_clk),
	.rst_1 (rst_1),
	.rst_2 (rst_2),
    .rst_4 (rst_4),
    .flag_1s (flag_1s),
    .flag_2s (flag_2s),
    .flag_4s (flag_4s)
    );
Elevator_Code   inst2(
    .valid(valid),
    .sys_rst(sys_rst),
    .sys_clk(sys_clk),
    .SW(SW),
    .flag_1s(flag_1s),
    .flag_2s(flag_2s),
    .flag_4s(flag_4s),
    .rst_1(rst_1),
    .rst_2(rst_2),
    .rst_4(rst_4),
    .Door_status(Door_status),
    .current_floor(current_floor),
	.state(state)
);

LCD_TEST        inst3(
    .Door_status(Door_status),
    .current_floor(current_floor),
	.LCD_EN(LCD_EN),
	.LCD_RS(LCD_RS),
	.LCD_RW(LCD_RW),
	.LCD_DATA(LCD_DATA),
	.iRST_N(iRST_N),
	.iCLK(sys_clk) 
);

clock_divider inst4(
.reset (sys_rst),
.iCLK(sys_clk),
.iRST_N(iRST_N)
);

bcd_code inst5(
.in(Door_status),
.out(BCD1)
);

bcd_code inst6(
.in(state),
.out(BCD2)
);
endmodule