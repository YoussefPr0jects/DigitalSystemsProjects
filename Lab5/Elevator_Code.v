module Elevator_Code(
    input sys_clk,
    input sys_rst,
    output reg rst_5,
    output reg rst_2,
    output reg rst_8,
    input flag_5s,
    input flag_2s,
    input flag_8s,
    output reg Safeguard_status,
    output reg Red_led,
    output reg Green_led,
    output reg [3:0] state
);
reg [3:0] counter = 0;
parameter password1 = 123456;
parameter password2 = 654321;
parameter password3 = 111111;
parameter password4 = 999999;
parameter password5 = 000000;
parameter WaitingForEnterOrCtrlPlusValue=1;
parameter WaitingFor6Key=2;
parameter CheckKey=3;
parameter OpenSafeguard=4;
parameter NotValid=5;
always @(posedge sys_clk)

begin
if(sys_rst)
begin
    rst_5<=0;
    rst_2<=0;
    rst_8<=0;
    counter <= 0;
    Safeguard_status <=0; //sagefuard is closed = 0
end
else
	case(state)

	WaitingForEnterOrCtrlPlusValue: //1
        begin 
        Safeguard_status <= 0;
        if(EnterPress || CtrlPress)
         begin
            state<= WaitingFor6Key;
        end
        else  
        begin
            state<= WaitingForEnterOrCtrlPlusValue;
        end
    end

    WaitingFor6Key: begin //2
        rst_2<=1; 
        if(counter == 6) 
        begin //receive next values
            counter <=0; //reset the counter since we dont need it anymore
            rst_2<=0;
            state<= CheckKey
        end
        else if(counter != 6 && !flag_2s)
        begin
            counter<= counter+1;
        end
        else if(flag_2s) //took more than 2 seconds between each input...
        begin
            rst_2<=0;
            state<= WaitingForEnterOrCtrlPlusValue;
        end
    end

    CheckKey: begin //3
            if(input_seq == password1 || input_seq == password2 || input_seq == password3 || input_seq == password4 || input_seq == password5)
            begin
            Safeguard_status = 1; //Open the safeguard
            state<= OpenSafeguard;
            end
            else
            state<= NotValid;
    end

    OpenSafeguard: begin //4
        rst_8<=1; 
        if (flag_8s)
        begin
        rst_8 <=0;
        state<= WaitingForEnterOrCtrlPlusValue;
        end
    end

    NotValid: begin //5
    rst_5<=1;
    Safeguard_status <= 2; //Wrong password...
    if(flag_5s)
    begin
        rst_5<=0;
        state<= WaitingForEnterOrCtrlPlusValue;
    end
    end

    endcase
    end
endmodule




        

