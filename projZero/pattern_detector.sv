// test comment
// Output goes high when exactly 2 of the last 3 values are 1
//

module pattern_detector (
	input logic 	clk,
	input logic	rstb,
	input logic	serial_pattern,
	input logic	enable,
	input logic	pattern_detected
);


// State names
parameter IDLE 	 	 = 6'b000000;
parameter ZER  	 	 = 6'b000001;
parameter ONE  	 	 = 6'b000010;
parameter ZER_ZER	 = 6'b000100; 
parameter ZER_ONE	 = 6'b001000;
parameter ONE_ZER	 = 6'b010000;
parameter ONE_ONE	 = 6'b100000;

// Internal variables
logic  next_state,  state;
logic  pattern_detected_i;

// Functionality blocks


// comb block
always_comb begin

	next_state = state;
	case(state)
	
	 IDLE: if serial_pattern_i ==   




end


// Sequential block
always_ff @( posedge clk )
begin
	if (rstb == 1'b0) begin
		state <= IDLE;
		pattern_detected <= 1'b0;
	end else if (rstb == 1'b1 && enable == 0) begin
		state <= IDLE;
		pattern_detected <= 1'b0;
	end else begin
		state <= next_state;
		pattern_detected <= pattern_detected_i;
	end
end

endmodule

// Adding comment at the end

