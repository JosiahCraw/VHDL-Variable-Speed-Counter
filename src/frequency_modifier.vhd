----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.03.2020 07:49:12
-- Design Name: 
-- Module Name: frequency_modifier - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity frequency_modifier is
    Port ( CLKIN : in STD_LOGIC;
           RESET : in STD_LOGIC;
           UP : in STD_LOGIC;
           DOWN : in STD_LOGIC;
           CLKLIMIT : out integer);
end frequency_modifier;

architecture Behavioral of frequency_modifier is

signal temp_limit : integer;
signal btn_up_prev, btn_down_prev : std_logic := '0';

begin
    double_count : process (CLKIN)
    variable limit : integer := 50000000;
    begin
        if rising_edge(CLKIN) then
            if RESET = '1' then
                limit := 50000000;
            elsif UP = '1' and btn_up_prev = '0' then
                limit := to_integer(shift_right(to_unsigned(limit, 32), 1));
                if limit = 0 then
                    limit := 100000000;
                end if;
                btn_up_prev <= '1';
            elsif DOWN = '1' and btn_down_prev = '0' then
                limit := to_integer(shift_left(to_unsigned(limit, 32), 1));
                if limit >= 100000001 then
                    limit := 1;
                end if;
                btn_down_prev <= '1';
            end if;
            
            if DOWN = '0' then
                btn_down_prev <= '0';
            end if;
            if UP = '0' then
                btn_up_prev <= '0';
            end if;
            temp_limit <= limit;
        end if;
    end process double_count;
    
    CLKLIMIT <= temp_limit;
    
end Behavioral;
