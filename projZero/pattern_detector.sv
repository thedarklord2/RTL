// Output goes high when exactly 2 of the last 3 values are 1

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
logic  [5:0] 	next_state,  state;
logic  		pattern_detected_i;

// Functionality blocks


// comb block
always_comb begin

	next_state = state;
	case(state)
	 IDLE:  if (serial_pattern == 1'b0)  begin
			next_state = ZER;
			pattern_detected_i = 1'b0;
		end else if (serial_pattern == 1'b1) begin
			next_state = ONE;
			pattern_detected_i = 1'b0;
		end else begin
			next_state = IDLE;
			pattern_detected_i = 1'b0;
		end
				
	 ZER:  if (serial_pattern == 1'b0)  begin
			next_state = ZER_ZER;
			pattern_detected_i = 1'b0;
		end else if (serial_pattern == 1'b1) begin
			next_state = ZER_ONE;
			pattern_detected_i = 1'b0;
		end else begin
			next_state = IDLE;
			pattern_detected_i = 1'b0;
		end
	 ONE:  if (serial_pattern == 1'b0)  begin
			next_state = ONE_ZER;
			pattern_detected_i = 1'b0;
		end else if (serial_pattern == 1'b1) begin
			next_state = ONE_ONE;
			pattern_detected_i = 1'b0;
		end else begin
			next_state = IDLE;
			pattern_detected_i = 1'b0;
		end
	 ZER_ZER:  if (serial_pattern == 1'b0)  begin
			next_state = ZER_ZER;
			pattern_detected_i = 1'b0;
		end else if (serial_pattern == 1'b1) begin
			next_state = ZER_ONE;
			pattern_detected_i = 1'b0;
		end else begin
			next_state = IDLE;
			pattern_detected_i = 1'b0;
		end
	 ZER_ONE:  if (serial_pattern == 1'b0)  begin
			next_state = ONE_ZER;
			pattern_detected_i = 1'b0;
		end else if (serial_pattern == 1'b1) begin
			next_state = ONE_ONE;
			pattern_detected_i = 1'b1;
		end else begin
			next_state = IDLE;
			pattern_detected_i = 1'b0;
		end
	 ONE_ZER:  if (serial_pattern == 1'b0)  begin
			next_state = ZER_ZER;
			pattern_detected_i = 1'b0;
		end else if (serial_pattern == 1'b1) begin
			next_state = ZER_ONE;
			pattern_detected_i = 1'b1;
		end else begin
			next_state = IDLE;
			pattern_detected_i = 1'b0;
		end
	 ONE_ONE:  if (serial_pattern == 1'b0)  begin
			next_state = ONE_ZER;
			pattern_detected_i = 1'b1;
		end else if (serial_pattern == 1'b1) begin
			next_state = ONE_ONE;
			pattern_detected_i = 1'b0;
		end else begin
			next_state = IDLE;
			pattern_detected_i = 1'b0;
		end
	default: next_state = IDLE;
       endcase
end

// Sequential block
always_ff @( posedge clk or negedge rstb )
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



