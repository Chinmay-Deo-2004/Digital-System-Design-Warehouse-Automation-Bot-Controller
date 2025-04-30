// top_module.v
// ----------------------------------------------------
// Top-level module that instantiates the FSM controller,
// the motor driver, and the claw controller. It connects
// all signals to produce the final output.
//
//            +---------------------+
//            |     top_module      |
//            |                     |
//            |  +--------------+   |
//            |  | fsm_controller|--|--> state[2:0]
//            |  +--------------+   |
//            |         |          |
//            |         v          |
//            |  +--------------+   |
//            |  | motor_driver |--|--> drive_lm, drive_rm, make_u_turn
//            |  +--------------+   |
//            |         |          |
//            |         v          |
//            |  +--------------+   |
//            |  | claw_controller|-> stop, extend_claws
//            |  +--------------+   |
//            +---------------------+
// ----------------------------------------------------
module top_module (
    input  wire clk,
    input  wire reset,
    input  wire start_signal,
    input  wire ls_detect,
    input  wire rs_detect,
    input  wire collision_detect,
    input  wire rfid_detect,
    output wire drive_lm,
    output wire drive_rm,
    output wire make_u_turn,
    output wire stop,
    output wire extend_claws
);

    wire [2:0] state;

    // Instantiate the FSM controller
    fsm_controller fsm_inst (
        .clk(clk),
        .reset(reset),
        .start_signal(start_signal),
        .ls_detect(ls_detect),
        .rs_detect(rs_detect),
        .collision_detect(collision_detect),
        .rfid_detect(rfid_detect),
        .state(state)
    );

    // Instantiate the motor driver
    motor_driver motor_inst (
        .state(state),
        .drive_lm(drive_lm),
        .drive_rm(drive_rm),
        .make_u_turn(make_u_turn)
    );

    // Instantiate the claw controller
    claw_controller claw_inst (
        .state(state),
        .stop(stop),
        .extend_claws(extend_claws)
    );

endmodule
