module clock_divider (
	input  wire iCLK,
	input  wire reset,
	output reg  iRST_N
);
	
	reg [31:0] counter;
	
	always @ (posedge iCLK) 
	begin
		if (reset) begin
			counter <= 32'd0;
			iRST_N <= 1'b0;
		end else begin 
			counter <= counter + 32'd1;
			
			if (counter == 32'd24999999) 
			begin
				iRST_N <= ~iRST_N;
				counter <= 32'd0;
			end 
		end 
	end 
	
endmodule