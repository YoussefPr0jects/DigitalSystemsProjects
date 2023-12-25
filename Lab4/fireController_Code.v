module fireController_Code(
  input [4:0] S,                // Temperature sensor input (0-30°C)
  input power,                 // Main power switch input (0 - OFF, 1 - ON)
  input [4:0] T,               // User-set target temperature (0-30°C)
  output reg fireplace,        // Fireplace control (0 - OFF, 1 - ON)
  output reg fan,              // Fan control (0 - OFF, 1 - ON)
  output reg [3:0] Digit1,     
  output reg [3:0] Digit2,     
  output reg [3:0] Digit11,    
  output reg [3:0] Digit22     
);

  always @(*) begin
    // Check if the power is ON and the room temperature is below the target
    if (power == 0 || S >= T) begin
      fireplace = 0;  // Fireplace is OFF
    end else  begin
      fireplace = 1;  // Fireplace is ON
    end

    // Check if the fireplace is ON and the room temperature is over 15°C
    if (fireplace == 1 && S > 15) begin
      fan = 1;  // Fan is ON
    end else begin
      fan = 0;  // Fan is OFF
    end
  end

  always @(*) begin
    // Extract the first and second digits of the temperature sensor value
    Digit1 = S % 10;
    Digit2 = S / 10;

    // Display the second sensor digit on the 7-segment display
    if (Digit2 == 3) begin
      Digit1 = 0;
    end

    // Extract the first and second digits of the target temperature value
    Digit11 = T % 10;
    Digit22 = T / 10;

    // Display the second target temperature digit on the 7-segment display
    if (Digit22 == 3) begin
      Digit11 = 0;
    end
  end
endmodule
