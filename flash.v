// -*- verilog -*-
// Flash the LEDs in sequence on the Lattice iCE40-HX8K.

module flash (input clk, output reg [7:0] leds);
   // Counter which counts upwards continually (wrapping around).
   // We don't bother to initialize it because the initial value
   // doesn't matter.
   reg [18:0] counter;
   // This register counts from 0-7, incrementing when the
   // counter is 0.  The output is wired to the LEDs.
   reg [2:0] led_select;

   always @(posedge clk) begin
      counter <= counter + 1;

      if (counter[18:0] == 0) begin
         led_select <= led_select + 1;
      end
   end

   // Finally wire each LED so it signals the value of the led_select
   // register.
   genvar i;
   for (i = 0; i < 8; i=i+1) begin
      assign leds[i] = i == led_select;      
   end
endmodule // flash
