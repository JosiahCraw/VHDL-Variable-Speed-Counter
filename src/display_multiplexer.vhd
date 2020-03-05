----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.03.2020 07:49:12
-- Design Name: 
-- Module Name: display_multiplexer - Behavioral
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

entity display_multiplexer is
    Port ( BININ0 : in STD_LOGIC_VECTOR (3 downto 0);
           BININ1 : in STD_LOGIC_VECTOR (3 downto 0);
           BININ2 : in STD_LOGIC_VECTOR (3 downto 0);
           BININ3 : in STD_LOGIC_VECTOR (3 downto 0);
           BININ4 : in STD_LOGIC_VECTOR (3 downto 0);
           BININ5 : in STD_LOGIC_VECTOR (3 downto 0);
           BININ6 : in STD_LOGIC_VECTOR (3 downto 0);
           BININ7 : in STD_LOGIC_VECTOR (3 downto 0);
           CS : in STD_LOGIC_VECTOR (2 downto 0);
           BINOUT : out STD_LOGIC_VECTOR (3 downto 0);
           ANOUT : out STD_LOGIC_VECTOR (7 downto 0));
end display_multiplexer;

architecture Behavioral of display_multiplexer is

signal temp_out : std_logic_vector (3 downto 0);
signal temp_anode : std_logic_vector (7 downto 0);

begin
    process (CS)
    begin
        case CS is
            when "000" => 
                temp_out <= BININ0;
                temp_anode <= "11111110";
            when "001" => 
                temp_out <= BININ1;
                temp_anode <= "11111101";
            when "010" => 
                temp_out <= BININ2;
                temp_anode <= "11111011";
            when "011" => 
                temp_out <= BININ3;
                temp_anode <= "11110111";
            when "100" => 
                temp_out <= BININ4;
                temp_anode <= "11101111";
            when "101" => 
                temp_out <= BININ5;
                temp_anode <= "11011111";
            when "110" => 
                temp_out <= BININ6;
                temp_anode <= "10111111";
            when "111" => 
                temp_out <= BININ7;
                temp_anode <= "01111111";
            when others => 
                temp_out <= "0000";
                temp_anode <= "11111111";
        end case;
    end process;
    
    BINOUT <= temp_out;
    ANOUT <= temp_anode;

end Behavioral;
