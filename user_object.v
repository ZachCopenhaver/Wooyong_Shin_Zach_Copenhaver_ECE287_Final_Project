module user_object(
	input clk,
	input rst, 
	input [9:0]x, 
	input [9:0]y, 
	input left_gun, // input to move the object left
	input right_gun, // input to move the object right
	input up_gun,     // input to move the object up
	input down_gun,	// input to move the object down
	input [9:0]xstart, // x coordinate of the upper left corner of the object's starting position
	input [9:0]ystart, // y coordinate of the upper left corner of the object's starting position
	input [9:0]xdiff, // x width of the object
	input [9:0]ydiff, // y height of the object
	input [9:0]xspeed, // how fast the object moves horizontally
	input [9:0]yspeed, // how fast the object moves vertically
	input [9:0]right_bound, // how far to the right the object can move
	input [9:0]left_bound, // how far to the left the object can move
	input [9:0]top_bound, // how far up the object can move
	input [9:0]bottom_bound, // how far down the object can move
	output reg objectx, // = 1 when x is within the object
	output reg objecty,  // = 1 when y is within the object
	output reg [9:0]xl,
	output reg [9:0]yt
);
	
	reg [2:0]S;
	reg [2:0]NS;
	
	parameter START = 3'd0,
				 INIT = 3'd1,
				 DRAW = 3'd2,
				 ERROR = 3'hF;
	
	always @ (posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
			S <= START;
		else
			S <= NS;
	end
	
	always @ (*)
	begin
		case (S)
			START: NS = INIT;
			INIT: NS = DRAW;
			DRAW: 
			if (slowClock == 1'b1)
				NS = INIT;
			else
				NS = DRAW;
			default: NS = ERROR;
		endcase
	end
	
	always @ (posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			xl <= 10'd0;
			yt <= 10'd0;
		end
		else 
			case (S)
				START: 
				begin
					xl <= xstart;
					yt <= ystart;
				end
				INIT:
				begin
					// if both inputs are on
					if (right_gun == 1'b1 && left_gun == 1'b1)
					begin
						objectx <= (xstart <= x & x < (xstart+xdiff));
						xl <= xl; // stop
					end
					// if the right input is on
					else if (right_gun == 1'b1)
					begin
						// if user hits right bound
						if (xl >= right_bound - xdiff)
						begin
							objectx <= (xstart <= x & x < (xstart+xdiff));
							xl <= xl; // stop
						end
						else 
						begin
							objectx <= (xstart <= x & x < (xstart+xdiff));
							xl <= xl + xspeed; // move right
						end
					end
					// if the left input is on
					else if (left_gun == 1'b1)
					begin
						// if user hits left bound
						if (xl <= left_bound)
						begin
							objectx <= (xstart <= x & x < (xstart+xdiff));
							xl <= xl; // stop
						end
						else
						begin
							objectx <= (xstart <= x & x < (xstart+xdiff));
							xl <= xl - xspeed; // move left
						end
					end
					// if neither are on
					else
					begin
						objectx <= (xstart <= x & x < (xstart+xdiff));
						xl <= xl; // stop
					end	
		
		
					// if both inputs are on
					if (up_gun == 1'b1 && down_gun == 1'b1)
					begin
						objecty <= (ystart <= y & y < (ystart+ydiff));
						yt <= yt; // stop
					end
					// if the right input is on
					else if (up_gun == 1'b1)
					begin
						// if user hits right bound
						if (yt >= bottom_bound - ydiff)
						begin
							objecty <= (ystart <= y & y < (ystart+ydiff));
							yt <= yt; // stop
						end
						else 
						begin
							objecty <= (ystart <= y & y < (ystart+ydiff));
							yt <= yt + yspeed; // move right
						end
					end
					// if the left input is on
					else if (down_gun == 1'b1)
					begin
						// if user hits left bound
						if (yt <= top_bound)
						begin
							objecty <= (ystart <= y & y < (ystart+ydiff));
							yt <= yt; // stop
						end
						else
						begin
							objecty <= (ystart <= y & y < (ystart+ydiff));
							yt <= yt - yspeed; // move left
						end
					end
					// if neither are on
					else
					begin
						objecty <= (ystart <= y & y < (ystart+ydiff));
						yt <= yt; // stop
					end
				end
				DRAW: 
				begin
					objectx <= (xl <= x & x < xl + xdiff);
					objecty <= (yt <= y & y < yt + ydiff);
				end
			endcase
	end
	
	reg [31:0]counter;
	reg slowClock;
	
	// slows down the clock so that we can see the object moving
	always @(posedge clk)
	begin
		counter <= counter + 1'b1;
		if (counter >= 32'd2500000)
		begin
			counter <= 32'd0;
			slowClock <= 1'b1;
		end
		else 
			slowClock = 1'b0;
	end
endmodule