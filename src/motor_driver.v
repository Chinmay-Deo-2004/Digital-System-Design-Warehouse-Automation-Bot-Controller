// motor_driver.v
// ----------------------------------------------------
// This module drives the left motor (LM) and right motor (RM)
// based on the state provided by the FSM.
//
//                +---------------+
//                | motor_driver  |
//   state[2:0]---|               |--- drive_lm
//                |               |--- drive_rm
//                |               |--- make_u_turn
//                +---------------+
// ----------------------------------------------------
module motor_driver (
    input  wire [2:0] state,
    output reg drive_lm,
    output reg drive_rm,
    output reg make_u_turn
);

    always @(*) begin
        drive_lm   = 0;
        drive_rm   = 0;
        make_u_turn = 0;

        case (state)
            3'b001: begin // DRIVE_BOTH
                drive_lm = 1;
                drive_rm = 1;
            end
            3'b010: drive_rm = 1; // DRIVE_RM_ONLY
            3'b011: drive_lm = 1; // DRIVE_LM_ONLY
            3'b100: make_u_turn = 1; // U_TURN
            default: ; // No motor action for other states
        endcase
    end
endmodule
