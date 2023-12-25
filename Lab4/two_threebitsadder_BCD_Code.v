module two_threebitsadder_BCD_Code (
  input [2:0] I1,   
  input [2:0] I2,   
  output wire [3:0] O
);

wire [3:0] sum; // Declare a wire for the sum

assign sum = I1 + I2; // Perform the addition and store it in the wire

assign O = sum; // Assign the wire value to the output
endmodule

