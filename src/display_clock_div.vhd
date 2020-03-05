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

entity display_clock_div is
    Port ( CLKIN : in STD_LOGIC;
           SELECT_OUT : out STD_LOGIC_VECTOR(2 downto 0));
end display_clock_div;

architecture Behavioral of display_clock_div is

    constant clk_limit : std_logic_vector(27 downto 0) := X"00225A0";

	signal clk_ctr : std_logic_vector(27 downto 0);
	signal temp_sel : std_logic_vector(2 downto 0);

begin

 	clock: process (CLKIN)

		begin
		if CLKIN = '1' and CLKIN'Event then
		  if clk_ctr = clk_limit then				-- if counter == (1Hz count)/2
		  	 temp_sel <= temp_sel + "001";
			 clk_ctr <= X"0000000";					--  reset counter
		  else											-- else
		  	 clk_ctr <= clk_ctr + X"0000001";	--  counter = counter + 1
		  end if;
		end if;

	end process clock;
	
	SELECT_OUT <= temp_sel;
    


end Behavioral;
