module game(
	input Right_Gun,
	input Left_Gun,
	input up_gun,
	input down_gun,
	input Shoot, // check if player is shooting
	input clk,
	input rst,
	output [28:0]vga_output_data,
	output [6:0]seg7_dig0,
	output [6:0]seg7_dig1, 
	output [6:0]seg7_dig2
);

	game_time timer(clk, rst, enemy1_dead, enemy2_dead, enemy3_dead,enemy4_dead, enemy5_dead, enemy6_dead, enemy7_dead, seg7_dig0, seg7_dig1, seg7_dig2, game_over, seconds, victory);
						
	wire [9:0]seconds;	
	wire game_over;

	wire [9:0]x, y;
	reg [23:0]color; // single variable to store the colors
	// color[23:16] = r; color[15:8] = g; color[7:0] = b;
	
	// parameters for common colors
	parameter white  	= 24'b111111111111111111111111,
				 black  	= 24'b000000000000000000000000,
				 red 	  	= 24'b111111110000000000000000,
				 green  	= 24'b000000001111111100000000,
				 blue   	= 24'b000000000000000011111111,
				 yellow 	= 24'b111111111111111100000000,
				 pink		= 24'b111111110000000011111111,
				 cyan		= 24'b000000001111111111111111;
				 
	// define the size of the platform
	wire platform1x, platform1y;
	assign platform1x = (10'd50 <= x & x < 10'd590);
	assign platform1y = (10'd340 <= y & y < 10'd360);
	
	wire platform2x, platform2y;
	assign platform2x = (10'd25 <= x & x < 10'd615);
	assign platform2y = (10'd360 <= y & y < 10'd380);
	
	wire platform3x, platform3y;
	assign platform3x = (10'd0 <= x & x < 10'd640);
	assign platform3y = (10'd380 <= y & y < 10'd480);
	
	wire platform4x, platform4y;
	assign platform4x = (10'd0 <= x & x < 10'd220);
	assign platform4y = (10'd390 <= y & y < 10'd400);
	
	wire platform5x, platform5y;
	assign platform5x = (10'd220 <= x & x < 10'd420);
	assign platform5y = (10'd380 <= y & y < 10'd390);
	
	wire platform6x, platform6y;
	assign platform6x = (10'd420 <= x & x < 10'd640);
	assign platform6y = (10'd390 <= y & y < 10'd400);
	
	//-----------------------------------------------
	
	wire targetcenterx, targetcentery;
	wire [9:0]targetc_xl, targetc_yt;
	wire target1x, target1y;
	wire [9:0]target1_xl, target1_yt;
	wire target2x, target2y;
	wire [9:0]target2_xl, target2_yt;
	wire target3x, target3y;
	wire [9:0]target3_xl, target3_yt;
	wire target4x, target4y;
	wire [9:0]target4_xl, target4_yt;
	wire target5x, target5y;
	wire [9:0]target5_xl, target5_yt;
	wire target6x, target6y;
	wire [9:0]target6_xl, target6_yt;
	wire target7x, target7y;
	wire [9:0]target7_xl, target7_yt;
	wire target8x, target8y;
	wire [9:0]target8_xl, target8_yt;
	
	//--------------------------------------------
	// the death variables are used to draw the "explosion"
	
	wire [17:0]enemy1_dead; // this variable is used to check if an enemy is dead
	// when a part of the enemy is hit, the corresponding bit in this bus goes to 1
	// if this bus contains any 1s then the enemy is dead.
	
	wire aeyeball1x, aeyeball1y, death1x, death1y;
	wire aeyeball2x, aeyeball2y, death2x, death2y;
	wire aeyeball3x, aeyeball3y, death3x, death3y;
	
	wire aeyeleftx, aeyelefty, death4x, death4y;
	wire aeyecenterx, aeyecentery, death5x, death5y;
	wire aeyerightx, aeyerighty, death6x, death6y;
	
	wire ahead1x, ahead1y, death7x, death7y;
	wire ahead2x, ahead2y, death8x, death8y;
	wire ahead3x, ahead3y, death9x, death9y;
	wire ahead4x, ahead4y, death10x, death10y;
	
	wire aleg1x, aleg1y, death11x, death11y;
	wire aleg2x, aleg2y, death12x, death12y;
	wire aleg3x, aleg3y, death13x, death13y;
	wire aleg4x, aleg4y, death14x, death14y;
	wire aleg5x, aleg5y, death15x, death15y;
	wire aleg6x, aleg6y, death16x, death16y;
	wire aleg7x, aleg7y, death17x, death17y;
	wire aleg8x, aleg8y, death18x, death18y;
	
	//--------------------------------------------
	
	wire [17:0]enemy2_dead;
	
	wire beyeball1x, beyeball1y, death21x, death21y;
	wire beyeball2x, beyeball2y, death22x, death22y;
	wire beyeball3x, beyeball3y, death23x, death23y;
	
	wire beyeleftx, beyelefty, death24x, death24y;
	wire beyecenterx, beyecentery, death25x, death25y;
	wire beyerightx, beyerighty, death26x, death26y;
	
	wire bhead1x, bhead1y, death27x, death27y;
	wire bhead2x, bhead2y, death28x, death28y;
	wire bhead3x, bhead3y, death29x, death29y;
	wire bhead4x, bhead4y, death30x, death30y;
	
	wire bleg1x, bleg1y, death31x, death31y;
	wire bleg2x, bleg2y, death32x, death32y;
	wire bleg3x, bleg3y, death33x, death33y;
	wire bleg4x, bleg4y, death34x, death34y;
	wire bleg5x, bleg5y, death35x, death35y;
	wire bleg6x, bleg6y, death36x, death36y;
	wire bleg7x, bleg7y, death37x, death37y;
	wire bleg8x, bleg8y, death38x, death38y;
	
	//--------------------------------------------
	
	wire [17:0]enemy3_dead;
	
	wire ceyeball1x, ceyeball1y, death41x, death41y;
	wire ceyeball2x, ceyeball2y, death42x, death42y;
	wire ceyeball3x, ceyeball3y, death43x, death43y;
	
	wire ceyeleftx, ceyelefty, death44x, death44y;
	wire ceyecenterx, ceyecentery, death45x, death45y;
	wire ceyerightx, ceyerighty, death46x, death46y;
	
	wire chead1x, chead1y, death47x, death47y;
	wire chead2x, chead2y, death48x, death48y;
	wire chead3x, chead3y, death49x, death49y;
	wire chead4x, chead4y, death50x, death50y;
	
	wire cleg1x, cleg1y, death51x, death51y;
	wire cleg2x, cleg2y, death52x, death52y;
	wire cleg3x, cleg3y, death53x, death53y;
	wire cleg4x, cleg4y, death54x, death54y;
	wire cleg5x, cleg5y, death55x, death55y;
	wire cleg6x, cleg6y, death56x, death56y;
	wire cleg7x, cleg7y, death57x, death57y;
	wire cleg8x, cleg8y, death58x, death58y;
	
	//----------------------------------------------
	
	wire [17:0]enemy4_dead;
	
	wire deyeball1x, deyeball1y, death61x, death61y;
	wire deyeball2x, deyeball2y, death62x, death62y;
	wire deyeball3x, deyeball3y, death63x, death63y;
	
	wire deyeleftx, deyelefty, death64x, death64y;
	wire deyecenterx, deyecentery, death65x, death65y;
	wire deyerightx, deyerighty, death66x, death66y;
	
	wire dhead1x, dhead1y, death67x, death67y;
	wire dhead2x, dhead2y, death68x, death68y;
	wire dhead3x, dhead3y, death69x, death69y;
	wire dhead4x, dhead4y, death70x, death70y;
	
	wire dleg1x, dleg1y, death71x, death71y;
	wire dleg2x, dleg2y, death72x, death72y;
	wire dleg3x, dleg3y, death73x, death73y;
	wire dleg4x, dleg4y, death74x, death74y;
	wire dleg5x, dleg5y, death75x, death75y;
	wire dleg6x, dleg6y, death76x, death76y;
	wire dleg7x, dleg7y, death77x, death77y;
	wire dleg8x, dleg8y, death78x, death78y;
	
	//----------------------------------------------
	
	wire [17:0]enemy5_dead;
	
	wire eeyeball1x, eeyeball1y, death81x, death81y;
	wire eeyeball2x, eeyeball2y, death82x, death82y;
	wire eeyeball3x, eeyeball3y, death83x, death83y;
	
	wire eeyeleftx, eeyelefty, death84x, death84y;
	wire eeyecenterx, eeyecentery, death85x, death85y;
	wire eeyerightx, eeyerighty, death86x, death86y;
	
	wire ehead1x, ehead1y, death87x, death87y;
	wire ehead2x, ehead2y, death88x, death88y;
	wire ehead3x, ehead3y, death89x, death89y;
	wire ehead4x, ehead4y, death90x, death90y;
	
	wire eleg1x, eleg1y, death91x, death91y;
	wire eleg2x, eleg2y, death92x, death92y;
	wire eleg3x, eleg3y, death93x, death93y;
	wire eleg4x, eleg4y, death94x, death94y;
	wire eleg5x, eleg5y, death95x, death95y;
	wire eleg6x, eleg6y, death96x, death96y;
	wire eleg7x, eleg7y, death97x, death97y;
	wire eleg8x, eleg8y, death98x, death98y;
	
	//----------------------------------------------
	
	wire [17:0]enemy6_dead;
	
	wire feyeball1x, feyeball1y, death101x, death101y;
	wire feyeball2x, feyeball2y, death102x, death102y;
	wire feyeball3x, feyeball3y, death103x, death103y;
	
	wire feyeleftx, feyelefty, death104x, death104y;
	wire feyecenterx, feyecentery, death105x, death105y;
	wire feyerightx, feyerighty, death106x, death106y;
	
	wire fhead1x, fhead1y, death107x, death107y;
	wire fhead2x, fhead2y, death108x, death108y;
	wire fhead3x, fhead3y, death109x, death109y;
	wire fhead4x, fhead4y, death110x, death110y;
	
	wire fleg1x, fleg1y, death111x, death111y;
	wire fleg2x, fleg2y, death112x, death112y;
	wire fleg3x, fleg3y, death113x, death113y;
	wire fleg4x, fleg4y, death114x, death114y;
	wire fleg5x, fleg5y, death115x, death115y;
	wire fleg6x, fleg6y, death116x, death116y;
	wire fleg7x, fleg7y, death117x, death117y;
	wire fleg8x, fleg8y, death118x, death118y;
	
	//----------------------------------------------
	
	wire [17:0]enemy7_dead;
	
	wire geyeball1x, geyeball1y, death121x, death121y;
	wire geyeball2x, geyeball2y, death122x, death122y;
	wire geyeball3x, geyeball3y, death123x, death123y;
	
	wire geyeleftx, geyelefty, death124x, death124y;
	wire geyecenterx, geyecentery, death125x, death125y;
	wire geyerightx, geyerighty, death126x, death126y;
	
	wire ghead1x, ghead1y, death127x, death127y;
	wire ghead2x, ghead2y, death128x, death128y;
	wire ghead3x, ghead3y, death129x, death129y;
	wire ghead4x, ghead4y, death130x, death130y;
	
	wire gleg1x, gleg1y, death131x, death131y;
	wire gleg2x, gleg2y, death132x, death132y;
	wire gleg3x, gleg3y, death133x, death133y;
	wire gleg4x, gleg4y, death134x, death134y;
	wire gleg5x, gleg5y, death135x, death135y;
	wire gleg6x, gleg6y, death136x, death136y;
	wire gleg7x, gleg7y, death137x, death137y;
	wire gleg8x, gleg8y, death138x, death138y;
	
	//----------------------------------------------
	
	wire gunbodyL1x, gunbodyL1y;
	wire [9:0]gunbodyL1_xl, gunbodyL1_yt;
	wire gunbodyL2x, gunbodyL2y;
	wire [9:0]gunbodyL2_xl, gunbodyL2_yt;
	wire gunbodyL3x, gunbodyL3y;
	wire [9:0]gunbodyL3_xl, gunbodyL3_yt;
	wire gunbodyL4x, gunbodyL4y;
	wire [9:0]gunbodyL4_xl, gunbodyL4_yt;
	wire gunbodyL5x, gunbodyL5y;
	wire [9:0]gunbodyL5_xl, gunbodyL5_yt;
	
   wire  gunhead1x, gunhead1y;
	wire [9:0]gunhead1_xl, gunhead1_yt;
	wire gunhead2x, gunhead2y;
	wire [9:0]gunhead2_xl, gunhead2_yt;
	wire gunhead3x, gunhead3y;
	wire [9:0]gunhead3_xl, gunhead3_yt;
	wire gunhead4x, gunhead4y;
	wire [9:0]gunhead4_xl, gunhead4_yt;
	wire gunhead5x, gunhead5y;
	wire [9:0]gunhead5_xl, gunhead5_yt;
	wire gunhead6x, gunhead6y;
	wire [9:0]gunhead6_xl, gunhead6_yt;
	wire gunhead7x, gunhead7y;
	wire [9:0]gunhead7_xl, gunhead7_yt;
	wire gunhead8x, gunhead8y;
	wire [9:0]gunhead8_xl, gunhead8_yt;
	wire gunhead9x, gunhead9y;
	wire [9:0]gunhead9_xl, gunhead9_yt;
	
	wire aimx, aimy;
	wire [9:0]aim_xl, aim_yt;
	
	wire gunbodyR1x, gunbodyR1y;
	wire [9:0]gunbodyR1_xl, gunbodyR1_yt;
	wire gunbodyR2x, gunbodyR2y;
	wire [9:0]gunbodyR2_xl, gunbodyR2_yt;
	wire gunbodyR3x, gunbodyR3y;
	wire [9:0]gunbodyR3_xl, gunbodyR3_yt;
	wire gunbodyR4x, gunbodyR4y;
	wire [9:0]gunbodyR4_xl, gunbodyR4_yt;
	wire gunbodyR5x, gunbodyR5y;
	wire [9:0]gunbodyR5_xl, gunbodyR5_yt;
	
	//-------------------------------------
	
	//game over screen
	wire G1x, G1y;
		assign G1x=(10'd17 <= x & x < 10'd117);
		assign G1y=(10'd200 <= y & y < 10'd208);
	wire G2x, G2y;
		assign G2x=(10'd17 <= x & x < 10'd25);
		assign G2y=(10'd200 <= y & y < 10'd328);
	wire G3x, G3y;
		assign G3x=(10'd17 <= x & x < 10'd117);
		assign G3y=(10'd328 <= y & y < 10'd336);
	wire G4x, G4y;
		assign G4x=(10'd109 <= x & x < 10'd117);
		assign G4y=(10'd264 <= y & y < 10'd328);	
	wire G5x, G5y;
		assign G5x=(10'd85 <= x & x < 10'd117);
		assign G5y=(10'd264 <= y & y < 10'd272);
		
	wire a1x, a1y;
		assign a1x=(10'd133 <= x & x < 10'd181);
		assign a1y=(10'd280 <= y & y < 10'd288);
	wire a2x, a2y;
		assign a2x=(10'd133 <= x & x < 10'd141);
		assign a2y=(10'd280 <= y & y < 10'd336);
	wire a3x, a3y;
		assign a3x=(10'd133 <= x & x < 10'd197);
		assign a3y=(10'd328 <= y & y < 10'd336);
	wire a4x, a4y;
		assign a4x=(10'd173 <= x & x < 10'd181);
		assign a4y=(10'd280 <= y & y < 10'd336);
		
	wire m1x, m1y;
		assign m1x=(10'd205 <= x & x < 10'd261);
		assign m1y=(10'd280 <= y & y < 10'd288);
	wire m2x, m2y;
		assign m2x=(10'd205 <= x & x < 10'd213);
		assign m2y=(10'd280 <= y & y < 10'd336);
	wire m3x, m3y;
		assign m3x=(10'd229 <= x & x < 10'd237);
		assign m3y=(10'd280 <= y & y < 10'd328);
	wire m4x, m4y;
		assign m4x=(10'd253 <= x & x < 10'd261);
		assign m4y=(10'd280 <= y & y < 10'd336);
		
	wire e1x, e1y;
		assign e1x=(10'd278 <= x & x < 10'd326);
		assign e1y=(10'd280 <= y & y < 10'd288);
	wire e2x, e2y;
		assign e2x=(10'd278 <= x & x < 10'd286);
		assign e2y=(10'd280 <= y & y < 10'd336);
	wire e3x, e3y;
		assign e3x=(10'd278 <= x & x < 10'd326);
		assign e3y=(10'd304 <= y & y < 10'd312);
	wire e4x, e4y;
		assign e4x=(10'd278 <= x & x < 10'd326);
		assign e4y=(10'd328 <= y & y < 10'd336);
	wire e5x, e5y;
		assign e5x=(10'd318 <= x & x < 10'd326);
		assign e5y=(10'd280 <= y & y < 10'd304);
	
	
	wire O1x, O1y;
		assign O1x=(10'd390 <= x & x < 10'd470);
		assign O1y=(10'd200 <= y & y < 10'd208);
	wire O2x, O2y;
		assign O2x=(10'd390 <= x & x < 10'd398);
		assign O2y=(10'd200 <= y & y < 10'd328);
	wire O3x, O3y;
		assign O3x=(10'd390 <= x & x < 10'd470);
		assign O3y=(10'd328 <= y & y < 10'd336);
	wire O4x, O4y;
		assign O4x=(10'd462 <= x & x < 10'd470);
		assign O4y=(10'd200 <= y & y < 10'd328);
	
	wire v1x, v1y;
		assign v1x=(10'd486 <= x & x < 10'd494);
		assign v1y=(10'd280 <= y & y < 10'd328);
	wire v2x, v2y;
		assign v2x=(10'd494 <= x & x < 10'd510);
		assign v2y=(10'd328 <= y & y < 10'd336);
	wire v3x, v3y;
		assign v3x=(10'd510 <= x & x < 10'd518);
		assign v3y=(10'd280 <= y & y < 10'd328);
	
	wire e11x, e11y;
		assign e11x=(10'd534 <= x & x < 10'd582);
		assign e11y=(10'd280 <= y & y < 10'd288);
	wire e12x, e12y;
		assign e12x=(10'd534 <= x & x < 10'd542);
		assign e12y=(10'd280 <= y & y < 10'd336);
	wire e13x, e13y;
		assign e13x=(10'd534 <= x & x < 10'd582);
		assign e13y=(10'd304 <= y & y < 10'd312);
	wire e14x, e14y;
		assign e14x=(10'd534 <= x & x < 10'd582);
		assign e14y=(10'd328 <= y & y < 10'd336);
	wire e15x, e15y;
		assign e15x=(10'd574 <= x & x < 10'd582);
		assign e15y=(10'd280 <= y & y < 10'd304);
		
	wire r1x, r1y;
		assign r1x=(10'd598 <= x & x < 10'd606);
		assign r1y=(10'd280 <= y & y < 10'd336);
	wire r2x, r2y;
		assign r2x=(10'd606 <= x & x < 10'd614);
		assign r2y=(10'd312 <= y & y < 10'd320);
	wire r3x, r3y;
		assign r3x=(10'd614 <= x & x < 10'd622);
		assign r3y=(10'd304 <= y & y < 10'd312);
	wire r4x, r4y;
		assign r4x=(10'd622 <= x & x < 10'd630);
		assign r4y=(10'd296 <= y & y < 10'd304);
		
	//------------------------------------------	
	// stars
	wire star1x, star1y;
		assign star1x=(10'd50 <= x & x < 10'd54);
		assign star1y=(10'd50 <= y & y < 10'd54);
	wire star2x, star2y;
		assign star2x=(10'd100 <= x & x < 10'd104);
		assign star2y=(10'd20 <= y & y < 10'd24);
	wire star3x, star3y;
		assign star3x=(10'd250 <= x & x < 10'd254);
		assign star3y=(10'd70 <= y & y < 10'd74);
	wire star4x, star4y;
		assign star4x=(10'd370 <= x & x < 10'd374);
		assign star4y=(10'd90 <= y & y < 10'd94);
	wire star5x, star5y;
		assign star5x=(10'd500 <= x & x < 10'd504);
		assign star5y=(10'd80 <= y & y < 10'd84);
	wire star6x, star6y;
		assign star6x=(10'd662 <= x & x < 10'd666);
		assign star6y=(10'd62 <= y & y < 10'd66);
	wire star7x, star7y;
		assign star7x=(10'd120 <= x & x < 10'd124);
		assign star7y=(10'd100 <= y & y < 10'd104);
	wire star8x, star8y;
		assign star8x=(10'd232 <= x & x < 10'd236);
		assign star8y=(10'd126 <= y & y < 10'd130);
	wire star9x, star9y;
		assign star9x=(10'd320 <= x & x < 10'd324);
		assign star9y=(10'd132 <= y & y < 10'd136);
	wire star10x, star10y;
		assign star10x=(10'd480 <= x & x < 10'd484);
		assign star10y=(10'd100 <= y & y < 10'd104);
	wire star11x, star11y;
		assign star11x=(10'd630 <= x & x < 10'd634);
		assign star11y=(10'd149 <= y & y < 10'd153);
	wire star12x, star12y;
		assign star12x=(10'd50 <= x & x < 10'd54);
		assign star12y=(10'd240 <= y & y < 10'd244);
	wire star13x, star13y;
		assign star13x=(10'd102 <= x & x < 10'd106);
		assign star13y=(10'd300 <= y & y < 10'd304);
	wire star14x, star14y;
		assign star14x=(10'd264 <= x & x < 10'd268);
		assign star14y=(10'd294 <= y & y < 10'd298);
	wire star15x, star15y;
		assign star15x=(10'd540 <= x & x < 10'd544);
		assign star15y=(10'd290 <= y & y < 10'd294);
	
	//------------------------------------------------
	//assign victory screen
	wire victoryv1x, victoryv1y;
		assign victoryv1x=(10'd40 <= x & x < 10'd47);
		assign victoryv1y=(10'd200 <= y & y < 10'd291);
	wire victoryv2x, victoryv2y;
		assign victoryv2x=(10'd47 <= x & x < 10'd54);
		assign victoryv2y=(10'd291 <= y & y < 10'd305);
	wire victoryv3x, victoryv3y;
		assign victoryv3x=(10'd54 <= x & x < 10'd75);
		assign victoryv3y=(10'd305 <= y & y < 10'd312);
	wire victoryv4x, victoryv4y;
		assign victoryv4x=(10'd75 <= x & x < 10'd82);
		assign victoryv4y=(10'd291 <= y & y < 10'd305);
	wire victoryv5x, victoryv5y;
		assign victoryv5x=(10'd82 <= x & x < 10'd89);
		assign victoryv5y=(10'd200 <= y & y < 10'd291);
		
	
	wire victoryi1x, victoryi1y;
		assign victoryi1x=(10'd110 <= x & x < 10'd145);
		assign victoryi1y=(10'd200 <= y & y < 10'd207);
	wire victoryi2x, victoryi2y;
		assign victoryi2x=(10'd124 <= x & x < 10'd131);
		assign victoryi2y=(10'd200 <= y & y < 10'd312);
	wire victoryi3x, victoryi3y;
		assign victoryi3x=(10'd110 <= x & x < 10'd145);
		assign victoryi3y=(10'd305 <= y & y < 10'd312);
		
	
	wire victoryc1x, victoryc1y;
		assign victoryc1x=(10'd166 <= x & x < 10'd222);
		assign victoryc1y=(10'd200 <= y & y < 10'd207);
	wire victoryc2x, victoryc2y;
		assign victoryc2x=(10'd166 <= x & x < 10'd173);
		assign victoryc2y=(10'd200 <= y & y < 10'd312);
	wire victoryc3x, victoryc3y;
		assign victoryc3x=(10'd166 <= x & x < 10'd222);
		assign victoryc3y=(10'd305 <= y & y < 10'd312);
	
	
	wire victoryt1x, victoryt1y;
		assign victoryt1x=(10'd243 <= x & x < 10'd320);
		assign victoryt1y=(10'd200 <= y & y < 10'd208);
	wire victoryt2x, victoryt2y;
		assign victoryt2x=(10'd278 <= x & x < 10'd285);
		assign victoryt2y=(10'd200 <= y & y < 10'd312);
		
	
	wire victoryo1x, victoryo1y;
		assign victoryo1x=(10'd341 <= x & x < 10'd418);
		assign victoryo1y=(10'd200 <= y & y < 10'd207);
	wire victoryo2x, victoryo2y;
		assign victoryo2x=(10'd341 <= x & x < 10'd348);
		assign victoryo2y=(10'd200 <= y & y < 10'd312);
	wire victoryo3x, victoryo3y;
		assign victoryo3x=(10'd341 <= x & x < 10'd418);
		assign victoryo3y=(10'd305 <= y & y < 10'd312);
	wire victoryo4x, victoryo4y;
		assign victoryo4x=(10'd411 <= x & x < 10'd418);
		assign victoryo4y=(10'd200 <= y & y < 10'd312);
		
	
	wire victoryr1x, victoryr1y;
		assign victoryr1x=(10'd439 <= x & x < 10'd502);
		assign victoryr1y=(10'd200 <= y & y < 10'd207);
	wire victoryr2x, victoryr2y;
		assign victoryr2x=(10'd439 <= x & x < 10'd446);
		assign victoryr2y=(10'd200 <= y & y < 10'd312);
	wire victoryr3x, victoryr3y;
		assign victoryr3x=(10'd439 <= x & x < 10'd516);
		assign victoryr3y=(10'd249 <= y & y < 10'd257);
	wire victoryr4x, victoryr4y;
		assign victoryr4x=(10'd495 <= x & x < 10'd502);
		assign victoryr4y=(10'd200 <= y & y < 10'd249);
	wire victoryr5x, victoryr5y;
		assign victoryr5x=(10'd509 <= x & x < 10'd516);
		assign victoryr5y=(10'd249 <= y & y < 10'd312);
		
		
	wire victoryy1x, victoryy1y;
		assign victoryy1x=(10'd537 <= x & x < 10'd544);
		assign victoryy1y=(10'd200 <= y & y < 10'd263);
	wire victoryy2x, victoryy2y;
		assign victoryy2x=(10'd537 <= x & x < 10'd593);
		assign victoryy2y=(10'd256 <= y & y < 10'd263);
	wire victoryy3x, victoryy3y;
		assign victoryy3x=(10'd587 <= x & x < 10'd593);
		assign victoryy3y=(10'd200 <= y & y < 10'd263);
	wire victoryy4x, victoryy4y;
		assign victoryy4x=(10'd565 <= x & x < 10'd572);
		assign victoryy4y=(10'd263 <= y & y < 10'd312);
		
	//--------------------------------------------------
	// assign get ready screen
	wire getreadyg1x, getreadyg1y;
		assign getreadyg1x=(10'd20 <= x & x < 10'd156);
		assign getreadyg1y=(10'd100 <= y & y < 10'd108);
	wire getreadyg2x, getreadyg2y;
		assign getreadyg2x=(10'd20 <= x & x < 10'd28);
		assign getreadyg2y=(10'd100 <= y & y < 10'd220);
	wire getreadyg3x, getreadyg3y;
		assign getreadyg3x=(10'd20 <= x & x < 10'd156);
		assign getreadyg3y=(10'd212 <= y & y < 10'd220);
	wire getreadyg4x, getreadyg4y;
		assign getreadyg4x=(10'd148 <= x & x < 10'd156);
		assign getreadyg4y=(10'd164 <= y & y < 10'd220);
	wire getreadyg5x, getreadyg5y;
		assign getreadyg5x=(10'd108 <= x & x < 10'd156);
		assign getreadyg5y=(10'd164 <= y & y < 10'd172);
		
	wire getreadye1x, getreadye1y;
		assign getreadye1x=(10'd172 <= x & x < 10'd284);
		assign getreadye1y=(10'd100 <= y & y < 10'd108);
	wire getreadye2x, getreadye2y;
		assign getreadye2x=(10'd172 <= x & x < 10'd180);
		assign getreadye2y=(10'd100 <= y & y < 10'd220);
	wire getreadye3x, getreadye3y;
		assign getreadye3x=(10'd172 <= x & x < 10'd284);
		assign getreadye3y=(10'd164 <= y & y < 10'd172);
	wire getreadye4x, getreadye4y;
		assign getreadye4x=(10'd172 <= x & x < 10'd284);
		assign getreadye4y=(10'd212 <= y & y < 10'd220);
		
	wire getreadyt1x, getreadyt1y;
		assign getreadyt1x=(10'd300 <= x & x < 10'd428);
		assign getreadyt1y=(10'd100 <= y & y < 10'd108);
	wire getreadyt2x, getreadyt2y;
		assign getreadyt2x=(10'd364 <= x & x < 10'd372);
		assign getreadyt2y=(10'd100 <= y & y < 10'd220);
		
	
	wire getreadyr1x, getreadyr1y;
		assign getreadyr1x=(10'd226 <= x & x < 10'd314);
		assign getreadyr1y=(10'd240 <= y & y < 10'd248);
	wire getreadyr2x, getreadyr2y;
		assign getreadyr2x=(10'd226 <= x & x < 10'd234);
		assign getreadyr2y=(10'd240 <= y & y < 10'd376);
	wire getreadyr3x, getreadyr3y;
		assign getreadyr3x=(10'd226 <= x & x < 10'd322);
		assign getreadyr3y=(10'd294 <= y & y < 10'd302);
	wire getreadyr4x, getreadyr4y;
		assign getreadyr4x=(10'd306 <= x & x < 10'd314);
		assign getreadyr4y=(10'd240 <= y & y < 10'd302);
	wire getreadyr5x, getreadyr5y;
		assign getreadyr5x=(10'd314 <= x & x < 10'd322);
		assign getreadyr5y=(10'd302 <= y & y < 10'd376);
		
		
	wire getreadye11x, getreadye11y;
		assign getreadye11x=(10'd338 <= x & x < 10'd426);
		assign getreadye11y=(10'd240 <= y & y < 10'd248);
	wire getreadye12x, getreadye12y;
		assign getreadye12x=(10'd338 <= x & x < 10'd346);
		assign getreadye12y=(10'd240 <= y & y < 10'd376);
	wire getreadye13x, getreadye13y;
		assign getreadye13x=(10'd338 <= x & x < 10'd418);
		assign getreadye13y=(10'd294 <= y & y < 10'd302);
	wire getreadye14x, getreadye14y;
		assign getreadye14x=(10'd338 <= x & x < 10'd426);
		assign getreadye14y=(10'd368 <= y & y < 10'd376);
		
	
	wire getreadya1x, getreadya1y;
		assign getreadya1x=(10'd450 <= x & x < 10'd498);
		assign getreadya1y=(10'd240 <= y & y < 10'd248);
	wire getreadya2x, getreadya2y;
		assign getreadya2x=(10'd450 <= x & x < 10'd458);
		assign getreadya2y=(10'd240 <= y & y < 10'd312);
	wire getreadya3x, getreadya3y;
		assign getreadya3x=(10'd442 <= x & x < 10'd506);
		assign getreadya3y=(10'd304 <= y & y < 10'd312);
	wire getreadya4x, getreadya4y;
		assign getreadya4x=(10'd490 <= x & x < 10'd498);
		assign getreadya4y=(10'd240 <= y & y < 10'd312);
	wire getreadya5x, getreadya5y;
		assign getreadya5x=(10'd442 <= x & x < 10'd450);
		assign getreadya5y=(10'd304 <= y & y < 10'd376);
	wire getreadya6x, getreadya6y;
		assign getreadya6x=(10'd498 <= x & x < 10'd506);
		assign getreadya6y=(10'd304 <= y & y < 10'd376);	
		
	
	wire getreadyd1x, getreadyd1y;
		assign getreadyd1x=(10'd522 <= x & x < 10'd570);
		assign getreadyd1y=(10'd240 <= y & y < 10'd248);
	wire getreadyd2x, getreadyd2y;
		assign getreadyd2x=(10'd522 <= x & x < 10'd530);
		assign getreadyd2y=(10'd240 <= y & y < 10'd376);
	wire getreadyd3x, getreadyd3y;
		assign getreadyd3x=(10'd522 <= x & x < 10'd570);
		assign getreadyd3y=(10'd368 <= y & y < 10'd376);
	wire getreadyd4x, getreadyd4y;
		assign getreadyd4x=(10'd570 <= x & x < 10'd578);
		assign getreadyd4y=(10'd248 <= y & y < 10'd368);
		
	wire getreadyy1x, getreadyy1y;
		assign getreadyy1x=(10'd594 <= x & x < 10'd602);
		assign getreadyy1y=(10'd240 <= y & y < 10'd294);
	wire getreadyy2x, getreadyy2y;
		assign getreadyy2x=(10'd594 <= x & x < 10'd630);
		assign getreadyy2y=(10'd286 <= y & y < 10'd294);
	wire getreadyy3x, getreadyy3y;
		assign getreadyy3x=(10'd622 <= x & x < 10'd630);
		assign getreadyy3y=(10'd240 <= y & y < 10'd294);
	wire getreadyy4x, getreadyy4y;
		assign getreadyy4x=(10'd608 <= x & x < 10'd616);
		assign getreadyy4y=(10'd294 <= y & y < 10'd376);
		
	//---------------------------------------------------
	
	vga disp(clk, rst, color[23:16], color[15:8], color[7:0], x, y, vga_output_data);
	
	// instantiations of the moving_object module to create the enemies
	moving_object aleg1(
		clk, 			
		rst, 			
		x, 
		y, 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd99, 	// xstart
		10'd76, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd618, 	// right_bound
		10'd13, 		// left_bound
		10'd36, 		// top_bound
		10'd212, 	// bottom_bound
		enemy1_dead,
		Shoot, // check if player is shooting
		aleg1x, 	// objectx
		aleg1y,		// objecty
		enemy1_dead[0],
		death1x,
		death1y
	);	
	moving_object aleg2(
		clk, 			
		rst, 			
		x, 
		y, 
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd97, 	// xstart
		10'd82, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd616, 	// right_bound
		10'd11, 		// left_bound
		10'd42, 		// top_bound
		10'd218, 	// bottom_bound
		enemy1_dead,
		Shoot, // check if player is shooting
		aleg2x, 	// objectx
		aleg2y,		// objecty
		enemy1_dead[1],
		death2x,
		death2y
	);								
	moving_object aleg3(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd106, 	// xstart
		10'd76, 	// ystart
		10'd2, 		// xdiff
		10'd11, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd624, 	// right_bound
		10'd20, 		// left_bound
		10'd36, 		// top_bound
		10'd215, 	// bottom_bound
		enemy1_dead,
		Shoot, // check if player is shooting
		aleg3x, 	// objectx
		aleg3y,		// objecty
		enemy1_dead[2],
		death3x,
		death3y
	);	
	moving_object aleg4(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd104, 	// xstart
		10'd85, 	// ystart
		10'd2, 		// xdiff
		10'd7, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd622, 	// right_bound
		10'd18, 		// left_bound
		10'd45, 		// top_bound
		10'd220, 	// bottom_bound
		enemy1_dead,
		Shoot, // check if player is shooting
		aleg4x, 	// objectx
		aleg4y,		// objecty
		enemy1_dead[3],
		death4x,
		death4y
	);								
	moving_object aleg5(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd115, 	// xstart
		10'd76, 	// ystart
		10'd2, 		// xdiff
		10'd10, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd633, 	// right_bound
		10'd29, 		// left_bound
		10'd36, 		// top_bound
		10'd214, 	// bottom_bound
		enemy1_dead,
		Shoot, // check if player is shooting
		aleg5x, 	// objectx
		aleg5y,		// objecty
		enemy1_dead[4],
		death5x,
		death5y
	);	
	moving_object aleg6(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd117, 	// xstart
		10'd84, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd635, 	// right_bound
		10'd31, 		// left_bound
		10'd44, 		// top_bound
		10'd220, 	// bottom_bound
		enemy1_dead,
		Shoot, // check if player is shooting
		aleg6x, 	// objectx
		aleg6y,		// objecty
		enemy1_dead[5],
		death6x,
		death6y
	);
	moving_object aleg7(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd118, 	// xstart
		10'd76, 	// ystart
		10'd2, 		// xdiff
		10'd5, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd636, 	// right_bound
		10'd32, 		// left_bound
		10'd36, 		// top_bound
		10'd209, 	// bottom_bound
		enemy1_dead,
		Shoot, // check if player is shooting
		aleg7x, 	// objectx
		aleg7y,		// objecty
		enemy1_dead[6],
		death7x,
		death7y
	);	
	moving_object aleg8(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd120, 	// xstart
		10'd79, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd638, 	// right_bound
		10'd34, 		// left_bound
		10'd39, 		// top_bound
		10'd217, 	// bottom_bound
		enemy1_dead,
		Shoot, // check if player is shooting
		aleg8x, 	// objectx
		aleg8y,		// objecty
		enemy1_dead[7],
		death8x,
		death8y
	);	
	
	moving_object aeyeball1(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd102, 	// xstart
		10'd67, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd621, 	// right_bound
		10'd16, 		// left_bound
		10'd27, 		// top_bound
		10'd197, 	// bottom_bound
		enemy1_dead,
		Shoot, // check if player is shooting
		aeyeball1x, 	// objectx
		aeyeball1y,		// objecty
		enemy1_dead[8],
		death9x,
		death9y
	);
	moving_object aeyeball2(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd108, 	// xstart
		10'd59, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd627, 	// right_bound
		10'd22, 		// left_bound
		10'd19, 		// top_bound
		10'd189, 	// bottom_bound
		enemy1_dead,
		Shoot, // check if player is shooting
		aeyeball2x, 	// objectx
		aeyeball2y,		// objecty
		enemy1_dead[9],
		death10x,
		death10y
	);
	moving_object aeyeball3(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd116, 	// xstart
		10'd67, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd635, 	// right_bound
		10'd30, 		// left_bound
		10'd27, 		// top_bound
		10'd197, 	// bottom_bound
		enemy1_dead,
		Shoot, // check if player is shooting
		aeyeball3x, 	// objectx
		aeyeball3y,		// objecty
		enemy1_dead[10],
		death11x,
		death11y
	);
	
	
	moving_object aeyeleft(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd100, 	// xstart
		10'd65, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd623, 	// right_bound
		10'd14, 		// left_bound
		10'd25, 		// top_bound
		10'd199, 	// bottom_bound
		enemy1_dead,
		Shoot, // check if player is shooting
		aeyeleftx, 	// objectx
		aeyelefty,		// objecty
		enemy1_dead[11],
		death12x,
		death12y
	);	
	moving_object aeyecenter(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd107, 	// xstart
		10'd57, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd630, 	// right_bound
		10'd21, 		// left_bound
		10'd17, 		// top_bound
		10'd191, 	// bottom_bound
		enemy1_dead,
		Shoot, // check if player is shooting
		aeyecenterx, 	// objectx
		aeyecentery,		// objecty
		enemy1_dead[12],
		death13x,
		death13y
	);	
	moving_object aeyeright(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd114, 	// xstart
		10'd65, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd637, 	// right_bound
		10'd28, 		// left_bound
		10'd25, 		// top_bound
		10'd199, 	// bottom_bound
		enemy1_dead,
		Shoot, // check if player is shooting
		aeyerightx, 	// objectx
		aeyerighty,		// objecty
		enemy1_dead[13],
		death14x,
		death14y
	);	
	
	moving_object ahead1(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd100, 	// xstart
		10'd50, 	// ystart
		10'd20, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd638, 	// right_bound
		10'd12, 		// left_bound
		10'd10, 		// top_bound
		10'd180, 	// bottom_bound
		enemy1_dead,
		Shoot, // check if player is shooting
		ahead1x, 	// objectx
		ahead1y,		// objecty
		enemy1_dead[14],
		death15x,
		death15y
	);		
	moving_object ahead2(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd98, 	// xstart
		10'd52, 	// ystart
		10'd24, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd639, 	// right_bound
		10'd11, 		// left_bound
		10'd12, 		// top_bound
		10'd182, 	// bottom_bound
		enemy1_dead,
		Shoot, // check if player is shooting
		ahead2x, 	// objectx
		ahead2y,		// objecty
		enemy1_dead[15],
		death16x,
		death16y
	);
	moving_object ahead3(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd96, 	// xstart
		10'd54, 	// ystart
		10'd28, 		// xdiff
		10'd20, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd640, 	// right_bound
		10'd10, 		// left_bound
		10'd14, 		// top_bound
		10'd202, 	// bottom_bound
		enemy1_dead,
		Shoot, // check if player is shooting
		ahead3x,// objectx
		ahead3y, // objecty
		enemy1_dead[16],
		death17x,
		death17y
	);		
	moving_object ahead4(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd98, 	// xstart
		10'd74, 	// ystart
		10'd24, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd639, 	// right_bound
		10'd11, 		// left_bound
		10'd34, 		// top_bound
		10'd204, 	// bottom_bound
		enemy1_dead,
		Shoot, // check if player is shooting
		ahead4x, 	// objectx
		ahead4y,		// objecty
		enemy1_dead[17],
		death18x,
		death18y
	);		
//-------------------------------------------------	
	moving_object bleg1(
		clk, 			
		rst, 			
		x, 
		y, 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd199, 	// xstart
		10'd176, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd618, 	// right_bound
		10'd13, 		// left_bound
		10'd36, 		// top_bound
		10'd212, 	// bottom_bound
		enemy2_dead,
		Shoot, // check if player is shooting
		bleg1x, 	// objectx
		bleg1y,		// objecty
		enemy2_dead[0],
		death21x,
		death21y
	);	
	moving_object bleg2(
		clk, 			
		rst, 			
		x, 
		y, 
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd197, 	// xstart
		10'd182, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd616, 	// right_bound
		10'd11, 		// left_bound
		10'd42, 		// top_bound
		10'd218, 	// bottom_bound
		enemy2_dead,
		Shoot, // check if player is shooting
		bleg2x, 	// objectx
		bleg2y,		// objecty
		enemy2_dead[1],
		death22x,
		death22y
	);								
	moving_object bleg3(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd206, 	// xstart
		10'd176, 	// ystart
		10'd2, 		// xdiff
		10'd11, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd624, 	// right_bound
		10'd20, 		// left_bound
		10'd36, 		// top_bound
		10'd215, 	// bottom_bound
		enemy2_dead,
		Shoot, // check if player is shooting
		bleg3x, 	// objectx
		bleg3y,		// objecty
		enemy2_dead[2],
		death23x,
		death23y
	);	
	moving_object bleg4(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd204, 	// xstart
		10'd185, 	// ystart
		10'd2, 		// xdiff
		10'd7, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd622, 	// right_bound
		10'd18, 		// left_bound
		10'd45, 		// top_bound
		10'd220, 	// bottom_bound
		enemy2_dead,
		Shoot, // check if player is shooting
		bleg4x, 	// objectx
		bleg4y,		// objecty
		enemy2_dead[3],
		death24x,
		death24y
	);								
	moving_object bleg5(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd215, 	// xstart
		10'd176, 	// ystart
		10'd2, 		// xdiff
		10'd10, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd633, 	// right_bound
		10'd29, 		// left_bound
		10'd36, 		// top_bound
		10'd214, 	// bottom_bound
		enemy2_dead,
		Shoot, // check if player is shooting
		bleg5x, 	// objectx
		bleg5y,		// objecty
		enemy2_dead[4],
		death25x,
		death25y
	);	
	moving_object bleg6(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd217, 	// xstart
		10'd184, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd635, 	// right_bound
		10'd31, 		// left_bound
		10'd44, 		// top_bound
		10'd220, 	// bottom_bound
		enemy2_dead,
		Shoot, // check if player is shooting
		bleg6x, 	// objectx
		bleg6y,		// objecty
		enemy2_dead[5],
		death26x,
		death26y
	);
	moving_object bleg7(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd218, 	// xstart
		10'd176, 	// ystart
		10'd2, 		// xdiff
		10'd5, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd636, 	// right_bound
		10'd32, 		// left_bound
		10'd36, 		// top_bound
		10'd209, 	// bottom_bound
		enemy2_dead,
		Shoot, // check if player is shooting
		bleg7x, 	// objectx
		bleg7y,		// objecty
		enemy2_dead[6],
		death27x,
		death27y
	);	
	moving_object bleg8(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd220, 	// xstart
		10'd179, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd638, 	// right_bound
		10'd34, 		// left_bound
		10'd39, 		// top_bound
		10'd217, 	// bottom_bound
		enemy2_dead,
		Shoot, // check if player is shooting
		bleg8x, 	// objectx
		bleg8y,		// objecty
		enemy2_dead[7],
		death28x,
		death28y
	);	
	
	moving_object beyeball1(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd202, 	// xstart
		10'd167, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd621, 	// right_bound
		10'd16, 		// left_bound
		10'd27, 		// top_bound
		10'd197, 	// bottom_bound
		enemy2_dead,
		Shoot, // check if player is shooting
		beyeball1x, 	// objectx
		beyeball1y,		// objecty
		enemy2_dead[8],
		death29x,
		death29y
	);
	moving_object beyeball2(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd208, 	// xstart
		10'd159, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd627, 	// right_bound
		10'd22, 		// left_bound
		10'd19, 		// top_bound
		10'd189, 	// bottom_bound
		enemy2_dead,
		Shoot, // check if player is shooting
		beyeball2x, 	// objectx
		beyeball2y,		// objecty
		enemy2_dead[9],
		death30x,
		death30y
	);
	moving_object beyeball3(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd216, 	// xstart
		10'd167, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd635, 	// right_bound
		10'd30, 		// left_bound
		10'd27, 		// top_bound
		10'd197, 	// bottom_bound
		enemy2_dead,
		Shoot, // check if player is shooting
		beyeball3x, 	// objectx
		beyeball3y,		// objecty
		enemy2_dead[10],
		death31x,
		death31y
	);
	
	
	moving_object beyeleft(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd200, 	// xstart
		10'd165, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd623, 	// right_bound
		10'd14, 		// left_bound
		10'd25, 		// top_bound
		10'd199, 	// bottom_bound
		enemy2_dead,
		Shoot, // check if player is shooting
		beyeleftx, 	// objectx
		beyelefty,		// objecty
		enemy2_dead[11],
		death32x,
		death32y
	);	
	moving_object beyecenter(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd207, 	// xstart
		10'd157, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd630, 	// right_bound
		10'd21, 		// left_bound
		10'd17, 		// top_bound
		10'd191, 	// bottom_bound
		enemy2_dead,
		Shoot, // check if player is shooting
		beyecenterx, 	// objectx
		beyecentery,		// objecty
		enemy2_dead[12],
		death33x,
		death33y
	);	
	moving_object beyeright(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd214, 	// xstart
		10'd165, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd637, 	// right_bound
		10'd28, 		// left_bound
		10'd25, 		// top_bound
		10'd199, 	// bottom_bound
		enemy2_dead,
		Shoot, // check if player is shooting
		beyerightx, 	// objectx
		beyerighty,		// objecty
		enemy2_dead[13],
		death34x,
		death34y
	);	
	
	moving_object bhead1(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd200, 	// xstart
		10'd150, 	// ystart
		10'd20, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd638, 	// right_bound
		10'd12, 		// left_bound
		10'd10, 		// top_bound
		10'd180, 	// bottom_bound
		enemy2_dead,
		Shoot, // check if player is shooting
		bhead1x, 	// objectx
		bhead1y,		// objecty
		enemy2_dead[14],
		death35x,
		death35y
	);		
	moving_object bhead2(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd198, 	// xstart
		10'd152, 	// ystart
		10'd24, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd639, 	// right_bound
		10'd11, 		// left_bound
		10'd12, 		// top_bound
		10'd182, 	// bottom_bound
		enemy2_dead,
		Shoot, // check if player is shooting
		bhead2x, 	// objectx
		bhead2y,		// objecty
		enemy2_dead[15],
		death36x,
		death36y
	);
	moving_object bhead3(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd196, 	// xstart
		10'd154, 	// ystart
		10'd28, 		// xdiff
		10'd20, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd640, 	// right_bound
		10'd10, 		// left_bound
		10'd14, 		// top_bound
		10'd202, 	// bottom_bound
		enemy2_dead,
		Shoot, // check if player is shooting
		bhead3x,// objectx
		bhead3y, // objecty
		enemy2_dead[16],
		death37x,
		death37y
	);		
	moving_object bhead4(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd198, 	// xstart
		10'd174, 	// ystart
		10'd24, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd639, 	// right_bound
		10'd11, 		// left_bound
		10'd34, 		// top_bound
		10'd204, 	// bottom_bound
		enemy2_dead,
		Shoot, // check if player is shooting
		bhead4x, 	// objectx
		bhead4y,		// objecty
		enemy2_dead[17],
		death38x,
		death38y
		);
//-----------------------------------------------	
	moving_object cleg1(
		clk, 			
		rst, 			
		x, 
		y, 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd499, 	// xstart
		10'd176, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd618, 	// right_bound
		10'd13, 		// left_bound
		10'd36, 		// top_bound
		10'd212, 	// bottom_bound
		enemy3_dead,
		Shoot, // check if player is shooting
		cleg1x, 	// objectx
		cleg1y,		// objecty
		enemy3_dead[0],
		death41x,
		death41y
	);	
	moving_object cleg2(
		clk, 			
		rst, 			
		x, 
		y, 
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd497, 	// xstart
		10'd182, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd616, 	// right_bound
		10'd11, 		// left_bound
		10'd42, 		// top_bound
		10'd218, 	// bottom_bound
		enemy3_dead,
		Shoot, // check if player is shooting
		cleg2x, 	// objectx
		cleg2y,		// objecty
		enemy3_dead[1],
		death42x,
		death42y
	);								
	moving_object cleg3(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd506, 	// xstart
		10'd176, 	// ystart
		10'd2, 		// xdiff
		10'd11, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd624, 	// right_bound
		10'd20, 		// left_bound
		10'd36, 		// top_bound
		10'd215, 	// bottom_bound
		enemy3_dead,
		Shoot, // check if player is shooting
		cleg3x, 	// objectx
		cleg3y,		// objecty
		enemy3_dead[2],
		death43x,
		death43y
	);	
	moving_object cleg4(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd504, 	// xstart
		10'd185, 	// ystart
		10'd2, 		// xdiff
		10'd7, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd622, 	// right_bound
		10'd18, 		// left_bound
		10'd45, 		// top_bound
		10'd220, 	// bottom_bound
		enemy3_dead,
		Shoot, // check if player is shooting
		cleg4x, 	// objectx
		cleg4y,		// objecty
		enemy3_dead[3],
		death44x,
		death44y
	);								
	moving_object cleg5(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd515, 	// xstart
		10'd176, 	// ystart
		10'd2, 		// xdiff
		10'd10, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd633, 	// right_bound
		10'd29, 		// left_bound
		10'd36, 		// top_bound
		10'd214, 	// bottom_bound
		enemy3_dead,
		Shoot, // check if player is shooting
		cleg5x, 	// objectx
		cleg5y,		// objecty
		enemy3_dead[4],
		death45x,
		death45y
	);	
	moving_object cleg6(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd517, 	// xstart
		10'd184, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd635, 	// right_bound
		10'd31, 		// left_bound
		10'd44, 		// top_bound
		10'd220, 	// bottom_bound
		enemy3_dead,
		Shoot, // check if player is shooting
		cleg6x, 	// objectx
		cleg6y,		// objecty
		enemy3_dead[5],
		death46x,
		death46y
	);
	moving_object cleg7(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd518, 	// xstart
		10'd176, 	// ystart
		10'd2, 		// xdiff
		10'd5, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd636, 	// right_bound
		10'd32, 		// left_bound
		10'd36, 		// top_bound
		10'd209, 	// bottom_bound
		enemy3_dead,
		Shoot, // check if player is shooting
		cleg7x, 	// objectx
		cleg7y,		// objecty
		enemy3_dead[6],
		death47x,
		death47y
	);	
	moving_object cleg8(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd520, 	// xstart
		10'd179, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd638, 	// right_bound
		10'd34, 		// left_bound
		10'd39, 		// top_bound
		10'd217, 	// bottom_bound
		enemy3_dead,
		Shoot, // check if player is shooting
		cleg8x, 	// objectx
		cleg8y,		// objecty
		enemy3_dead[7],
		death48x,
		death48y
	);	
	
	moving_object ceyeball1(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd502, 	// xstart
		10'd167, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd621, 	// right_bound
		10'd16, 		// left_bound
		10'd27, 		// top_bound
		10'd197, 	// bottom_bound
		enemy3_dead,
		Shoot, // check if player is shooting
		ceyeball1x, 	// objectx
		ceyeball1y,		// objecty
		enemy3_dead[8],
		death49x,
		death49y
	);
	moving_object ceyeball2(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd508, 	// xstart
		10'd159, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd627, 	// right_bound
		10'd22, 		// left_bound
		10'd19, 		// top_bound
		10'd189, 	// bottom_bound
		enemy3_dead,
		Shoot, // check if player is shooting
		ceyeball2x, 	// objectx
		ceyeball2y,		// objecty
		enemy3_dead[9],
		death50x,
		death50y
	);
	moving_object ceyeball3(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd516, 	// xstart
		10'd167, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd635, 	// right_bound
		10'd30, 		// left_bound
		10'd27, 		// top_bound
		10'd197, 	// bottom_bound
		enemy3_dead,
		Shoot, // check if player is shooting
		ceyeball3x, 	// objectx
		ceyeball3y,		// objecty
		enemy3_dead[10],
		death51x,
		death51y
	);
	
	
	moving_object ceyeleft(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd500, 	// xstart
		10'd165, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd623, 	// right_bound
		10'd14, 		// left_bound
		10'd25, 		// top_bound
		10'd199, 	// bottom_bound
		enemy3_dead,
		Shoot, // check if player is shooting
		ceyeleftx, 	// objectx
		ceyelefty,		// objecty
		enemy3_dead[11],
		death52x,
		death52y
	);	
	moving_object ceyecenter(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd507, 	// xstart
		10'd157, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd630, 	// right_bound
		10'd21, 		// left_bound
		10'd17, 		// top_bound
		10'd191, 	// bottom_bound
		enemy3_dead,
		Shoot, // check if player is shooting
		ceyecenterx, 	// objectx
		ceyecentery,		// objecty
		enemy3_dead[12],
		death53x,
		death53y
	);	
	moving_object ceyeright(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd514, 	// xstart
		10'd165, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd637, 	// right_bound
		10'd28, 		// left_bound
		10'd25, 		// top_bound
		10'd199, 	// bottom_bound
		enemy3_dead,
		Shoot, // check if player is shooting
		ceyerightx, 	// objectx
		ceyerighty,		// objecty
		enemy3_dead[13],
		death54x,
		death54y
	);	
	
	moving_object chead1(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd500, 	// xstart
		10'd150, 	// ystart
		10'd20, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd638, 	// right_bound
		10'd12, 		// left_bound
		10'd10, 		// top_bound
		10'd180, 	// bottom_bound
		enemy3_dead,
		Shoot, // check if player is shooting
		chead1x, 	// objectx
		chead1y,		// objecty
		enemy3_dead[14],
		death55x,
		death55y
	);		
	moving_object chead2(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd498, 	// xstart
		10'd152, 	// ystart
		10'd24, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd639, 	// right_bound
		10'd11, 		// left_bound
		10'd12, 		// top_bound
		10'd182, 	// bottom_bound
		enemy3_dead,
		Shoot, // check if player is shooting
		chead2x, 	// objectx
		chead2y,		// objecty
		enemy3_dead[15],
		death56x,
		death56y
	);
	moving_object chead3(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd496, 	// xstart
		10'd154, 	// ystart
		10'd28, 		// xdiff
		10'd20, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd640, 	// right_bound
		10'd10, 		// left_bound
		10'd14, 		// top_bound
		10'd202, 	// bottom_bound
		enemy3_dead,
		Shoot, // check if player is shooting
		chead3x,// objectx
		chead3y, // objecty
		enemy3_dead[16],
		death57x,
		death57y
	);		
	moving_object chead4(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd498, 	// xstart
		10'd174, 	// ystart
		10'd24, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd639, 	// right_bound
		10'd11, 		// left_bound
		10'd34, 		// top_bound
		10'd204, 	// bottom_bound
		enemy3_dead,
		Shoot, // check if player is shooting
		chead4x, 	// objectx
		chead4y,		// objecty
		enemy3_dead[17],
		death58x,
		death58y
		);
//-----------------------------------------------	
	moving_object dleg1(
		clk, 			
		rst, 			
		x, 
		y, 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd299, 	// xstart
		10'd76, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd618, 	// right_bound
		10'd13, 		// left_bound
		10'd36, 		// top_bound
		10'd212, 	// bottom_bound
		enemy4_dead,
		Shoot, // check if player is shooting
		dleg1x, 	// objectx
		dleg1y,		// objecty
		enemy4_dead[0],
		death61x,
		death61y
	);	
	moving_object dleg2(
		clk, 			
		rst, 			
		x, 
		y, 
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd297, 	// xstart
		10'd82, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd616, 	// right_bound
		10'd11, 		// left_bound
		10'd42, 		// top_bound
		10'd218, 	// bottom_bound
		enemy4_dead,
		Shoot, // check if player is shooting
		dleg2x, 	// objectx
		dleg2y,		// objecty
		enemy4_dead[1],
		death62x,
		death62y
	);								
	moving_object dleg3(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd306, 	// xstart
		10'd76, 	// ystart
		10'd2, 		// xdiff
		10'd11, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd624, 	// right_bound
		10'd20, 		// left_bound
		10'd36, 		// top_bound
		10'd215, 	// bottom_bound
		enemy4_dead,
		Shoot, // check if player is shooting
		dleg3x, 	// objectx
		dleg3y,		// objecty
		enemy4_dead[2],
		death63x,
		death63y
	);	
	moving_object dleg4(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd304, 	// xstart
		10'd85, 	// ystart
		10'd2, 		// xdiff
		10'd7, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd622, 	// right_bound
		10'd18, 		// left_bound
		10'd45, 		// top_bound
		10'd220, 	// bottom_bound
		enemy4_dead,
		Shoot, // check if player is shooting
		dleg4x, 	// objectx
		dleg4y,		// objecty
		enemy4_dead[3],
		death64x,
		death64y
	);								
	moving_object dleg5(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd315, 	// xstart
		10'd76, 	// ystart
		10'd2, 		// xdiff
		10'd10, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd633, 	// right_bound
		10'd29, 		// left_bound
		10'd36, 		// top_bound
		10'd214, 	// bottom_bound
		enemy4_dead,
		Shoot, // check if player is shooting
		dleg5x, 	// objectx
		dleg5y,		// objecty
		enemy4_dead[4],
		death65x,
		death65y
	);	
	moving_object dleg6(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd317, 	// xstart
		10'd84, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd635, 	// right_bound
		10'd31, 		// left_bound
		10'd44, 		// top_bound
		10'd220, 	// bottom_bound
		enemy4_dead,
		Shoot, // check if player is shooting
		dleg6x, 	// objectx
		dleg6y,		// objecty
		enemy4_dead[5],
		death66x,
		death66y
	);
	moving_object dleg7(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd318, 	// xstart
		10'd76, 	// ystart
		10'd2, 		// xdiff
		10'd5, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd636, 	// right_bound
		10'd32, 		// left_bound
		10'd36, 		// top_bound
		10'd209, 	// bottom_bound
		enemy4_dead,
		Shoot, // check if player is shooting
		dleg7x, 	// objectx
		dleg7y,		// objecty
		enemy4_dead[6],
		death67x,
		death67y
	);	
	moving_object dleg8(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd320, 	// xstart
		10'd79, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd638, 	// right_bound
		10'd34, 		// left_bound
		10'd39, 		// top_bound
		10'd217, 	// bottom_bound
		enemy4_dead,
		Shoot, // check if player is shooting
		dleg8x, 	// objectx
		dleg8y,		// objecty
		enemy4_dead[7],
		death68x,
		death68y
	);	
	
	moving_object deyeball1(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd302, 	// xstart
		10'd67, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd621, 	// right_bound
		10'd16, 		// left_bound
		10'd27, 		// top_bound
		10'd197, 	// bottom_bound
		enemy4_dead,
		Shoot, // check if player is shooting
		deyeball1x, 	// objectx
		deyeball1y,		// objecty
		enemy4_dead[8],
		death69x,
		death69y
	);
	moving_object deyeball2(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd308, 	// xstart
		10'd59, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd627, 	// right_bound
		10'd22, 		// left_bound
		10'd19, 		// top_bound
		10'd189, 	// bottom_bound
		enemy4_dead,
		Shoot, // check if player is shooting
		deyeball2x, 	// objectx
		deyeball2y,		// objecty
		enemy4_dead[9],
		death70x,
		death70y
	);
	moving_object deyeball3(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd316, 	// xstart
		10'd67, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd635, 	// right_bound
		10'd30, 		// left_bound
		10'd27, 		// top_bound
		10'd197, 	// bottom_bound
		enemy4_dead,
		Shoot, // check if player is shooting
		deyeball3x, 	// objectx
		deyeball3y,		// objecty
		enemy4_dead[10],
		death71x,
		death71y
	);
	
	
	moving_object deyeleft(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd300, 	// xstart
		10'd65, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd623, 	// right_bound
		10'd14, 		// left_bound
		10'd25, 		// top_bound
		10'd199, 	// bottom_bound
		enemy4_dead,
		Shoot, // check if player is shooting
		deyeleftx, 	// objectx
		deyelefty,		// objecty
		enemy4_dead[11],
		death72x,
		death72y
	);	
	moving_object deyecenter(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd307, 	// xstart
		10'd57, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd630, 	// right_bound
		10'd21, 		// left_bound
		10'd17, 		// top_bound
		10'd191, 	// bottom_bound
		enemy4_dead,
		Shoot, // check if player is shooting
		deyecenterx, 	// objectx
		deyecentery,		// objecty
		enemy4_dead[12],
		death73x,
		death73y
	);	
	moving_object deyeright(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd314, 	// xstart
		10'd65, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd637, 	// right_bound
		10'd28, 		// left_bound
		10'd25, 		// top_bound
		10'd199, 	// bottom_bound
		enemy4_dead,
		Shoot, // check if player is shooting
		deyerightx, 	// objectx
		deyerighty,		// objecty
		enemy4_dead[13],
		death74x,
		death74y
	);	
	
	moving_object dhead1(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd300, 	// xstart
		10'd50, 	// ystart
		10'd20, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd638, 	// right_bound
		10'd12, 		// left_bound
		10'd10, 		// top_bound
		10'd180, 	// bottom_bound
		enemy4_dead,
		Shoot, // check if player is shooting
		dhead1x, 	// objectx
		dhead1y,		// objecty
		enemy4_dead[14],
		death75x,
		death75y
	);		
	moving_object dhead2(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd298, 	// xstart
		10'd52, 	// ystart
		10'd24, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd639, 	// right_bound
		10'd11, 		// left_bound
		10'd12, 		// top_bound
		10'd182, 	// bottom_bound
		enemy4_dead,
		Shoot, // check if player is shooting
		dhead2x, 	// objectx
		dhead2y,		// objecty
		enemy4_dead[15],
		death76x,
		death76y
	);
	moving_object dhead3(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd296, 	// xstart
		10'd54, 	// ystart
		10'd28, 		// xdiff
		10'd20, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd640, 	// right_bound
		10'd10, 		// left_bound
		10'd14, 		// top_bound
		10'd202, 	// bottom_bound
		enemy4_dead,
		Shoot, // check if player is shooting
		dhead3x,// objectx
		dhead3y, // objecty
		enemy4_dead[16],
		death77x,
		death77y
	);		
	moving_object dhead4(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd298, 	// xstart
		10'd74, 	// ystart
		10'd24, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd639, 	// right_bound
		10'd11, 		// left_bound
		10'd34, 		// top_bound
		10'd204, 	// bottom_bound
		enemy4_dead,
		Shoot, // check if player is shooting
		dhead4x, 	// objectx
		dhead4y,		// objecty
		enemy4_dead[17],
		death78x,
		death78y
		);						
//---------------------------------------------------------------------	
	moving_object eleg1(
		clk, 			
		rst, 			
		x, 
		y, 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd99, 	// xstart
		10'd186, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd618, 	// right_bound
		10'd13, 		// left_bound
		10'd36, 		// top_bound
		10'd212, 	// bottom_bound
		enemy5_dead,
		Shoot, // check if player is shooting
		eleg1x, 	// objectx
		eleg1y,		// objecty
		enemy5_dead[0],
		death81x,
		death81y
	);	
	moving_object eleg2(
		clk, 			
		rst, 			
		x, 
		y, 
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd97, 	// xstart
		10'd192, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd616, 	// right_bound
		10'd11, 		// left_bound
		10'd42, 		// top_bound
		10'd218, 	// bottom_bound
		enemy5_dead,
		Shoot, // check if player is shooting
		eleg2x, 	// objectx
		eleg2y,		// objecty
		enemy5_dead[1],
		death82x,
		death82y
	);								
	moving_object eleg3(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd106, 	// xstart
		10'd186, 	// ystart
		10'd2, 		// xdiff
		10'd11, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd624, 	// right_bound
		10'd20, 		// left_bound
		10'd36, 		// top_bound
		10'd215, 	// bottom_bound
		enemy5_dead,
		Shoot, // check if player is shooting
		eleg3x, 	// objectx
		eleg3y,		// objecty
		enemy5_dead[2],
		death83x,
		death83y
	);	
	moving_object eleg4(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd104, 	// xstart
		10'd195, 	// ystart
		10'd2, 		// xdiff
		10'd7, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd622, 	// right_bound
		10'd18, 		// left_bound
		10'd45, 		// top_bound
		10'd220, 	// bottom_bound
		enemy5_dead,
		Shoot, // check if player is shooting
		eleg4x, 	// objectx
		eleg4y,		// objecty
		enemy5_dead[3],
		death84x,
		death84y
	);								
	moving_object eleg5(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd115, 	// xstart
		10'd186, 	// ystart
		10'd2, 		// xdiff
		10'd10, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd633, 	// right_bound
		10'd29, 		// left_bound
		10'd36, 		// top_bound
		10'd214, 	// bottom_bound
		enemy5_dead,
		Shoot, // check if player is shooting
		eleg5x, 	// objectx
		eleg5y,		// objecty
		enemy5_dead[4],
		death85x,
		death85y
	);	
	moving_object eleg6(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd117, 	// xstart
		10'd194, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd635, 	// right_bound
		10'd31, 		// left_bound
		10'd44, 		// top_bound
		10'd220, 	// bottom_bound
		enemy5_dead,
		Shoot, // check if player is shooting
		eleg6x, 	// objectx
		eleg6y,		// objecty
		enemy5_dead[5],
		death86x,
		death86y
	);
	moving_object eleg7(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd118, 	// xstart
		10'd186, 	// ystart
		10'd2, 		// xdiff
		10'd5, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd636, 	// right_bound
		10'd32, 		// left_bound
		10'd36, 		// top_bound
		10'd209, 	// bottom_bound
		enemy5_dead,
		Shoot, // check if player is shooting
		eleg7x, 	// objectx
		eleg7y,		// objecty
		enemy5_dead[6],
		death87x,
		death87y
	);	
	moving_object eleg8(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd120, 	// xstart
		10'd189, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd638, 	// right_bound
		10'd34, 		// left_bound
		10'd39, 		// top_bound
		10'd217, 	// bottom_bound
		enemy5_dead,
		Shoot, // check if player is shooting
		eleg8x, 	// objectx
		eleg8y,		// objecty
		enemy5_dead[7],
		death88x,
		death88y
	);	
	
	moving_object eeyeball1(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd102, 	// xstart
		10'd177, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd621, 	// right_bound
		10'd16, 		// left_bound
		10'd27, 		// top_bound
		10'd197, 	// bottom_bound
		enemy5_dead,
		Shoot, // check if player is shooting
		eeyeball1x, 	// objectx
		eeyeball1y,		// objecty
		enemy5_dead[8],
		death89x,
		death89y
	);
	moving_object eeyeball2(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd108, 	// xstart
		10'd169, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd627, 	// right_bound
		10'd22, 		// left_bound
		10'd19, 		// top_bound
		10'd189, 	// bottom_bound
		enemy5_dead,
		Shoot, // check if player is shooting
		eeyeball2x, 	// objectx
		eeyeball2y,		// objecty
		enemy5_dead[9],
		death90x,
		death90y
	);
	moving_object eeyeball3(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd116, 	// xstart
		10'd177, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd635, 	// right_bound
		10'd30, 		// left_bound
		10'd27, 		// top_bound
		10'd197, 	// bottom_bound
		enemy5_dead,
		Shoot, // check if player is shooting
		eeyeball3x, 	// objectx
		eeyeball3y,		// objecty
		enemy5_dead[10],
		death91x,
		death91y
	);
	
	
	moving_object eeyeleft(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd100, 	// xstart
		10'd175, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd623, 	// right_bound
		10'd14, 		// left_bound
		10'd25, 		// top_bound
		10'd199, 	// bottom_bound
		enemy5_dead,
		Shoot, // check if player is shooting
		eeyeleftx, 	// objectx
		eeyelefty,		// objecty
		enemy5_dead[11],
		death92x,
		death92y
	);	
	moving_object eeyecenter(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd107, 	// xstart
		10'd167, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd630, 	// right_bound
		10'd21, 		// left_bound
		10'd17, 		// top_bound
		10'd191, 	// bottom_bound
		enemy5_dead,
		Shoot, // check if player is shooting
		eeyecenterx, 	// objectx
		eeyecentery,		// objecty
		enemy5_dead[12],
		death93x,
		death93y
	);	
	moving_object eeyeright(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd114, 	// xstart
		10'd175, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd637, 	// right_bound
		10'd28, 		// left_bound
		10'd25, 		// top_bound
		10'd199, 	// bottom_bound
		enemy5_dead,
		Shoot, // check if player is shooting
		eeyerightx, 	// objectx
		eeyerighty,		// objecty
		enemy5_dead[13],
		death94x,
		death94y
	);	
	
	moving_object ehead1(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd100, 	// xstart
		10'd160, 	// ystart
		10'd20, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd638, 	// right_bound
		10'd12, 		// left_bound
		10'd10, 		// top_bound
		10'd180, 	// bottom_bound
		enemy5_dead,
		Shoot, // check if player is shooting
		ehead1x, 	// objectx
		ehead1y,		// objecty
		enemy5_dead[14],
		death95x,
		death95y
	);		
	moving_object ehead2(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd98, 	// xstart
		10'd162, 	// ystart
		10'd24, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd639, 	// right_bound
		10'd11, 		// left_bound
		10'd12, 		// top_bound
		10'd182, 	// bottom_bound
		enemy5_dead,
		Shoot, // check if player is shooting
		ehead2x, 	// objectx
		ehead2y,		// objecty
		enemy5_dead[15],
		death96x,
		death96y
	);
	moving_object ehead3(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd96, 	// xstart
		10'd164, 	// ystart
		10'd28, 		// xdiff
		10'd20, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd640, 	// right_bound
		10'd10, 		// left_bound
		10'd14, 		// top_bound
		10'd202, 	// bottom_bound
		enemy5_dead,
		Shoot, // check if player is shooting
		ehead3x,// objectx
		ehead3y, // objecty
		enemy5_dead[16],
		death97x,
		death97y
	);		
	moving_object ehead4(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd98, 	// xstart
		10'd184, 	// ystart
		10'd24, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd639, 	// right_bound
		10'd11, 		// left_bound
		10'd34, 		// top_bound
		10'd204, 	// bottom_bound
		enemy5_dead,
		Shoot, // check if player is shooting
		ehead4x, 	// objectx
		ehead4y,		// objecty
		enemy5_dead[17],
		death98x,
		death98y
		);					
//---------------------------------------------------------------------	
	moving_object fleg1(
		clk, 			
		rst, 			
		x, 
		y, 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd599, 	// xstart
		10'd176, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd618, 	// right_bound
		10'd13, 		// left_bound
		10'd36, 		// top_bound
		10'd212, 	// bottom_bound
		enemy6_dead,
		Shoot, // check if player is shooting
		fleg1x, 	// objectx
		fleg1y,		// objecty
		enemy6_dead[0],
		death101x,
		death101y
	);	
	moving_object fleg2(
		clk, 			
		rst, 			
		x, 
		y, 
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd597, 	// xstart
		10'd182, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd616, 	// right_bound
		10'd11, 		// left_bound
		10'd42, 		// top_bound
		10'd218, 	// bottom_bound
		enemy6_dead,
		Shoot, // check if player is shooting
		fleg2x, 	// objectx
		fleg2y,		// objecty
		enemy6_dead[1],
		death102x,
		death102y
	);								
	moving_object fleg3(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd606, 	// xstart
		10'd176, 	// ystart
		10'd2, 		// xdiff
		10'd11, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd624, 	// right_bound
		10'd20, 		// left_bound
		10'd36, 		// top_bound
		10'd215, 	// bottom_bound
		enemy6_dead,
		Shoot, // check if player is shooting
		fleg3x, 	// objectx
		fleg3y,		// objecty
		enemy6_dead[2],
		death103x,
		death103y
	);	
	moving_object fleg4(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd604, 	// xstart
		10'd185, 	// ystart
		10'd2, 		// xdiff
		10'd7, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd622, 	// right_bound
		10'd18, 		// left_bound
		10'd45, 		// top_bound
		10'd220, 	// bottom_bound
		enemy6_dead,
		Shoot, // check if player is shooting
		fleg4x, 	// objectx
		fleg4y,		// objecty
		enemy6_dead[3],
		death104x,
		death104y
	);								
	moving_object fleg5(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd615, 	// xstart
		10'd176, 	// ystart
		10'd2, 		// xdiff
		10'd10, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd633, 	// right_bound
		10'd29, 		// left_bound
		10'd36, 		// top_bound
		10'd214, 	// bottom_bound
		enemy6_dead,
		Shoot, // check if player is shooting
		fleg5x, 	// objectx
		fleg5y,		// objecty
		enemy6_dead[4],
		death105x,
		death105y
	);	
	moving_object fleg6(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd617, 	// xstart
		10'd184, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd635, 	// right_bound
		10'd31, 		// left_bound
		10'd44, 		// top_bound
		10'd220, 	// bottom_bound
		enemy6_dead,
		Shoot, // check if player is shooting
		fleg6x, 	// objectx
		fleg6y,		// objecty
		enemy6_dead[5],
		death106x,
		death106y
	);
	moving_object fleg7(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd618, 	// xstart
		10'd176, 	// ystart
		10'd2, 		// xdiff
		10'd5, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd636, 	// right_bound
		10'd32, 		// left_bound
		10'd36, 		// top_bound
		10'd209, 	// bottom_bound
		enemy6_dead,
		Shoot, // check if player is shooting
		fleg7x, 	// objectx
		fleg7y,		// objecty
		enemy6_dead[6],
		death107x,
		death107y
	);	
	moving_object fleg8(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd620, 	// xstart
		10'd179, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd638, 	// right_bound
		10'd34, 		// left_bound
		10'd39, 		// top_bound
		10'd217, 	// bottom_bound
		enemy6_dead,
		Shoot, // check if player is shooting
		fleg8x, 	// objectx
		fleg8y,		// objecty
		enemy6_dead[7],
		death108x,
		death108y
	);	
	
	moving_object feyeball1(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd602, 	// xstart
		10'd167, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd621, 	// right_bound
		10'd16, 		// left_bound
		10'd27, 		// top_bound
		10'd197, 	// bottom_bound
		enemy6_dead,
		Shoot, // check if player is shooting
		feyeball1x, 	// objectx
		feyeball1y,		// objecty
		enemy6_dead[8],
		death109x,
		death109y
	);
	moving_object feyeball2(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd608, 	// xstart
		10'd159, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd627, 	// right_bound
		10'd22, 		// left_bound
		10'd19, 		// top_bound
		10'd189, 	// bottom_bound
		enemy6_dead,
		Shoot, // check if player is shooting
		feyeball2x, 	// objectx
		feyeball2y,		// objecty
		enemy6_dead[9],
		death110x,
		death110y
	);
	moving_object feyeball3(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd616, 	// xstart
		10'd167, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd635, 	// right_bound
		10'd30, 		// left_bound
		10'd27, 		// top_bound
		10'd197, 	// bottom_bound
		enemy6_dead,
		Shoot, // check if player is shooting
		feyeball3x, 	// objectx
		feyeball3y,		// objecty
		enemy6_dead[10],
		death111x,
		death111y
	);
	
	
	moving_object feyeleft(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd600, 	// xstart
		10'd165, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd623, 	// right_bound
		10'd14, 		// left_bound
		10'd25, 		// top_bound
		10'd199, 	// bottom_bound
		enemy6_dead,
		Shoot, // check if player is shooting
		feyeleftx, 	// objectx
		feyelefty,		// objecty
		enemy6_dead[11],
		death112x,
		death112y
	);	
	moving_object feyecenter(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd607, 	// xstart
		10'd157, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd630, 	// right_bound
		10'd21, 		// left_bound
		10'd17, 		// top_bound
		10'd191, 	// bottom_bound
		enemy6_dead,
		Shoot, // check if player is shooting
		feyecenterx, 	// objectx
		feyecentery,		// objecty
		enemy6_dead[12],
		death113x,
		death113y
	);	
	moving_object feyeright(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd614, 	// xstart
		10'd165, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd637, 	// right_bound
		10'd28, 		// left_bound
		10'd25, 		// top_bound
		10'd199, 	// bottom_bound
		enemy6_dead,
		Shoot, // check if player is shooting
		feyerightx, 	// objectx
		feyerighty,		// objecty
		enemy6_dead[13],
		death114x,
		death114y
	);	
	
	moving_object fhead1(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd600, 	// xstart
		10'd150, 	// ystart
		10'd20, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd638, 	// right_bound
		10'd12, 		// left_bound
		10'd10, 		// top_bound
		10'd180, 	// bottom_bound
		enemy6_dead,
		Shoot, // check if player is shooting
		fhead1x, 	// objectx
		fhead1y,		// objecty
		enemy6_dead[14],
		death115x,
		death115y
	);		
	moving_object fhead2(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd598, 	// xstart
		10'd152, 	// ystart
		10'd24, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd639, 	// right_bound
		10'd11, 		// left_bound
		10'd12, 		// top_bound
		10'd182, 	// bottom_bound
		enemy6_dead,
		Shoot, // check if player is shooting
		fhead2x, 	// objectx
		fhead2y,		// objecty
		enemy6_dead[15],
		death116x,
		death116y
	);
	moving_object fhead3(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd596, 	// xstart
		10'd154, 	// ystart
		10'd28, 		// xdiff
		10'd20, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd640, 	// right_bound
		10'd10, 		// left_bound
		10'd14, 		// top_bound
		10'd202, 	// bottom_bound
		enemy6_dead,
		Shoot, // check if player is shooting
		fhead3x,// objectx
		fhead3y, // objecty
		enemy6_dead[16],
		death117x,
		death117y
	);		
	moving_object fhead4(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd598, 	// xstart
		10'd174, 	// ystart
		10'd24, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd639, 	// right_bound
		10'd11, 		// left_bound
		10'd34, 		// top_bound
		10'd204, 	// bottom_bound
		enemy6_dead,
		Shoot, // check if player is shooting
		fhead4x, 	// objectx
		fhead4y,		// objecty
		enemy6_dead[17],
		death118x,
		death118y
		);		
//---------------------------------------------------------------------	
	moving_object gleg1(
		clk, 			
		rst, 			
		x, 
		y, 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd199, 	// xstart
		10'd196, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd618, 	// right_bound
		10'd13, 		// left_bound
		10'd36, 		// top_bound
		10'd212, 	// bottom_bound
		enemy7_dead,
		Shoot, // check if player is shooting
		gleg1x, 	// objectx
		gleg1y,		// objecty
		enemy7_dead[0],
		death121x,
		death121y
	);	
	moving_object gleg2(
		clk, 			
		rst, 			
		x, 
		y, 
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd197, 	// xstart
		10'd202, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd616, 	// right_bound
		10'd11, 		// left_bound
		10'd42, 		// top_bound
		10'd218, 	// bottom_bound
		enemy7_dead,
		Shoot, // check if player is shooting
		gleg2x, 	// objectx
		gleg2y,		// objecty
		enemy7_dead[1],
		death122x,
		death122y
	);								
	moving_object gleg3(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd206, 	// xstart
		10'd196, 	// ystart
		10'd2, 		// xdiff
		10'd11, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd624, 	// right_bound
		10'd20, 		// left_bound
		10'd36, 		// top_bound
		10'd215, 	// bottom_bound
		enemy7_dead,
		Shoot, // check if player is shooting
		gleg3x, 	// objectx
		gleg3y,		// objecty
		enemy7_dead[2],
		death123x,
		death123y
	);	
	moving_object gleg4(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd204, 	// xstart
		10'd205, 	// ystart
		10'd2, 		// xdiff
		10'd7, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd622, 	// right_bound
		10'd18, 		// left_bound
		10'd45, 		// top_bound
		10'd220, 	// bottom_bound
		enemy7_dead,
		Shoot, // check if player is shooting
		gleg4x, 	// objectx
		gleg4y,		// objecty
		enemy7_dead[3],
		death124x,
		death124y
	);								
	moving_object gleg5(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd215, 	// xstart
		10'd196, 	// ystart
		10'd2, 		// xdiff
		10'd10, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd633, 	// right_bound
		10'd29, 		// left_bound
		10'd36, 		// top_bound
		10'd214, 	// bottom_bound
		enemy7_dead,
		Shoot, // check if player is shooting
		gleg5x, 	// objectx
		gleg5y,		// objecty
		enemy7_dead[4],
		death125x,
		death125y
	);	
	moving_object gleg6(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd217, 	// xstart
		10'd204, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd635, 	// right_bound
		10'd31, 		// left_bound
		10'd44, 		// top_bound
		10'd220, 	// bottom_bound
		enemy7_dead,
		Shoot, // check if player is shooting
		gleg6x, 	// objectx
		gleg6y,		// objecty
		enemy7_dead[5],
		death126x,
		death126y
	);
	moving_object gleg7(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd218, 	// xstart
		10'd196, 	// ystart
		10'd2, 		// xdiff
		10'd5, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd636, 	// right_bound
		10'd32, 		// left_bound
		10'd36, 		// top_bound
		10'd209, 	// bottom_bound
		enemy7_dead,
		Shoot, // check if player is shooting
		gleg7x, 	// objectx
		gleg7y,		// objecty
		enemy7_dead[6],
		death127x,
		death127y
	);	
	moving_object gleg8(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd220, 	// xstart
		10'd199, 	// ystart
		10'd2, 		// xdiff
		10'd8, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd638, 	// right_bound
		10'd34, 		// left_bound
		10'd39, 		// top_bound
		10'd217, 	// bottom_bound
		enemy7_dead,
		Shoot, // check if player is shooting
		gleg8x, 	// objectx
		gleg8y,		// objecty
		enemy7_dead[7],
		death128x,
		death128y
	);	
	
	moving_object geyeball1(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd202, 	// xstart
		10'd187, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd621, 	// right_bound
		10'd16, 		// left_bound
		10'd27, 		// top_bound
		10'd197, 	// bottom_bound
		enemy7_dead,
		Shoot, // check if player is shooting
		geyeball1x, 	// objectx
		geyeball1y,		// objecty
		enemy7_dead[8],
		death129x,
		death129y
	);
	moving_object geyeball2(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd208, 	// xstart
		10'd179, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd627, 	// right_bound
		10'd22, 		// left_bound
		10'd19, 		// top_bound
		10'd189, 	// bottom_bound
		enemy7_dead,
		Shoot, // check if player is shooting
		geyeball2x, 	// objectx
		geyeball2y,		// objecty
		enemy7_dead[9],
		death130x,
		death130y
	);
	moving_object geyeball3(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd216, 	// xstart
		10'd187, 	// ystart
		10'd2, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd635, 	// right_bound
		10'd30, 		// left_bound
		10'd27, 		// top_bound
		10'd197, 	// bottom_bound
		enemy7_dead,
		Shoot, // check if player is shooting
		geyeball3x, 	// objectx
		geyeball3y,		// objecty
		enemy7_dead[10],
		death131x,
		death131y
	);
	
	
	moving_object geyeleft(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd200, 	// xstart
		10'd185, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd623, 	// right_bound
		10'd14, 		// left_bound
		10'd25, 		// top_bound
		10'd199, 	// bottom_bound
		enemy7_dead,
		Shoot, // check if player is shooting
		geyeleftx, 	// objectx
		geyelefty,		// objecty
		enemy7_dead[11],
		death132x,
		death132y
	);	
	moving_object geyecenter(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd207, 	// xstart
		10'd177, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd630, 	// right_bound
		10'd21, 		// left_bound
		10'd17, 		// top_bound
		10'd191, 	// bottom_bound
		enemy7_dead,
		Shoot, // check if player is shooting
		geyecenterx, 	// objectx
		geyecentery,		// objecty
		enemy7_dead[12],
		death133x,
		death133y
	);	
	moving_object geyeright(
		clk, 			
		rst, 			
		x, 
		y,  	
		targetc_xl, // center of the target
		targetc_yt, // center of the target				
		10'd214, 	// xstart
		10'd185, 	// ystart
		10'd6, 		// xdiff
		10'd6, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd637, 	// right_bound
		10'd28, 		// left_bound
		10'd25, 		// top_bound
		10'd199, 	// bottom_bound
		enemy7_dead,
		Shoot, // check if player is shooting
		geyerightx, 	// objectx
		geyerighty,		// objecty
		enemy7_dead[13],
		death134x,
		death134y
	);	
	
	moving_object ghead1(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd200, 	// xstart
		10'd170, 	// ystart
		10'd20, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd638, 	// right_bound
		10'd12, 		// left_bound
		10'd10, 		// top_bound
		10'd180, 	// bottom_bound
		enemy7_dead,
		Shoot, // check if player is shooting
		ghead1x, 	// objectx
		ghead1y,		// objecty
		enemy7_dead[14],
		death135x,
		death135y
	);		
	moving_object ghead2(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd198, 	// xstart
		10'd172, 	// ystart
		10'd24, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd639, 	// right_bound
		10'd11, 		// left_bound
		10'd12, 		// top_bound
		10'd182, 	// bottom_bound
		enemy7_dead,
		Shoot, // check if player is shooting
		ghead2x, 	// objectx
		ghead2y,		// objecty
		enemy7_dead[15],
		death136x,
		death136y
	);
	moving_object ghead3(
		clk, 			
		rst, 			
		x, 
		y, 		 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target		
		10'd196, 	// xstart
		10'd174, 	// ystart
		10'd28, 		// xdiff
		10'd20, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd640, 	// right_bound
		10'd10, 		// left_bound
		10'd14, 		// top_bound
		10'd202, 	// bottom_bound
		enemy7_dead,
		Shoot, // check if player is shooting
		ghead3x,// objectx
		ghead3y, // objecty
		enemy7_dead[16],
		death137x,
		death137y
	);		
	moving_object ghead4(
		clk, 			
		rst, 			
		x, 
		y, 	 	
		targetc_xl, // center of the target
		targetc_yt, // center of the target			
		10'd198, 	// xstart
		10'd194, 	// ystart
		10'd24, 		// xdiff
		10'd2, 	// ydiff
		10'd5, 		// xspeed
		10'd5, 		// yspeed
		10'd639, 	// right_bound
		10'd11, 		// left_bound
		10'd34, 		// top_bound
		10'd204, 	// bottom_bound
		enemy7_dead,
		Shoot, // check if player is shooting
		ghead4x, 	// objectx
		ghead4y,		// objecty
		enemy7_dead[17],
		death138x,
		death138y
		);			
//---------------------------------------------------------------------
// instantiations of user_object module to create the target
	user_object targetcenter(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd314, 	// xstart
		10'd100, 	// ystart 108
		10'd8, 	// xdiff
		10'd8,		// ydiff
		10'd10, 		// xspeed
		10'd10, 		// yspeed
		10'd590, 	// right_bound
		10'd60, 		// left_bound
		10'd42, 	// top_bound
		10'd206, 	// bottom_bound
		targetcenterx, 	// objectx
		targetcentery,		// objecty	
		targetc_xl,
		targetc_yt
		);			
	user_object target1(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd280, 	// xstart
		10'd102, 	// ystart 106
		10'd32, 	// xdiff
		10'd4,		// ydiff
		10'd10, 		// xspeed
		10'd10, 		// yspeed
		10'd580, 	// right_bound
		10'd26, 		// left_bound
		10'd46, 	// top_bound
		10'd204, 	// bottom_bound
		target1x, 	// objectx
		target1y,		// objecty	
		target1_xl,
		target1_yt
		);				
	user_object target2(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd292, 	// xstart
		10'd86, 	// ystart  122
		10'd4, 	// xdiff
		10'd36,		// ydiff
		10'd10, 		// xspeed
		10'd10, 		// yspeed
		10'd564, 	// right_bound
		10'd38, 		// left_bound
		10'd30, 	// top_bound
		10'd220, 	// bottom_bound
		target2x, 	// objectx
		target2y,		// objecty	
		target2_xl,
		target2_yt
		);		
	user_object target3(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd300, 	// xstart
		10'd78, 	// ystart  82
		10'd36, 	// xdiff
		10'd4,		// ydiff
		10'd10, 		// xspeed
		10'd10, 		// yspeed
		10'd604, 	// right_bound
		10'd46, 		// left_bound
		10'd22, 	// top_bound
		10'd180, 	// bottom_bound
		target3x, 	// objectx
		target3y,		// objecty	
		target3_xl,
		target3_yt
		);									
	user_object target4(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd316, 	// xstart
		10'd66, 	// ystart  98
		10'd4, 	// xdiff
		10'd32,		// ydiff
		10'd10, 		// xspeed
		10'd10, 		// yspeed
		10'd588, 	// right_bound
		10'd62, 		// left_bound
		10'd10, 	// top_bound
		10'd196, 	// bottom_bound
		target4x, 	// objectx
		target4y,		// objecty	
		target4_xl,
		target4_yt
		);										
	user_object target5(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd324, 	// xstart
		10'd102, 	// ystart 106
		10'd32, 	// xdiff
		10'd4,		// ydiff
		10'd10, 		// xspeed
		10'd10, 		// yspeed
		10'd624, 	// right_bound
		10'd70, 		// left_bound
		10'd46, 	// top_bound
		10'd204, 	// bottom_bound
		target5x, 	// objectx
		target5y,		// objecty	
		target5_xl,
		target5_yt
		);				
	user_object target6(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd340, 	// xstart
		10'd86, 	// ystart 122
		10'd4, 	// xdiff
		10'd36,		// ydiff
		10'd10, 		// xspeed
		10'd10, 		// yspeed
		10'd612, 	// right_bound
		10'd86, 		// left_bound
		10'd30, 	// top_bound
		10'd220, 	// bottom_bound
		target6x, 	// objectx
		target6y,		// objecty	
		target6_xl,
		target6_yt
		);		
	user_object target7(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd300, 	// xstart
		10'd126, 	// ystart 130
		10'd36, 	// xdiff
		10'd4,		// ydiff
		10'd10, 		// xspeed
		10'd10, 		// yspeed
		10'd604, 	// right_bound
		10'd46, 		// left_bound
		10'd70, 	// top_bound
		10'd228, 	// bottom_bound
		target7x, 	// objectx
		target7y,		// objecty
		target7_xl,
		target7_yt	
		);									
	user_object target8(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd316, 	// xstart
		10'd110, 	// ystart 142
		10'd4, 	// xdiff
		10'd32,		// ydiff
		10'd10, 		// xspeed
		10'd10, 		// yspeed
		10'd588, 	// right_bound
		10'd62, 		// left_bound
		10'd54, 	// top_bound
		10'd240, 	// bottom_bound
		target8x, 	// objectx
		target8y,		// objecty	
		target8_xl,
		target8_yt
		);		
//----------------------------------------------------------------------------------------------------------------------------
// instantiations of user_object module to create the gun
user_object aim(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd318, 	// xstart
		10'd300, 	// ystart
		10'd4, 	// xdiff
		10'd10,		// ydiff
		10'd10, 		// xspeed
		10'd0, 		// yspeed
		10'd588, 	// right_bound
		10'd62, 		// left_bound
		10'd250, 	// top_bound
		10'd480, 	// bottom_bound
		aimx, 	// objectx
		aimy,		// objecty	
		aim_xl,
		aim_yt
		);						
		user_object gunbodyL1(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd302, 	// xstart
		10'd428, 	// ystart
		10'd8, 	// xdiff
		10'd52,		// ydiff
		10'd10, 		// xspeed
		10'd0, 		// yspeed
		10'd576, 	// right_bound
		10'd46, 		// left_bound
		10'd250, 	// top_bound
		10'd480, 	// bottom_bound
		gunbodyL1x, 	// objectx
		gunbodyL1y,		// objecty	
		gunbodyL1_xl,
		gunbodyL1_yt
		);
		user_object gunbodyL2(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd306, 	// xstart
		10'd420, 	// ystart
		10'd4, 	// xdiff
		10'd8,		// ydiff
		10'd10, 		// xspeed
		10'd0, 		// yspeed
		10'd576, 	// right_bound
		10'd50, 		// left_bound +36
		10'd250, 	// top_bound
		10'd480, 	// bottom_bound
		gunbodyL2x, 	// objectx
		gunbodyL2y,		// objecty	
		gunbodyL2_xl,
		gunbodyL2_yt
		);
		user_object gunbodyL3(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd310, 	// xstart
		10'd328, 	// ystart
		10'd2, 	// xdiff
		10'd136,		// ydiff
		10'd10, 		// xspeed
		10'd0, 		// yspeed
		10'd578, 	// right_bound
		10'd54, 		// left_bound
		10'd250, 	// top_bound
		10'd480, 	// bottom_bound
		gunbodyL3x, 	// objectx
		gunbodyL3y,		// objecty	
		gunbodyL3_xl,
		gunbodyL3_yt
		);
		user_object gunbodyL4(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd312, 	// xstart
		10'd326, 	// ystart
		10'd4, 	// xdiff
		10'd106,		// ydiff
		10'd10, 		// xspeed
		10'd0, 		// yspeed
		10'd582, 	// right_bound
		10'd56, 		// left_bound
		10'd250, 	// top_bound
		10'd480, 	// bottom_bound
		gunbodyL4x, 	// objectx
		gunbodyL4y,		// objecty	
		gunbodyL4_xl,
		gunbodyL4_yt
		);
		user_object gunbodyL5(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd312, 	// xstart
		10'd432, 	// ystart
		10'd2, 	// xdiff
		10'd16,		// ydiff
		10'd10, 		// xspeed
		10'd0, 		// yspeed
		10'd580, 	// right_bound
		10'd56, 		// left_bound
		10'd250, 	// top_bound
		10'd480, 	// bottom_bound
		gunbodyL5x, 	// objectx
		gunbodyL5y,		// objecty	
		gunbodyL5_xl,
		gunbodyL5_yt
		);
		user_object gunhead1(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd310, 	// xstart
		10'd464, 	// ystart
		10'd2, 	// xdiff
		10'd16,		// ydiff
		10'd10, 		// xspeed
		10'd0, 		// yspeed
		10'd578, 	// right_bound
		10'd54, 		// left_bound
		10'd250, 	// top_bound
		10'd480, 	// bottom_bound
		gunhead1x, 	// objectx
		gunhead1y,		// objecty	
		gunhead1_xl,
		gunhead1_yt
		);
			user_object gunhead2(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd312, 	// xstart
		10'd442, 	// ystart
		10'd2, 	// xdiff
		10'd38,		// ydiff
		10'd10, 		// xspeed
		10'd0, 		// yspeed
		10'd580, 	// right_bound
		10'd56, 		// left_bound
		10'd250, 	// top_bound
		10'd480, 	// bottom_bound
		gunhead2x, 	// objectx
		gunhead2y,		// objecty	
		gunhead2_xl,
		gunhead2_yt
		);
			user_object gunhead3(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd314, 	// xstart
		10'd432, 	// ystart
		10'd2, 	// xdiff
		10'd48,		// ydiff
		10'd10, 		// xspeed
		10'd0, 		// yspeed
		10'd582, 	// right_bound
		10'd58, 		// left_bound
		10'd250, 	// top_bound
		10'd480, 	// bottom_bound
		gunhead3x, 	// objectx
		gunhead3y,		// objecty	
		gunhead3_xl,
		gunhead3_yt
		);
			user_object gunhead4(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd316, 	// xstart
		10'd310, 	// ystart
		10'd8, 	// xdiff
		10'd170,		// ydiff
		10'd10, 		// xspeed
		10'd0, 		// yspeed
		10'd590, 	// right_bound
		10'd60, 		// left_bound
		10'd250, 	// top_bound
		10'd480, 	// bottom_bound
		gunhead4x, 	// objectx
		gunhead4y,		// objecty	
		gunhead4_xl,
		gunhead4_yt
		);
			user_object gunhead5(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd324, 	// xstart
		10'd432, 	// ystart
		10'd2, 	// xdiff
		10'd48,		// ydiff
		10'd10, 		// xspeed
		10'd0, 		// yspeed
		10'd592, 	// right_bound
		10'd68, 		// left_bound
		10'd250, 	// top_bound
		10'd480, 	// bottom_bound
		gunhead5x, 	// objectx
		gunhead5y,		// objecty	
		gunhead5_xl,
		gunhead5_yt
		);
			user_object gunhead6(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd326, 	// xstart
		10'd442, 	// ystart
		10'd2, 	// xdiff
		10'd38,		// ydiff
		10'd10, 		// xspeed
		10'd0, 		// yspeed
		10'd594, 	// right_bound
		10'd70, 		// left_bound
		10'd250, 	// top_bound
		10'd480, 	// bottom_bound
		gunhead6x, 	// objectx
		gunhead6y,		// objecty	
		gunhead6_xl,
		gunhead6_yt
		);
			user_object gunhead7(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd328, 	// xstart
		10'd464, 	// ystart
		10'd2, 	// xdiff
		10'd16,		// ydiff
		10'd10, 		// xspeed
		10'd0, 		// yspeed
		10'd596, 	// right_bound
		10'd72, 		// left_bound
		10'd250, 	// top_bound
		10'd480, 	// bottom_bound
		gunhead7x, 	// objectx
		gunhead7y,		// objecty	
		gunhead7_xl,
		gunhead7_yt
		);
			user_object gunhead8(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd316, 	// xstart
		10'd304, 	// ystart
		10'd2, 	// xdiff
		10'd6,		// ydiff
		10'd10, 		// xspeed
		10'd0, 		// yspeed
		10'd584, 	// right_bound
		10'd60, 		// left_bound
		10'd250, 	// top_bound
		10'd480, 	// bottom_bound
		gunhead8x, 	// objectx
		gunhead8y,		// objecty	
		gunhead8_xl,
		gunhead8_yt
		);
		user_object gunhead9(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd322, 	// xstart
		10'd304, 	// ystart
		10'd2, 	// xdiff
		10'd6,		// ydiff
		10'd10, 		// xspeed
		10'd0, 		// yspeed
		10'd590, 	// right_bound
		10'd66, 		// left_bound
		10'd250, 	// top_bound
		10'd480, 	// bottom_bound
		gunhead9x, 	// objectx
		gunhead9y,		// objecty
		gunhead9_xl,
		gunhead9_yt
		);
		user_object gunbodyR1(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd330, 	// xstart
		10'd428, 	// ystart
		10'd8, 	// xdiff
		10'd52,		// ydiff
		10'd10, 		// xspeed
		10'd0, 		// yspeed
		10'd604, 	// right_bound
		10'd74, 		// left_bound
		10'd250, 	// top_bound
		10'd480, 	// bottom_bound
		gunbodyR1x, 	// objectx
		gunbodyR1y,		// objecty	
		gunbodyR1_xl,
		gunbodyR1_yt
		);
		user_object gunbodRL2(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd330, 	// xstart
		10'd420, 	// ystart
		10'd4, 	// xdiff
		10'd8,		// ydiff
		10'd10, 		// xspeed
		10'd0, 		// yspeed
		10'd600, 	// right_bound
		10'd74, 		// left_bound
		10'd250, 	// top_bound
		10'd480, 	// bottom_bound
		gunbodyR2x, 	// objectx
		gunbodyR2y,		// objecty	
		gunbodyR2_xl,
		gunbodyR2_yt
		);
		user_object gunbodyR3(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd328, 	// xstart
		10'd328, 	// ystart
		10'd2, 	// xdiff
		10'd136,		// ydiff
		10'd10, 		// xspeed
		10'd0, 		// yspeed
		10'd596, 	// right_bound
		10'd72, 		// left_bound
		10'd250, 	// top_bound
		10'd480, 	// bottom_bound
		gunbodyR3x, 	// objectx
		gunbodyR3y,		// objecty
		gunbodyR3_xl,
		gunbodyR3_yt
		);
		user_object gunbodyR4(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd324, 	// xstart
		10'd326, 	// ystart
		10'd4, 	// xdiff
		10'd106,		// ydiff
		10'd10, 		// xspeed
		10'd0, 		// yspeed
		10'd594, 	// right_bound
		10'd68, 		// left_bound
		10'd250, 	// top_bound
		10'd480, 	// bottom_bound
		gunbodyR4x, 	// objectx
		gunbodyR4y,		// objecty	
		gunbodyR4_xl,
		gunbodyR4_yt
		);
	user_object gunbodyR5(
		clk, 
		rst,
		x, 
		y, 
		Right_Gun,
		Left_Gun,
		up_gun,
		down_gun,
		10'd326, 	// xstart
		10'd432, 	// ystart
		10'd2, 	// xdiff
		10'd16,		// ydiff
		10'd10, 		// xspeed
		10'd0, 		// yspeed
		10'd594, 	// right_bound
		10'd70, 		// left_bound
		10'd250, 	// top_bound
		10'd480, 	// bottom_bound
		gunbodyR5x, 	// objectx
		gunbodyR5y,		// objecty	
		gunbodyR5_xl,
		gunbodyR5_yt
	);		

//--------------------------------------------------------

	// draws everything onto the screen every clock cycle
	// rectangles drawn higher up in the if else block are basically on higher layers
	/* if (player has not won)
			if (player has not lost)
				draw "GET READY"
				draw target
				draw moving enemies
				draw exploding enemies
				draw gun
				draw ship
				draw background
			else 
				write "Game Over"
				draw ship
				draw background
		else
			write "VICTORY"
			draw ship
			draw background
	*/
	always @ (posedge clk or negedge rst) // draw the object
	begin
		if (rst == 1'b0)
		begin
			color <= 0;
		end
		else 
		begin
		if (victory == 1'b0)
		begin
			if (game_over == 1'b0)		
		
				// get ready screen
				if ((seconds > 10'd50) & getreadyg1x & getreadyg1y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadyg2x & getreadyg2y)
					color <= cyan;	
				else if ((seconds > 10'd50) & getreadyg3x & getreadyg3y)
					color <= cyan;	
				else if ((seconds > 10'd50) & getreadyg4x & getreadyg4y)
					color <= cyan;	
				else if ((seconds > 10'd50) & getreadyg5x & getreadyg5y)
					color <= cyan;	
					
				else if ((seconds > 10'd50) & getreadye1x & getreadye1y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadye2x & getreadye2y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadye3x & getreadye3y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadye4x & getreadye4y)
					color <= cyan;
					
					
				else if ((seconds > 10'd50) & getreadyt1x & getreadyt1y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadyt2x & getreadyt2y)
					color <= cyan;
					
				
				else if ((seconds > 10'd50) & getreadyr1x & getreadyr1y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadyr2x & getreadyr2y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadyr3x & getreadyr3y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadyr4x & getreadyr4y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadyr5x & getreadyr5y)
					color <= cyan;
					
						
				else if ((seconds > 10'd50) & getreadye11x & getreadye11y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadye12x & getreadye12y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadye13x & getreadye13y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadye14x & getreadye14y)
					color <= cyan;
				
				else if ((seconds > 10'd50) & getreadya1x & getreadya1y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadya2x & getreadya2y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadya3x & getreadya3y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadya4x & getreadya4y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadya5x & getreadya5y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadya6x & getreadya6y)
					color <= cyan;
					
				
				else if ((seconds > 10'd50) & getreadyd1x & getreadyd1y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadyd2x & getreadyd2y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadyd3x & getreadyd3y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadyd4x & getreadyd4y)
					color <= cyan;
					
					
				else if ((seconds > 10'd50) & getreadyy1x & getreadyy1y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadyy2x & getreadyy2y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadyy3x & getreadyy3y)
					color <= cyan;
				else if ((seconds > 10'd50) & getreadyy4x & getreadyy4y)
					color <= cyan;
				
				
				
				else if (targetcenterx & targetcentery)
				begin
					color <= red;
				end
				else if (target1x & target1y)
				begin
					color <= red;
				end
				else if (target2x & target2y)
				begin
					color <= red;
				end
				else if (target3x & target3y)
				begin
					color <= red;
				end
				else if (target4x & target4y)
				begin
					color <= red;
				end
				else if (target5x & target5y)
				begin
					color <= red;
				end
				else if (target6x & target6y)
				begin
					color <= red;
				end
				else if (target7x & target7y)
				begin
					color <= red;
				end
				else if (target8x & target8y)
				begin
					color <= red;
				end
				
				//------------------------------------------------------------
				
				else if (aeyeball1x & aeyeball1y)
				begin
					color <= white;
				end
				else if (aeyeball2x & aeyeball2y)
				begin
					color <= white;
				end
				else if (aeyeball3x & aeyeball3y)
				begin
					color <= white;
				end
				
				
				else if (aeyerightx & aeyerighty)
				begin
					color <= blue;
				end
				else if (aeyecenterx & aeyecentery)
				begin
					color <= blue;
				end
				else if (aeyeleftx & aeyelefty)
				begin
					color <= blue;
				end
				
				else if (ahead1x & ahead1y)
				begin
					color <= yellow;
				end
				else if (ahead2x & ahead2y)
				begin
					color <= yellow;
				end
				else if (ahead3x & ahead3y)
				begin
					color <= yellow;
				end
				else if (ahead4x & ahead4y)
				begin
					color <= yellow;
				end
				
				else if (aleg1x & aleg1y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (aleg2x & aleg2y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (aleg3x & aleg3y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (aleg4x & aleg4y)
				begin
					color <= {8'd150,8'd150,8'd150};;
				end
				else if (aleg5x & aleg5y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (aleg6x & aleg6y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (aleg7x & aleg7y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (aleg8x & aleg8y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				//--------------------------------------------------------------------------------------------------------
			
				else if (death1x & death1y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death2x & death2y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death3x & death3y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death4x & death4y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death5x & death5y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death6x & death6y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death7x & death7y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death8x & death8y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death9x & death9y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death10x & death10y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death11x & death11y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death12x & death12y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death13x & death13y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death14x & death14y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death15x & death15y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death16x & death16y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death17x & death17y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death18x & death18y)
					color <= {8'd255, 8'd125, 8'd0};
				//------------------------------------------------------------
				
				else if (beyeball1x & beyeball1y)
				begin
					color <= white;
				end
				else if (beyeball2x & beyeball2y)
				begin
					color <= white;
				end
				else if (beyeball3x & beyeball3y)
				begin
					color <= white;
				end
				
				
				else if (beyerightx & beyerighty)
				begin
					color <= blue;
				end
				else if (beyecenterx & beyecentery)
				begin
					color <= blue;
				end
				else if (beyeleftx & beyelefty)
				begin
					color <= blue;
				end
				
				else if (bhead1x & bhead1y)
				begin
					color <= pink;
				end
				else if (bhead2x & bhead2y)
				begin
					color <= pink;
				end
				else if (bhead3x & bhead3y)
				begin
					color <= pink;
				end
				else if (bhead4x & bhead4y)
				begin
					color <= pink;
				end
				
				else if (bleg1x & bleg1y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (bleg2x & bleg2y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (bleg3x & bleg3y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (bleg4x & bleg4y)
				begin
					color <= {8'd150,8'd150,8'd150};;
				end
				else if (bleg5x & bleg5y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (bleg6x & bleg6y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (bleg7x & bleg7y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (bleg8x & bleg8y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				//--------------------------------------------------------------------------------------------------------
				else if (death21x & death21y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death22x & death22y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death23x & death23y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death24x & death24y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death25x & death25y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death26x & death26y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death27x & death27y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death28x & death28y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death29x & death29y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death30x & death30y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death31x & death31y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death32x & death32y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death33x & death33y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death34x & death34y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death35x & death35y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death36x & death36y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death37x & death37y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death38x & death38y)
					color <= {8'd255, 8'd125, 8'd0};
				
					//------------------------------------------------------------
				
				else if (ceyeball1x & ceyeball1y & (seconds < 10'd50))
				begin
					color <= white;
				end
				else if (ceyeball2x & ceyeball2y & (seconds < 10'd50))
				begin
					color <= white;
				end
				else if (ceyeball3x & ceyeball3y & (seconds < 10'd50))
				begin
					color <= white;
				end
				
				
				else if (ceyerightx & ceyerighty & (seconds < 10'd50))
				begin
					color <= blue;
				end
				else if (ceyecenterx & ceyecentery & (seconds < 10'd50))
				begin
					color <= blue;
				end
				else if (ceyeleftx & ceyelefty & (seconds < 10'd50))
				begin
					color <= blue;
				end
				
				else if (chead1x & chead1y & (seconds < 10'd50))
				begin
					color <= green;
				end
				else if (chead2x & chead2y & (seconds < 10'd50))
				begin
					color <= green;
				end
				else if (chead3x & chead3y & (seconds < 10'd50))
				begin
					color <= green;
				end
				else if (chead4x & chead4y & (seconds < 10'd50))
				begin
					color <= green;
				end
				
				else if (cleg1x & cleg1y  & (seconds < 10'd50))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (cleg2x & cleg2y  & (seconds < 10'd50))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (cleg3x & cleg3y  & (seconds < 10'd50))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (cleg4x & cleg4y  & (seconds < 10'd50))
				begin
					color <= {8'd150,8'd150,8'd150};;
				end
				else if (cleg5x & cleg5y  & (seconds < 10'd50))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (cleg6x & cleg6y & (seconds < 10'd50))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (cleg7x & cleg7y & (seconds < 10'd50))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (cleg8x & cleg8y & (seconds < 10'd50))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				
				//--------------------------------------------------------------------------------------------------------
				else if (death41x & death41y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death42x & death42y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death43x & death43y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death44x & death44y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death45x & death45y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death46x & death46y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death47x & death47y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death48x & death48y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death49x & death49y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death50x & death50y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death51x & death51y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death52x & death52y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death53x & death53y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death54x & death54y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death55x & death55y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death56x & death56y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death57x & death57y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death58x & death58y)
					color <= {8'd255, 8'd125, 8'd0};
				//------------------------------------------------------------
				
				else if (deyeball1x & deyeball1y & (seconds < 10'd43))
				begin
					color <= white;
				end
				else if (deyeball2x & deyeball2y & (seconds < 10'd43))
				begin
					color <= white;
				end
				else if (deyeball3x & deyeball3y & (seconds < 10'd43))
				begin
					color <= white;
				end
				
				
				else if (deyerightx & deyerighty & (seconds < 10'd43))
				begin
					color <= blue;
				end
				else if (deyecenterx & deyecentery & (seconds < 10'd43))
				begin
					color <= blue;
				end
				else if (deyeleftx & deyelefty & (seconds < 10'd43))
				begin
					color <= blue;
				end
				
				else if (dhead1x & dhead1y & (seconds < 10'd43))
				begin
					color <= cyan;
				end
				else if (dhead2x & dhead2y & (seconds < 10'd43))
				begin
					color <= cyan;
				end
				else if (dhead3x & dhead3y & (seconds < 10'd43))
				begin
					color <= cyan;
				end
				else if (dhead4x & dhead4y & (seconds < 10'd43))
				begin
					color <= cyan;
				end
				
				else if (dleg1x & dleg1y  & (seconds < 10'd43))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (dleg2x & dleg2y  & (seconds < 10'd43))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (dleg3x & dleg3y  & (seconds < 10'd43))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (dleg4x & dleg4y  & (seconds < 10'd43))
				begin
					color <= {8'd150,8'd150,8'd150};;
				end
				else if (dleg5x & dleg5y  & (seconds < 10'd43))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (dleg6x & dleg6y & (seconds < 10'd43))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (dleg7x & dleg7y & (seconds < 10'd43))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (dleg8x & dleg8y & (seconds < 10'd43))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				//--------------------------------------------------------------------------------------------------------
				else if (death61x & death61y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death62x & death62y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death63x & death63y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death64x & death64y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death65x & death65y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death66x & death66y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death67x & death67y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death68x & death68y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death69x & death69y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death70x & death70y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death71x & death71y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death72x & death72y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death73x & death73y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death74x & death74y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death75x & death75y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death76x & death76y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death77x & death77y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death78x & death78y)
					color <= {8'd255, 8'd125, 8'd0};
				
				//------------------------------------------------------------
				
				else if (eeyeball1x & eeyeball1y & (seconds < 10'd36))
				begin
					color <= white;
				end
				else if (eeyeball2x & eeyeball2y & (seconds < 10'd36))
				begin
					color <= white;
				end
				else if (eeyeball3x & eeyeball3y & (seconds < 10'd36))
				begin
					color <= white;
				end
				
				
				else if (eeyerightx & eeyerighty & (seconds < 10'd36))
				begin
					color <= blue;
				end
				else if (eeyecenterx & eeyecentery & (seconds < 10'd36))
				begin
					color <= blue;
				end
				else if (eeyeleftx & eeyelefty & (seconds < 10'd36))
				begin
					color <= blue;
				end
				
				else if (ehead1x & ehead1y & (seconds < 10'd36))
				begin
					color <= {8'd100,8'd100,8'd100};
				end
				else if (ehead2x & ehead2y & (seconds < 10'd36))
				begin
					color <= {8'd100,8'd100,8'd100};
				end
				else if (ehead3x & ehead3y & (seconds < 10'd36))
				begin
					color <= {8'd100,8'd100,8'd100};
				end
				else if (ehead4x & ehead4y & (seconds < 10'd36))
				begin
					color <= {8'd100,8'd100,8'd100};
				end
				
				else if (eleg1x & eleg1y  & (seconds < 10'd36))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (eleg2x & eleg2y  & (seconds < 10'd36))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (eleg3x & eleg3y  & (seconds < 10'd36))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (eleg4x & eleg4y  & (seconds < 10'd36))
				begin
					color <= {8'd150,8'd150,8'd150};;
				end
				else if (eleg5x & eleg5y  & (seconds < 10'd36))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (eleg6x & eleg6y & (seconds < 10'd36))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (eleg7x & eleg7y & (seconds < 10'd36))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (eleg8x & eleg8y & (seconds < 10'd36))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				//--------------------------------------------------------------------------------------------------------
				
				else if (death81x & death81y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death82x & death82y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death83x & death83y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death84x & death84y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death85x & death85y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death86x & death86y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death87x & death87y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death88x & death88y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death89x & death89y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death90x & death90y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death91x & death91y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death92x & death92y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death93x & death93y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death94x & death94y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death95x & death95y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death96x & death96y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death97x & death97y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death98x & death98y)
					color <= {8'd255, 8'd125, 8'd0};
				//--------------------------------------------------------------------------------------------------------
				
				else if (feyeball1x & feyeball1y & (seconds < 10'd25))
				begin
					color <= white;
				end
				else if (feyeball2x & feyeball2y & (seconds < 10'd25))
				begin
					color <= white;
				end
				else if (feyeball3x & feyeball3y & (seconds < 10'd25))
				begin
					color <= white;
				end
				
				
				else if (feyerightx & feyerighty & (seconds < 10'd25))
				begin
					color <= blue;
				end
				else if (feyecenterx & feyecentery & (seconds < 10'd25))
				begin
					color <= blue;
				end
				else if (feyeleftx & feyelefty & (seconds < 10'd25))
				begin
					color <= blue;
				end
				
				else if (fhead1x & fhead1y & (seconds < 10'd25))
				begin
					color <= {8'd255,8'd100,8'd0};
				end
				else if (fhead2x & fhead2y & (seconds < 10'd25))
				begin
					color <= {8'd255,8'd100,8'd0};
				end
				else if (fhead3x & fhead3y & (seconds < 10'd25))
				begin
					color <= {8'd255,8'd100,8'd0};
				end
				else if (fhead4x & fhead4y & (seconds < 10'd25))
				begin
					color <= {8'd255,8'd100,8'd0};
				end
				
				else if (fleg1x & fleg1y  & (seconds < 10'd25))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (fleg2x & fleg2y  & (seconds < 10'd25))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (fleg3x & fleg3y  & (seconds < 10'd25))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (fleg4x & fleg4y  & (seconds < 10'd25))
				begin
					color <= {8'd150,8'd150,8'd150};;
				end
				else if (fleg5x & fleg5y  & (seconds < 10'd25))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (fleg6x & fleg6y & (seconds < 10'd25))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (fleg7x & fleg7y & (seconds < 10'd25))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (fleg8x & fleg8y & (seconds < 10'd25))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				//--------------------------------------------------------------------------------------------------------
				else if (death101x & death101y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death102x & death102y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death103x & death103y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death104x & death104y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death105x & death105y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death106x & death106y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death107x & death107y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death108x & death108y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death109x & death109y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death110x & death110y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death111x & death111y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death112x & death112y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death113x & death113y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death114x & death114y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death115x & death115y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death116x & death116y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death117x & death117y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death118x & death118y)
					color <= {8'd255, 8'd125, 8'd0};
				//--------------------------------------------------------------------------------------------------------
				else if (geyeball1x & geyeball1y & (seconds < 10'd15))
				begin
					color <= white;
				end
				else if (geyeball2x & geyeball2y & (seconds < 10'd15))
				begin
					color <= white;
				end
				else if (geyeball3x & geyeball3y & (seconds < 10'd15))
				begin
					color <= white;
				end
				
				
				else if (geyerightx & geyerighty & (seconds < 10'd15))
				begin
					color <= blue;
				end
				else if (geyecenterx & geyecentery & (seconds < 10'd15))
				begin
					color <= blue;
				end
				else if (geyeleftx & geyelefty & (seconds < 10'd15))
				begin
					color <= blue;
				end
				
				else if (ghead1x & ghead1y & (seconds < 10'd15))
				begin
					color <= {8'd200,8'd130,8'd255};
				end
				else if (ghead2x & ghead2y & (seconds < 10'd15))
				begin
					color <= {8'd200,8'd130,8'd255};
				end
				else if (ghead3x & ghead3y & (seconds < 10'd15))
				begin
					color <= {8'd200,8'd130,8'd255};
				end
				else if (ghead4x & ghead4y & (seconds < 10'd15))
				begin
					color <= {8'd200,8'd130,8'd255};
				end
				
				else if (gleg1x & gleg1y  & (seconds < 10'd15))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (gleg2x & gleg2y  & (seconds < 10'd15))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (gleg3x & gleg3y  & (seconds < 10'd15))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (gleg4x & gleg4y  & (seconds < 10'd15))
				begin
					color <= {8'd150,8'd150,8'd150};;
				end
				else if (gleg5x & gleg5y  & (seconds < 10'd15))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (gleg6x & gleg6y & (seconds < 10'd15))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (gleg7x & gleg7y & (seconds < 10'd15))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (gleg8x & gleg8y & (seconds < 10'd15))
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				//--------------------------------------------------------------------------------------------------------
				
				else if (death121x & death121y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death122x & death122y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death123x & death123y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death124x & death124y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death125x & death125y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death126x & death126y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death127x & death127y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death128x & death128y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death129x & death129y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death130x & death130y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death131x & death131y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death132x & death132y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death133x & death133y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death134x & death134y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death135x & death135y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death136x & death136y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death137x & death137y)
					color <= {8'd255, 8'd125, 8'd0};
				else if (death138x & death138y)
					color <= {8'd255, 8'd125, 8'd0};
				//--------------------------------------------------------------------------------------------------------
				
				else if (aimx & aimy)
				begin
					color <= red;
				end
				else if (gunbodyL1x & gunbodyL1y)
				begin
					color <= white;
				end
				else if (gunbodyL2x & gunbodyL2y)
				begin
					color <= white;
				end
				else if (gunbodyL3x & gunbodyL3y)
				begin
					color <= white;
				end
				else if (gunbodyL4x & gunbodyL4y)
				begin
					color <= white;
				end
				else if (gunbodyL5x & gunbodyL5y)
				begin
					color <= white;
				end
				else if (gunhead1x & gunhead1y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (gunhead2x & gunhead2y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (gunhead3x & gunhead3y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (gunhead4x & gunhead4y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (gunhead5x & gunhead5y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (gunhead6x & gunhead6y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (gunhead7x & gunhead7y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (gunhead8x & gunhead8y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (gunhead9x & gunhead9y)
				begin
					color <= {8'd150,8'd150,8'd150};
				end
				else if (gunbodyR1x & gunbodyR1y)
				begin
					color <= white;
				end
				else if (gunbodyR2x & gunbodyR2y)
				begin
					color <= white;
				end
				else if (gunbodyR3x & gunbodyR3y)
				begin
					color <= white;
				end
				else if (gunbodyR4x & gunbodyR4y)
				begin
					color <= white;
				end
				else if (gunbodyR5x & gunbodyR5y)
				begin
					color <= white;
				end
					
				//----------------------------------------
					
				// draw the platform the object is on
				else if (platform4x & platform4y)
				begin
					color <= {8'd120, 8'd120, 8'd120};
				end
				else if (platform5x & platform5y)
				begin
					color <= {8'd120, 8'd120, 8'd120};
				end
				else if (platform6x & platform6y)
				begin
					color <= {8'd120, 8'd120, 8'd120};
				end
				else if (platform1x & platform1y)
				begin
					color <= {8'd255, 8'd121, 8'd0};
				end
				else if (platform2x & platform2y)
				begin
					color <= {8'd255, 8'd121, 8'd0};
				end
				else if (platform3x & platform3y)
				begin
					color <= {8'd255, 8'd121, 8'd0};
				end
			
			//---------------------------------------
			
			else if (star1x & star1y)
				color <= yellow;
			else if (star2x & star2y)
				color <= yellow;
			else if (star3x & star3y)
				color <= yellow;
			else if (star4x & star4y)
				color <= yellow;
			else if (star5x & star5y)
				color <= yellow;
			else if (star6x & star6y)
				color <= yellow;
			else if (star7x & star7y)
				color <= yellow;
			else if (star8x & star8y)
				color <= yellow;
			else if (star9x & star9y)
				color <= yellow;
			else if (star10x & star10y)
				color <= yellow;
			else if (star11x & star11y)
				color <= yellow;
			else if (star12x & star12y)
				color <= yellow;
			else if (star13x & star13y)
				color <= yellow;
			else if (star14x & star14y)
				color <= yellow;
			else if (star15x & star15y)
				color <= yellow;
				
				// draw the background
				else
				begin
					color <= black;
				end
			//---------------------------------
			// color for "Game Over'
			else if (G1x & G1y)
				color <= white;
			else if (G2x & G2y)
				color <= white;
			else if (G3x & G3y)
				color <= white;
			else if (G4x & G4y)
				color <= white;
			else if (G5x & G5y)
				color <= white;
				
			else if (a1x & a1y)
				color <= white;
			else if (a2x & a2y)
				color <= white;
			else if (a3x & a3y)
				color <= white;
			else if (a4x & a4y)
				color <= white;
				
			else if (m1x & m1y)
				color <= white;
			else if (m2x & m2y)
				color <= white;
			else if (m3x & m3y)
				color <= white;
			else if (m4x & m4y)
				color <= white;
				
			else if (e1x & e1y)
				color <= white;
			else if (e2x & e2y)
				color <= white;
			else if (e3x & e3y)
				color <= white;
			else if (e4x & e4y)
				color <= white;
			else if (e5x & e5y)
				color <= white;
				
			else if (O1x & O1y)
				color <= white;
			else if (O2x & O2y)
				color <= white;
			else if (O3x & O3y)
				color <= white;
			else if (O4x & O4y)
				color <= white;
				
			else if (v1x & v1y)
				color <= white;
			else if (v2x & v2y)
				color <= white;
			else if (v3x & v3y)
				color <= white;
				
			else if (e11x & e11y)
				color <= white;
			else if (e12x & e12y)
				color <= white;
			else if (e13x & e13y)
				color <= white;
			else if (e14x & e14y)
				color <= white;
			else if (e15x & e15y)
				color <= white;
				
			else if (r1x & r1y)
				color <= white;
			else if (r2x & r2y)
				color <= white;
			else if (r3x & r3y)
				color <= white;
			else if (r4x & r4y)
				color <= white;
				
			
			else if (star1x & star1y)
				color <= yellow;
			else if (star2x & star2y)
				color <= yellow;
			else if (star3x & star3y)
				color <= yellow;
			else if (star4x & star4y)
				color <= yellow;
			else if (star5x & star5y)
				color <= yellow;
			else if (star6x & star6y)
				color <= yellow;
			else if (star7x & star7y)
				color <= yellow;
			else if (star8x & star8y)
				color <= yellow;
			else if (star9x & star9y)
				color <= yellow;
			else if (star10x & star10y)
				color <= yellow;
			else if (star11x & star11y)
				color <= yellow;
			else if (star12x & star12y)
				color <= yellow;
			else if (star13x & star13y)
				color <= yellow;
			else if (star14x & star14y)
				color <= yellow;
			else if (star15x & star15y)
				color <= yellow;
			
				//------------------------------------------------
				
			else if (platform4x & platform4y)
				begin
					color <= {8'd120, 8'd120, 8'd120};
				end
			else if (platform5x & platform5y)
				begin
					color <= {8'd120, 8'd120, 8'd120};
				end
			else if (platform6x & platform6y)
				begin
					color <= {8'd120, 8'd120, 8'd120};
				end
			
			else if (platform1x & platform1y)
				begin
					color <= {8'd255, 8'd121, 8'd0};
				end
			else if (platform2x & platform2y)
				begin
					color <= {8'd255, 8'd121, 8'd0};
				end
			else if (platform3x & platform3y)
				begin
					color <= {8'd255, 8'd121, 8'd0};
				end
				
			else
			begin
				color <= black;
			end
		end
		//----------------------------------------------
		else
		begin
				if (victoryv1x & victoryv1y)
					color <= cyan;
				else if (victoryv2x & victoryv2y)
					color <= cyan;
				else if (victoryv3x & victoryv3y)
					color <= cyan;
				else if (victoryv4x & victoryv4y)
					color <= cyan;
				else if (victoryv5x & victoryv5y)
					color <= cyan;
				
				else if (victoryi1x & victoryi1y)
					color <= cyan;
				else if (victoryi2x & victoryi2y)
					color <= cyan;
				else if (victoryi3x & victoryi3y)
					color <= cyan;
					
				else if (victoryc1x & victoryc1y)
					color <= cyan;
				else if (victoryc2x & victoryc2y)
					color <= cyan;
				else if (victoryc3x & victoryc3y)
					color <= cyan;
					
				else if (victoryt1x & victoryt1y)
					color <= cyan;
				else if (victoryt2x & victoryt2y)
					color <= cyan;
					
				else if (victoryo1x & victoryo1y)
					color <= cyan;
				else if (victoryo2x & victoryo2y)
					color <= cyan;
				else if (victoryo3x & victoryo3y)
					color <= cyan;
				else if (victoryo4x & victoryo4y)
					color <= cyan;
				
				else if (victoryr1x & victoryr1y)
					color <= cyan;
				else if (victoryr2x & victoryr2y)
					color <= cyan;
				else if (victoryr3x & victoryr3y)
					color <= cyan;
				else if (victoryr4x & victoryr4y)
					color <= cyan;
				else if (victoryr5x & victoryr5y)
					color <= cyan;
				
				
				else if (victoryy1x & victoryy1y)
					color <= cyan;
				else if (victoryy2x & victoryy2y)
					color <= cyan;
				else if (victoryy3x & victoryy3y)
					color <= cyan;
				else if (victoryy4x & victoryy4y)
					color <= cyan; 
					
				//-----------------------------------------
					else if (platform4x & platform4y)
				begin
					color <= {8'd120, 8'd120, 8'd120};
				end
				else if (platform5x & platform5y)
				begin
					color <= {8'd120, 8'd120, 8'd120};
				end
				else if (platform6x & platform6y)
				begin
					color <= {8'd120, 8'd120, 8'd120};
				end
				else if (platform1x & platform1y)
				begin
					color <= {8'd255, 8'd121, 8'd0};
				end
				else if (platform2x & platform2y)
				begin
					color <= {8'd255, 8'd121, 8'd0};
				end
				else if (platform3x & platform3y)
				begin
					color <= {8'd255, 8'd121, 8'd0};
				end
			//-----------------------------------------
			else if (star1x & star1y)
				color <= yellow;
			else if (star2x & star2y)
				color <= yellow;
			else if (star3x & star3y)
				color <= yellow;
			else if (star4x & star4y)
				color <= yellow;
			else if (star5x & star5y)
				color <= yellow;
			else if (star6x & star6y)
				color <= yellow;
			else if (star7x & star7y)
				color <= yellow;
			else if (star8x & star8y)
				color <= yellow;
			else if (star9x & star9y)
				color <= yellow;
			else if (star10x & star10y)
				color <= yellow;
			else if (star11x & star11y)
				color <= yellow;
			else if (star12x & star12y)
				color <= yellow;
			else if (star13x & star13y)
				color <= yellow;
			else if (star14x & star14y)
				color <= yellow;
			else if (star15x & star15y)
				color <= yellow;
			else 
				color <= black;
		end
		end
	end

endmodule 