// Output goes high when exactly 2 of the last 3 values are 1
//

module pattern_detector ( clk,
		rstb,
		serial_pattern_i,
		enable,
		pattern_detected_o
);

// Signal directions
input clk;
input rstb;		// active low reset
input serial_pattern;	// Serial pattern input
input enable;		// Needs to be high for detection to start
output pattern_detected_o;
// Port types
wire clk;
wire rstb;
wire serial_pattern;
wire enable;
reg pattern_detected_o;

// State names
parameter IDLE 	 	 = 6'b000000;
parameter ZER  	 	 = 6'b000001;
parameter ONE  	 	 = 6'b000010;
parameter ZER_ZER	 = 6'b000100; 
parameter ZER_ONE	 = 6'b001000;
parameter ONE_ZER	 = 6'b010000;
parameter ONE_ONE	 = 6'b100000;

// Internal variables
reg next_state;
wire state;


// Functionality blocks
assign state = next_state;


// reset function
always @( posedge clk )
begin
	if (rstb == 1'b1) begin
		next_state <= state;
	end else begin
		next_state <= IDLE;
	end
end

endmodule



