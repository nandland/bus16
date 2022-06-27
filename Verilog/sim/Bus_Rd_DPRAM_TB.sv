// Simple test bench for Bus_Rd_DPRAM

module Bus_Rd_DPRAM_TB ();
  
  import Sim_Bus_Pkg::*;
  import Sim_Checker_Pkg::*;

  logic r_Bus_Clk = 1'b0, r_Wr_DV = 1'b0;
  logic [15:0] r_Wr_Data = 0, r_Wr_Addr = 0, w_Rd_Data;
  
  // Clock Generator:
  always #5 r_Bus_Clk = ~r_Bus_Clk;

  // Bus Interface
  Bus_Interface hook(.i_Bus_Clk(r_Bus_Clk));

  // Bus Driver
  Bus_Driver d1 = new(hook);

  // Sim Checker
  Sim_Checker c1 = new("Bus_Rd_DPRAM_TB");
  
  Bus_Rd_DPRAM #(.DEPTH(256)) UUT
  (.i_Bus_Clk(r_Bus_Clk),
   .i_Bus_CS(hook.r_Bus_CS),
   .i_Bus_Wr_Rd_n(hook.r_Bus_Wr_Rd_n),
   .i_Bus_Addr8(hook.r_Bus_Addr8[15:0]),
   .i_Bus_Wr_Data(hook.r_Bus_Wr_Data),
   .o_Bus_Rd_Data(hook.r_Bus_Rd_Data),
   .o_Bus_Rd_DV(hook.r_Bus_Rd_DV),
   // Write Interface
   .i_Wr_Clk(r_Bus_Clk),
   .i_Wr_Addr(r_Wr_Addr),
   .i_Wr_DV(r_Wr_DV),
   .i_Wr_Data(r_Wr_Data));
  
  task Write_Data(input [15:0] data, input [15:0] addr);
    @(posedge r_Bus_Clk);
    r_Wr_DV   <= 1'b1;
    r_Wr_Data <= data;
    r_Wr_Addr <= addr;
    @(posedge r_Bus_Clk);
    r_Wr_DV   <= 1'b0;
    @(posedge r_Bus_Clk);
  endtask


  initial
    begin

      c1.t_Set_Printing(1); // Print all Passes and Failures to Console
      d1.t_Bus_Print_Disable(); // Turn off printing of Bus driver
      
      // TEST 1 - Write some data at 0, read back on Bus IF
      Write_Data(16'hABCD, 0);
      d1.t_Bus_Rd(0, w_Rd_Data);
      c1.t_Compare_Two_Inputs(16'hABCD, w_Rd_Data);

      // Repeat for location 5
      Write_Data(16'hDEAD, 5);
      d1.t_Bus_Rd(5<<1, w_Rd_Data); // addr8 to addr16 convert
      c1.t_Compare_Two_Inputs(16'hDEAD, w_Rd_Data);
      
      // Ensure a bus write is not effective, it should be ignored.
      d1.t_Bus_Wr(5, 16'hBEEF);
      d1.t_Bus_Rd(5<<1, w_Rd_Data); // addr8 to addr16 convert
      c1.t_Compare_Two_Inputs(16'hDEAD, w_Rd_Data);
            
      c1.t_Print_Results();

      $finish();
      
    end
  
endmodule
