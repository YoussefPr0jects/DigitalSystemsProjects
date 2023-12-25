module DigitalLock_code(
	input sys_clk,
	input reset,
	input w,
	output reg F,
	output reg [3:0] state,
	output wire[2:0] led_out
);


parameter idle_state = 0;
parameter S1 = 1;
parameter S2 = 2;
parameter S3 = 3;
parameter S4 = 4;
parameter S5 = 5;
parameter S6 = 6;
parameter S7 = 7;
parameter S8 = 8;


assign led_out = (state>S4)?{state[3],state[1:0]}:state[2:0];
always @ (posedge sys_clk)
begin
	if (reset)
	begin
		state <= idle_state;
		F <= 0;

	end else 
	begin
		case(state)
			idle_state: begin
				F <= 0;
				if (w)
					state <= S5;
				else
					state <= S1;	
				end 
			S1 : begin
				F <= 0;
				if (w)
					state <= S5;
				else
					state <= S2;	
			end
			S2 : begin
				F <= 0;
				if (w)
					state <= S5;
				else
					state <= S3;	
			end
			S3 : begin
				F <= 0;
				if (w)
					state <= S5;
				else
					state <= S4;	
			end
			S4 : begin
				F <= 1;
				if (w)
					state <= S5;
				else
					state <= S4;	
			end
			S5 : begin
				F <= 0;
				if (w)
					state <= S6;
				else
					state <= S1;	
			end
			S6 : begin
				F <= 0;
				if (w)
					state <= S7;
				else
					state <= S1;	
			end
			S7 : begin
				F <= 0;
				if (w)
					state <= S8;
				else
					state <= S1;	
			end
			S8 : begin
				F <= 1;
				if (w)
					state <= S8;
				else
					state <= S1;	
			end

			default: begin
				F <= 0;
				state <= idle_state;
			end
			
		endcase
	end 
end  


endmodule 