// fsm_controller.v
`include "mux8to1.v"
`include "dff.v"

module fsm_controller (
    input  wire clk,
    input  wire reset,
    input  wire start_signal,
    input  wire ls_detect,
    input  wire rs_detect,
    input  wire collision_detect,
    input  wire rfid_detect,
    output wire [2:0] state
);

    wire [2:0] next_state;

    // Input values for 8:1 MUXes (bitwise)
    wire [7:0] ns_bit0_values;
    wire [7:0] ns_bit1_values;
    wire [7:0] ns_bit2_values;

    wire [2:0] current_state;
    assign state = current_state;

    wire [2:0] sel = current_state;

    // Bit 0 of next state
    assign ns_bit0_values[0] = start_signal;
    assign ns_bit0_values[1] = (ls_detect) ? 0 :
                               (rs_detect) ? 1 :
                               (collision_detect) ? 0 :
                               (rfid_detect) ? 1 : 1;
    assign ns_bit0_values[2] = (collision_detect || rfid_detect) ? 1 : 1;
    assign ns_bit0_values[3] = (collision_detect || rfid_detect) ? 1 : 1;
    assign ns_bit0_values[4] = 1;  // U_TURN -> DRIVE_BOTH (001)
    assign ns_bit0_values[5] = 0;  // PICK_BOX -> IDLE
    assign ns_bit0_values[6] = 0;
    assign ns_bit0_values[7] = 0;

    assign ns_bit1_values[0] = 0;
    assign ns_bit1_values[1] = (ls_detect || rs_detect) ? 1 : 0;
    assign ns_bit1_values[2] = 0;
    assign ns_bit1_values[3] = 0;
    assign ns_bit1_values[4] = 0;
    assign ns_bit1_values[5] = 0;
    assign ns_bit1_values[6] = 0;
    assign ns_bit1_values[7] = 0;

    assign ns_bit2_values[0] = 0;
    assign ns_bit2_values[1] = (collision_detect || rfid_detect) ? 1 : 0;
    assign ns_bit2_values[2] = (collision_detect || rfid_detect) ? 1 : 0;
    assign ns_bit2_values[3] = (collision_detect || rfid_detect) ? 1 : 0;
    assign ns_bit2_values[4] = 0;
    assign ns_bit2_values[5] = 0;
    assign ns_bit2_values[6] = 0;
    assign ns_bit2_values[7] = 0;

    // Instantiate MUXes for each bit
    mux8to1 mux0 (.in(ns_bit0_values), .sel(sel), .out(next_state[0]));
    mux8to1 mux1 (.in(ns_bit1_values), .sel(sel), .out(next_state[1]));
    mux8to1 mux2 (.in(ns_bit2_values), .sel(sel), .out(next_state[2]));

    // Instantiate 3 D Flip-Flops for state
    dff dff0 (.clk(clk), .reset(reset), .d(next_state[0]), .q(current_state[0]));
    dff dff1 (.clk(clk), .reset(reset), .d(next_state[1]), .q(current_state[1]));
    dff dff2 (.clk(clk), .reset(reset), .d(next_state[2]), .q(current_state[2]));

endmodule
