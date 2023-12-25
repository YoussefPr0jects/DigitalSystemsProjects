module pulse_generator(
    input sys_clk,
    input rst_1, 
    input rst_2, 
    input rst_4,
    output reg flag_1s,
    output reg flag_2s,
    output reg flag_4s
);
reg [31:0] counter_1s, counter_2s, counter_4s;
	
	always @ (posedge sys_clk) 
	begin
		if (rst_1 == 0) begin
			counter_1s <= 32'd0;
            flag_1s <= 1'b0;
		end 
        else begin
            counter_1s <= counter_1s + 32'd1;
			
			if (counter_1s == 32'd49999999) 
			begin
				flag_1s <= 1;
				counter_1s <= 32'd0;
			end

            if (flag_1s) 
                flag_1s <= 0;
        end 
        if (rst_2 == 0) begin
			counter_2s <= 32'd0;
            flag_2s <= 1'b0;
		end 
        else begin
            counter_2s <= counter_2s + 32'd1;
			
			if (counter_2s == 32'd99999999) 
			begin
				flag_2s <= 1;
				counter_2s <= 32'd0;
			end
			
            if (flag_2s) 
                flag_2s <= 0;
        end 
        if (rst_4 == 0) begin
			counter_4s <= 32'd0;
            flag_4s <= 1'b0;
		end 
        else begin
            counter_4s <= counter_4s + 32'd1;
			
			if (counter_4s == 32'd199999999) 
			begin
				flag_4s <= 1;
				counter_4s <= 32'd0;
			end
			
            if (flag_4s) 
                flag_4s <= 0;
        end 
      
	end 
    endmodule