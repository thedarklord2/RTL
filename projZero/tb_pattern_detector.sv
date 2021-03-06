
`timescale 1ns/1ps

module tb_pattern_detector;

// Parameters 
parameter HALF_TIME_PERIOD = 5;

// Clock and reset
bit clk, rstb;

// Input/Output signals
bit serial_pattern, enable;
logic pattern_detected;


bit [2:0] three_bit_serial_pattern;


pattern_detector U_pattern_detector (
										.clk  ( clk ),
										.rstb ( rstb ),
										.serial_pattern (serial_pattern),
										.enable (enable),
										.pattern_detected (pattern_detected)
									);


always
begin
	#(HALF_TIME_PERIOD) clk = ~clk;
end


// assertion to check pattern_detected is driven low, when enable is not active
always@(negedge clk)
	BASIC_CHECK: assert  (!( (!enable) && pattern_detected ) ) else  $display("This shouldn't happen. Pattern detector can't work when we don't enable it enable = %d, pattern_detected = %d", enable, pattern_detected ); 


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
	
	// Enable and send data
	enable = 1'b1;
	serial_pattern = $urandom;					
	three_bit_serial_pattern = { serial_pattern, three_bit_serial_pattern[2:1] };
	repeat (1) @(negedge clk);
	
	serial_pattern = $urandom;					
	three_bit_serial_pattern = { serial_pattern, three_bit_serial_pattern[2:1] };
	repeat (1) @(negedge clk);
	
	for ( int i = 0; i < 100; i++ )
	begin
		serial_pattern = $urandom;					
		three_bit_serial_pattern = { serial_pattern, three_bit_serial_pattern[2:1] };
		repeat (1) @(negedge clk);

		if ( !(^three_bit_serial_pattern) && three_bit_serial_pattern != 3'd0 ) 
			EXACT_MATCH: assert ( pattern_detected == 1'b1 ) else $error ( "Pattern detected should be high");	
		else 
			NOT_EXACT_MATCH: assert ( pattern_detected == 1'b0 ) else $error ( "Pattern detected should be low");	
	end
	
	repeat (10) @(negedge clk);
	$finish;
end

// #########################################################
// ################  VCD stuff   ###########################
// #########################################################
initial 
begin
    // if this is a "+wave" run, it must record all signals
    if ( $test$plusargs("wave") ) 
	begin
        $display("%t: Starting Wave Capture",$time);
        // levels, instance
        $vcdpluson   (0, tb_pattern_detector );
        $vcdplusmemon(0, tb_pattern_detector );
    end
end




endmodule 
