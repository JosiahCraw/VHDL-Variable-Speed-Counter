----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.03.2020 07:49:12
-- Design Name: 
-- Module Name: counter - Behavioral
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

entity counter is
    Port ( CLKIN : in STD_LOGIC;
           RESET : in STD_LOGIC;
           BINOUT : out STD_LOGIC_VECTOR (3 downto 0);
           COUT : out STD_LOGIC);
end counter;

architecture Behavioral of counter is
signal count : std_logic_vector(3 downto 0);
signal temp_out : std_logic;

begin
    counter: process (CLKIN)
    begin
        if RESET = '1' then
            count <= "0000";
        elsif rising_edge(CLKIN) then
            if count = "1001" then
                count <= "0000";
                temp_out <= '1';
            else
                count <= count + "0001";
                temp_out <= '0';
            end if;
        end if;
    end process counter;
        
    COUT <= temp_out;
    BINOUT <= count;


end Behavioral;
