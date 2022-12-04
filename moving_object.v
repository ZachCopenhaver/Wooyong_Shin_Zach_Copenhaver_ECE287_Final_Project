module moving_object(
	input clk,
	input rst,
	input [9:0]x, // output of vga
	input [9:0]y, // output of vga
	input [9:0]xl_target,
	input [9:0]yt_target,
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
	input [17:0]is_dead,
	input shoot, // input to activate shooting
	output reg objectx, // = 1 when x is within the object
	output reg objecty,  // = 1 when y is within the object
	output reg dead,
	output reg deathx,
	output reg deathy
);

	reg [9:0]xl, yt;
	reg go_right; // 0 means moving left, 1 means moving right
	reg go_down; // 0 means moving up, 1 means moving down
	
	reg [2:0]S;
	reg [2:0]NS;
	
	parameter START = 3'd0,
				 INIT = 3'd1,
				 DRAW = 3'd2,
				 DEAD = 3'd3,
				 DEAD2 = 3'd4,
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
				if ((xl_target <= xl & xl < xl_target + 10'd8) & (yt_target <= yt & yt < yt_target + 10'd8) & (shoot == 1'b1))
					NS = DEAD;
				else if ((is_dead & 18'b111111111111111111) == 18'd0)
					if (slowClock == 1'b1)
						NS = INIT;
					else
						NS = DRAW;				
				else
					NS = DEAD;
			DEAD: 
				if (slowClock2 == 1'b1)
					NS = DEAD2;
				else
					NS = DEAD;
			DEAD2: NS = DEAD2;
			default: NS = ERROR;
		endcase
	end
	
	always @ (posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			xl <= 10'd0;
			yt <= 10'd0;
			dead <= 1'b0;
			go_right <= 1'b0;
			go_down <= 1'b0;
		end
		else 
			case (S)
				START: 
				begin
					xl <= xstart;
					yt <= ystart;
					go_right <= 1'b1;
					go_down <= 1'b1;
					dead <= 1'b0;
				end
				INIT:
				begin
					// if the object hits the right side of the screen
					if (xl >= (right_bound - xdiff))
					begin
						go_right <= 1'b0; // the object is now moving to the left
						objectx <= (xstart <= x & x < (xstart+xdiff));
						xl <= xl - xspeed; // move left
					end
					// if the object approaches the left side of the screen
					// need to check if x is within a certain range because xl might overflow when it hits the wall
					else if (xl <= left_bound)
					begin
						go_right <= 1'b1; // the object is now moving to the right
						objectx <= (xstart <= x & x < (xstart+xdiff));
						xl <= xl + xspeed; // move right
					end
					// if the object is moving to the right
					else if (go_right == 1'b1)
					begin
						objectx <= (xstart <= x & x < (xstart+xdiff));
						xl <= xl + xspeed; // move right
					end
					// if the object is moving to the left
					else if (go_right == 1'b0)
					begin
						objectx <= (xstart <= x & x < (xstart+xdiff));
						xl <= xl - xspeed; // move left
					end
					
					// this set of if statements is basically the same as above except with vertical movement instead
					if (yt >= (bottom_bound - ydiff))
					begin
						go_down <= 1'b0;
						objecty <= (ystart <= y & y < (ystart+ydiff));
						yt <= yt - yspeed;
					end
					else if (yt <= top_bound)
					begin
						go_down <= 1'b1;
						objecty <= (ystart <= y & y < (ystart+ydiff));
						yt <= yt + yspeed;
					end
					else if (go_down == 1'b1)
					begin
						objecty <= (ystart <= y & y < (ystart+ydiff));
						yt <= yt + yspeed;
					end
					else if (go_down == 1'b0)
					begin
						objecty <= (ystart <= y & y < (ystart+ydiff));
						yt <= yt - yspeed;
					end	
				end
				DRAW: 
				begin
					objectx <= (xl <= x & x < xl + xdiff);
					objecty <= (yt <= y & y < yt + ydiff);
				end
				DEAD:
				begin
					objectx <= 1'b0;
					objecty <= 1'b0;
					deathx <= (xl <= x & x < xl + xdiff);
					deathy <= (yt <= y & y < yt + xdiff);
					dead <= 1'b1;
				end
				DEAD2:
				begin
					deathx <= 1'b0;
					deathy <= 1'b0;
					dead <= 1'b1;
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
	
	reg [31:0]counter2;
	reg slowClock2;
	
	// slows down the clock so that we can see the object moving
	always @(posedge clk)
	begin
		counter2 <= counter2 + 1'b1;
		if (counter2 >= 32'd50000000)
		begin
			counter2 <= 32'd0;
			slowClock2 <= 1'b1;
		end
		else 
			slowClock2 = 1'b0;
	end
endmodule 