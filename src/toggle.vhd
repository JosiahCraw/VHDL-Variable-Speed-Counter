----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2020 08:11:21 AM
-- Design Name: 
-- Module Name: toggle - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity toggle is
    Port ( CLKIN : in STD_LOGIC;
           RESET : in STD_LOGIC;
           INPUT : in STD_LOGIC;
           OUTPUT : out STD_LOGIC);
end toggle;

architecture Behavioral of toggle is

signal temp_output : std_logic := '0';
signal input_prev : std_logic := '0';

begin
    toggle : process(CLKIN)
    begin
        if rising_edge(CLKIN) then
            if RESET = '1' then
                input_prev <= '0';
                temp_output <= '0';
            end if;
            if INPUT = '1' AND input_prev = '0' then
                temp_output <= not temp_output;
                input_prev <= '1';
            end if;
            if INPUT = '0' then
                input_prev <= '0';
            end if;            
        end if;
    end process toggle;    
    
    OUTPUT <= temp_output;
end Behavioral;
