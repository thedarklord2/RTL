
`timescale 1ns/1ps

module tb_pattern_detector;

// Clock and reset
bit clk, rstb;

// Input/Output signals
bit serial_pattern, enable;
logic pattern_detected;

bit [2:0] three_bit_serial_pattern;


U_pattern_detector pattern_detector (
										.clk  ( clk ),
										.rstb ( rstb ),
										.serial_pattern (serial_pattern),
										.enable (enable),
										.pattern_detected (pattern_detected)
									);




// assertion to check pattern_detected is driven low, when enable is not active
always@(negedge clk)
	assert ( (!enable) && pattern_detected ) $error("This shouldn't happen. Pattern detector can't work when we don't enable it"); 


initial
begin
	clk  = 1'b0; 
	rstb = 1'b1;
	enable = 1'b0;
	three_bit_serial_pattern = 3'd0;
	repeat (2) @(negedge clk);
	rstb = 1'b0;
	repeat (2) @(negedge clk);
	rstb = 1'b1;
	repeat (10) @(negedge clk);
	
	for ( int i = 0; i < 10; i++ )
	begin
		serial_pattern = $urandom;					
		three_bit_serial_pattern = { serial_pattern, three_bit_serial_pattern[2:1] };
		repeat (1) @(negedge clk);
	end

	
end

initial













endmodule 
