----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.03.2020 07:49:12
-- Design Name: 
-- Module Name: top_level - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_divider is
    Port ( CLKIN : in STD_LOGIC;
           EN : in STD_LOGIC;
           COUNT_TO : in integer;
           CLKOUT : out STD_LOGIC);
end clock_divider;

architecture Behavioral of clock_divider is

    signal clk_limit : integer; -- 1 Hz   "

	signal clk_ctr : integer;
	signal temp_clk : std_logic;

begin

    clk_limit <= COUNT_TO;

 	clock: process (CLKIN)

		begin
		if EN = '0' then
            if CLKIN = '1' and CLKIN'Event then
              if clk_ctr >= clk_limit then				-- if counter == (1Hz count)/2
                 temp_clk <= not temp_clk;				--  toggle clock
                 clk_ctr <= 0;					--  reset counter
              else										-- else
                 clk_ctr <= clk_ctr + 1;	--  counter = counter + 1
              end if;
            end if;
        end if;

	end process clock;

	CLKOUT <= temp_clk;
    
end Behavioral;
