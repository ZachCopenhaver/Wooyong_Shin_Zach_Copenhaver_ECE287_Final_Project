module three_decimal_vals_w_neg (
input [7:0]val,
//output [6:0]seg7_neg_sign,
output [6:0]seg7_dig0,
output [6:0]seg7_dig1,
output [6:0]seg7_dig2
);

reg [3:0] result_one_digit;
reg [3:0] result_ten_digit;
reg [3:0] result_hun_digit;
//reg result_is_negative;

//reg [7:0]twos_comp;

/* convert the binary value into 3 signals of negative, one and ten digit */
always @(*)
begin
	// if leftmost bit is 1 then val is negative
	/*if (val[7] == 1)
	begin
		twos_comp = val * (-1);
		result_one_digit = twos_comp % 8'd10;
		result_ten_digit = ((twos_comp - result_one_digit) % 8'd100) / 8'd10;
		result_hun_digit = (twos_comp - result_ten_digit - result_one_digit) / 8'd100;
	end
	else
	begin*/
		result_one_digit = val % 8'd10;
		result_ten_digit = ((val - result_one_digit) % 8'd100) / 8'd10;
		result_hun_digit = (val - result_ten_digit - result_one_digit) / 8'd100;
	//end
	//result_is_negative = val[7];
end

/* instantiate the modules for each of the seven seg decoders including the negative one */
seven_segment ss_one(result_one_digit, seg7_dig0);
seven_segment ss_ten(result_ten_digit, seg7_dig1);
seven_segment ss_hun(result_hun_digit, seg7_dig2);
//seven_segment_negative ss_n(result_is_negative, seg7_neg_sign);

endmodule