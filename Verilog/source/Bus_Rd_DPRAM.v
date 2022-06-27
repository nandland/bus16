// Infers a Dual Port RAM using single clock (Bus Clock)
// Read port is tied to the Bus, bus can only read, not write.
// Write port can be written by any higher level module

module Bus_Rd_DPRAM #(parameter DEPTH = 256)
 (input         i_Bus_Clk,
  input         i_Bus_CS,
  input         i_Bus_Wr_Rd_n,
  input [15:0]  i_Bus_Addr8,
  output [15:0] o_Bus_Rd_Data,
  output        o_Bus_Rd_DV,
  // Write Interface
  input                     i_Wr_Clk,
  input [$clog2(DEPTH)-1:0] i_Wr_Addr,
  input                     i_Wr_DV,
  input [15:0]              i_Wr_Data);

  // This RAM has dedicated read and write ports.
  RAM_2Port #(.WIDTH(16), .DEPTH(DEPTH)) RAM_2Port_Inst
  (.i_Wr_Clk(i_Wr_Clk),
   .i_Wr_Addr(i_Wr_Addr),
   .i_Wr_DV(i_Wr_DV),
   .i_Wr_Data(i_Wr_Data),
   .i_Rd_Clk(i_Bus_Clk),
   .i_Rd_Addr({1'b0, i_Bus_Addr8[15:1]}),  // Conv from Addr8 to Addr16, drop LSb
   .i_Rd_En(!i_Bus_Wr_Rd_n & i_Bus_CS),
   .o_Rd_DV(o_Bus_Rd_DV),
   .o_Rd_Data(o_Bus_Rd_Data)
   );

endmodule
