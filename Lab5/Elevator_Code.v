module Elevator_Code(
    input sys_clk,
    input sys_rst,
    input valid,
    input [2:0] SW,
    output reg rst_1,
    output reg rst_2,
    output reg rst_4,
    input flag_1s,
    input flag_2s,
    input flag_4s,
    output reg Door_status,
    output reg[2:0] current_floor,
    output reg [3:0] state
);

parameter System_waiting_for_valid =1;
parameter Close_door_return=2;
parameter Check_Door_status=3;
parameter Open_door_before_moving=4;
parameter Close_door=5;
parameter Move=6;
parameter Floor_reached=7;
reg [2:0] NF = 0;
always @(posedge sys_clk)

begin
if(sys_rst)
begin
    current_floor<=0;
    NF<=0;
    state<=System_waiting_for_valid;
    rst_1<=0;
    rst_2<=0;
    rst_4<=0;
    Door_status <=0; //open is 0
end
else
	case(state)

	System_waiting_for_valid: //1
        begin 
        rst_2<=1;
        if(!valid)
         begin
            rst_2<=0;
            NF<=SW;
            state<= Check_Door_status;
        end
        else if(flag_2s) 
        begin
            state<= Close_door_return;
        end
    end

    Check_Door_status: begin //3
        rst_1<=1; 
        if(Door_status == 0 && flag_1s) 
        begin // door open, close it
            rst_1<=0;
            state<= Close_door;
        end
        else if(Door_status == 1 && flag_1s)//door closed, open it
        begin
            rst_1<=0;
            state<= Open_door_before_moving;
        end
    end

    Close_door_return: begin //2
        rst_1<=1; 
        if(flag_1s)
        begin
            rst_1<=0;
            state<= System_waiting_for_valid;
            Door_status <= 1;
        end
    end

    Move: begin //6
        rst_4<=1; 
        if(current_floor>NF)
        begin
            if(flag_4s)
            current_floor<=current_floor-1;
        end
        else if(current_floor<NF)
        begin
            if(flag_4s)
            current_floor<=current_floor+1;
        end
        else 
        begin
            rst_4<=0; 
            state<= Floor_reached;
        end
    end

    Open_door_before_moving: begin //4
    rst_1<=1;
    if(flag_1s)
    begin
        rst_1<=0;
        state<= Close_door;
        Door_status <= 0;
    end
    end

    Floor_reached: begin //7
    rst_1<=1;
    if(flag_1s)
    begin
        rst_1<=0;
        state<= System_waiting_for_valid;
        Door_status <= 0;
    end
    end

    Close_door: begin //5
    rst_1<=1;
    if(flag_1s)
    begin
        rst_1<=0;
        state<= Move;
        Door_status <= 1;
    end
    end
    endcase
    end
endmodule




        

