module Top_level_FirePlaceController(
  input [4:0] S,                
  input power,                 
  input [4:0] T,               
  output fireplace,        
  output fan,               
  output [6:0]  Sensor1,
  output [6:0]  Sensor2,
  output [6:0]  SetTemp1,
  output [6:0]  SetTemp2
  );

  wire [6:0] Digit1;
   wire [6:0] Digit2;
	 wire [6:0] Digit11;
	  wire [6:0] Digit22;
	  
fireController_Code inst98 (
	.S (S),
	.power(power),
	.T(T),
	.fireplace(fireplace),
	.fan(fan),
	.Digit1(Digit1),
	.Digit2(Digit2),
	.Digit11(Digit11),
	.Digit22(Digit22)
);

bcd_code inst11
(	.in(Digit1),
	.out(Sensor1)
);
bcd_code inst12
(	.in(Digit2),
	.out(Sensor2)
);
bcd_code inst13
(	.in(Digit11),
	.out(SetTemp1)
);
bcd_code inst14
(	.in(Digit22),
	.out(SetTemp2)
);
endmodule 