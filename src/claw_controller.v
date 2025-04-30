// claw_controller.v
// ----------------------------------------------------
// This module controls the claw operations. When the state
// indicates a pick-up action (PICK_BOX), it drives the 'stop'
// and 'extend_claws' signals.
//
//              +---------------------+
//              | claw_controller     |
//              |                     |
//   state[2:0] |                     |
//      ------> |   if (state ==     |
//              |    PICK_BOX)        |--> stop
//              |                     |--> extend_claws
//              +---------------------+
// ----------------------------------------------------
module claw_controller (
    input  wire [2:0] state,
    output reg stop,
    output reg extend_claws
);

    always @(*) begin
        stop         = 0;
        extend_claws = 0;

        if (state == 3'b101) begin // PICK_BOX
            stop         = 1;
            extend_claws = 1;
        end
    end
endmodule
