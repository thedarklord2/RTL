// Output goes high when exactly 2 of the last 3 values are 1
//

module pattern_detector (
	input logic 	clk,
	input logic	rstb,
	input logic	serial_pattern_i,
	input logic	enable,
	input logic	pattern_detected_o
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


// Functionality blocks


// reset function
always_ff @( posedge clk )
begin
	if (rstb == 1'b1) begin
		next_state <= state;
	end else begin
		next_state <= IDLE;
	end
end

endmodule



