-------------------------------------------------------------------------------
-- FPGA Bus Registers
-- Contains 16 Readable/Writable Registers
--
-- Generics:
-- g_BUS_WIDTH - Recommended to set to 8, 16, or 32.
-- g_INIT_XX   - Used to initalize registers to non-zero values.
-- 
-- Note: Address is used to increment into entire word of g_BUS_WIDTH
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity Bus_Reg_X16 is
  generic (
    g_BUS_WIDTH : integer := 8;
    g_INIT_00   : std_logic_vector(g_BUS_WIDTH-1 downto 0) := (others => '0');
    g_INIT_02   : std_logic_vector(g_BUS_WIDTH-1 downto 0) := (others => '0');
    g_INIT_04   : std_logic_vector(g_BUS_WIDTH-1 downto 0) := (others => '0');
    g_INIT_06   : std_logic_vector(g_BUS_WIDTH-1 downto 0) := (others => '0');
    g_INIT_08   : std_logic_vector(g_BUS_WIDTH-1 downto 0) := (others => '0');
    g_INIT_0A   : std_logic_vector(g_BUS_WIDTH-1 downto 0) := (others => '0');
    g_INIT_0C   : std_logic_vector(g_BUS_WIDTH-1 downto 0) := (others => '0');
    g_INIT_0E   : std_logic_vector(g_BUS_WIDTH-1 downto 0) := (others => '0');
    g_INIT_10   : std_logic_vector(g_BUS_WIDTH-1 downto 0) := (others => '0');
    g_INIT_12   : std_logic_vector(g_BUS_WIDTH-1 downto 0) := (others => '0');
    g_INIT_14   : std_logic_vector(g_BUS_WIDTH-1 downto 0) := (others => '0');
    g_INIT_16   : std_logic_vector(g_BUS_WIDTH-1 downto 0) := (others => '0');
    g_INIT_18   : std_logic_vector(g_BUS_WIDTH-1 downto 0) := (others => '0');
    g_INIT_1A   : std_logic_vector(g_BUS_WIDTH-1 downto 0) := (others => '0');
    g_INIT_1C   : std_logic_vector(g_BUS_WIDTH-1 downto 0) := (others => '0');
    g_INIT_1E   : std_logic_vector(g_BUS_WIDTH-1 downto 0) := (others => '0')
    );
  port (
    i_Bus_Clk     : in  std_logic;
    i_Bus_CS      : in  std_logic;
    i_Bus_Wr_Rd_n : in  std_logic;
    i_Bus_Addr    : in  std_logic_vector(3 downto 0);
    i_Bus_Wr_Data : in  std_logic_vector(g_BUS_WIDTH-1 downto 0);
    o_Bus_Rd_Data : out std_logic_vector(g_BUS_WIDTH-1 downto 0) := (others => '0');
    o_Bus_Rd_DV   : out std_logic;
    -- 
    i_Reg_00      : in  std_logic_vector(g_BUS_WIDTH-1 downto 0);
    i_Reg_02      : in  std_logic_vector(g_BUS_WIDTH-1 downto 0);
    i_Reg_04      : in  std_logic_vector(g_BUS_WIDTH-1 downto 0);
    i_Reg_06      : in  std_logic_vector(g_BUS_WIDTH-1 downto 0);
    i_Reg_08      : in  std_logic_vector(g_BUS_WIDTH-1 downto 0);
    i_Reg_0A      : in  std_logic_vector(g_BUS_WIDTH-1 downto 0);
    i_Reg_0C      : in  std_logic_vector(g_BUS_WIDTH-1 downto 0);
    i_Reg_0E      : in  std_logic_vector(g_BUS_WIDTH-1 downto 0);
    i_Reg_10      : in  std_logic_vector(g_BUS_WIDTH-1 downto 0);
    i_Reg_12      : in  std_logic_vector(g_BUS_WIDTH-1 downto 0);
    i_Reg_14      : in  std_logic_vector(g_BUS_WIDTH-1 downto 0);
    i_Reg_16      : in  std_logic_vector(g_BUS_WIDTH-1 downto 0);
    i_Reg_18      : in  std_logic_vector(g_BUS_WIDTH-1 downto 0);
    i_Reg_1A      : in  std_logic_vector(g_BUS_WIDTH-1 downto 0);
    i_Reg_1C      : in  std_logic_vector(g_BUS_WIDTH-1 downto 0);
    i_Reg_1E      : in  std_logic_vector(g_BUS_WIDTH-1 downto 0);
    --
    o_Reg_00      : out std_logic_vector(g_BUS_WIDTH-1 downto 0) := g_INIT_00;
    o_Reg_02      : out std_logic_vector(g_BUS_WIDTH-1 downto 0) := g_INIT_02;
    o_Reg_04      : out std_logic_vector(g_BUS_WIDTH-1 downto 0) := g_INIT_04;
    o_Reg_06      : out std_logic_vector(g_BUS_WIDTH-1 downto 0) := g_INIT_06;
    o_Reg_08      : out std_logic_vector(g_BUS_WIDTH-1 downto 0) := g_INIT_08;
    o_Reg_0A      : out std_logic_vector(g_BUS_WIDTH-1 downto 0) := g_INIT_0A;
    o_Reg_0C      : out std_logic_vector(g_BUS_WIDTH-1 downto 0) := g_INIT_0C;
    o_Reg_0E      : out std_logic_vector(g_BUS_WIDTH-1 downto 0) := g_INIT_0E;
    o_Reg_10      : out std_logic_vector(g_BUS_WIDTH-1 downto 0) := g_INIT_10;
    o_Reg_12      : out std_logic_vector(g_BUS_WIDTH-1 downto 0) := g_INIT_12;
    o_Reg_14      : out std_logic_vector(g_BUS_WIDTH-1 downto 0) := g_INIT_14;
    o_Reg_16      : out std_logic_vector(g_BUS_WIDTH-1 downto 0) := g_INIT_16;
    o_Reg_18      : out std_logic_vector(g_BUS_WIDTH-1 downto 0) := g_INIT_18;
    o_Reg_1A      : out std_logic_vector(g_BUS_WIDTH-1 downto 0) := g_INIT_1A;
    o_Reg_1C      : out std_logic_vector(g_BUS_WIDTH-1 downto 0) := g_INIT_1C;
    o_Reg_1E      : out std_logic_vector(g_BUS_WIDTH-1 downto 0) := g_INIT_1E
    );
end Bus_Reg_X16;

architecture RTL of Bus_Reg_X16 is

begin

  p_Reg : process (i_Bus_Clk) is
  begin
    if rising_edge(i_Bus_Clk) then
      o_Bus_Rd_DV <= '0';

      if i_Bus_CS = '1' then
        if i_Bus_Wr_Rd_n = '1' then
          
          case to_bitvector(i_Bus_Addr) is
            when "0000" =>
              o_Reg_00 <= i_Bus_Wr_Data;
            when "0001" =>
              o_Reg_02 <= i_Bus_Wr_Data;
            when "0010" =>
              o_Reg_04 <= i_Bus_Wr_Data;
            when "0011" =>
              o_Reg_06 <= i_Bus_Wr_Data;
            when "0100" =>
              o_Reg_08 <= i_Bus_Wr_Data;
            when "0101" =>
              o_Reg_0A <= i_Bus_Wr_Data;
            when "0110" =>
              o_Reg_0C <= i_Bus_Wr_Data;
            when "0111" =>
              o_Reg_0E <= i_Bus_Wr_Data;
            when "1000" =>
              o_Reg_10 <= i_Bus_Wr_Data;
            when "1001" =>
              o_Reg_12 <= i_Bus_Wr_Data;
            when "1010" =>
              o_Reg_14 <= i_Bus_Wr_Data;
            when "1011" =>
              o_Reg_16 <= i_Bus_Wr_Data;
            when "1100" =>
              o_Reg_18 <= i_Bus_Wr_Data;
            when "1101" =>
              o_Reg_1A <= i_Bus_Wr_Data;
            when "1110" =>
              o_Reg_1C <= i_Bus_Wr_Data;
            when "1111" =>
              o_Reg_1E <= i_Bus_Wr_Data;              
          end case;

        else
          o_Bus_Rd_DV   <= '1';
          
          case to_bitvector(i_Bus_Addr) is
            when "0000" =>
              o_Bus_Rd_Data <= i_Reg_00;
            when "0001" =>
              o_Bus_Rd_Data <= i_Reg_02;
            when "0010" =>
              o_Bus_Rd_Data <= i_Reg_04;
            when "0011" =>
              o_Bus_Rd_Data <= i_Reg_06;
            when "0100" =>
              o_Bus_Rd_Data <= i_Reg_08;
            when "0101" =>
              o_Bus_Rd_Data <= i_Reg_0A;
            when "0110" =>
              o_Bus_Rd_Data <= i_Reg_0C;
            when "0111" =>
              o_Bus_Rd_Data <= i_Reg_0E;
            when "1000" =>
              o_Bus_Rd_Data <= i_Reg_10;
            when "1001" =>
              o_Bus_Rd_Data <= i_Reg_12;
            when "1010" =>
              o_Bus_Rd_Data <= i_Reg_14;
            when "1011" =>
              o_Bus_Rd_Data <= i_Reg_16;
            when "1100" =>
              o_Bus_Rd_Data <= i_Reg_18;
            when "1101" =>
              o_Bus_Rd_Data <= i_Reg_1A;
            when "1110" =>
              o_Bus_Rd_Data <= i_Reg_1C;
            when "1111" =>
              o_Bus_Rd_Data <= i_Reg_1E;
          end case;
        end if;
      end if;
    end if;
  end process p_Reg;

end architecture RTL;
