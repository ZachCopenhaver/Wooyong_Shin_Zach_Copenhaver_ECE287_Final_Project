module game_time(
	input clk,
	input rst, 
	input [17:0]enemy1_dead,
	input [17:0]enemy2_dead,
	input [17:0]enemy3_dead,
	input [17:0]enemy4_dead,
	input [17:0]enemy5_dead,
	input [17:0]enemy6_dead, 
	input [17:0]enemy7_dead, 
	output [6:0]seg7_dig0,
	output [6:0]seg7_dig1,
	output [6:0]seg7_dig2,
	output reg game_over,
	output reg [9:0]seconds,
	output reg victory
);

	three_decimal_vals_w_neg time_display(seconds, seg7_dig0, seg7_dig1, seg7_dig2);
	
	reg [31:0]count;

	reg [3:0]S;
	reg [3:0]NS;
	
	parameter	START = 4'd0,
					COUNTDOWN = 4'd1,
					DECREASE = 4'd2,
					GAME_OVER = 4'd3,
					ERROR = 4'hF;
					
	always @ (posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
			S <= START;
		else 
			S <= NS;
	end
	
	always @(*)
	begin
		case (S)
			START: NS = COUNTDOWN;
			COUNTDOWN:
				if (count == 32'd50000000)
					NS = DECREASE;
				else 
					NS = COUNTDOWN;
			DECREASE: 
				if (seconds == 10'd1)
					NS = GAME_OVER;
				else 
					NS = COUNTDOWN;
			default: NS = ERROR;
		endcase
	end
	
	always @ (posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			count <= 32'd0;
			seconds <= 10'd0;
			game_over <= 1'b0;
			victory <= 1'b0;
		end
		else 
		begin
			case (S)
				START: 
				begin
					count <= 32'd0;
					seconds <= 10'd60;
					game_over <= 1'b0;
					victory <= 1'b0;
				end
				COUNTDOWN:
				begin
					count <= count + 1'b1;
				end
				DECREASE: 
				begin
					count <= 32'd0;
					seconds <= seconds - 1'b1;
					if ((enemy1_dead != 1'b0) & (enemy2_dead != 1'b0) & (enemy3_dead != 1'b0) & (enemy4_dead != 1'b0) & (enemy5_dead != 1'b0) & (enemy6_dead != 1'b0) & (enemy7_dead != 1'b0) )
						victory <= 1'b1;
					else 
						victory <= 1'b0;
				end
				GAME_OVER: game_over <= 1'b1;
			endcase
		end
	end
	
endmodule 