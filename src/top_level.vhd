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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
    Port ( CLK100MHZ : in STD_LOGIC;
           CPU_RESETN : in STD_LOGIC;
           BTNL : in STD_LOGIC;
           BTNU : in STD_LOGIC;
           BTND : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           CA, CB, CC, CD, CE, CF, CG : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0));
end top_level;

architecture Behavioral of top_level is

signal clock_div_to : integer;
signal count_clock : std_logic;
signal binout0, binout1, binout2, binout3, binout4, binout5, binout6, binout7 : std_logic_vector(3 downto 0);
signal cout1, cout2, cout3, cout4, cout5, cout6, cout7, cout8 : std_logic;
signal screen_select : std_logic_vector (2 downto 0);
signal screen_bin : std_logic_vector (3 downto 0);
signal debounced_up, debounced_down, debounced_left, debounced_centre : std_logic;
signal cpu_reset, cpu_reset_invert : std_logic;
signal clock_reset, clock_pause : std_logic;

component counter
    Port ( CLKIN : in STD_LOGIC;
           RESET : in STD_LOGIC;
           BINOUT : out STD_LOGIC_VECTOR (3 downto 0);
           COUT : out STD_LOGIC);
end component;

component clock_divider
    Port ( CLKIN : in STD_LOGIC;
           EN : in STD_LOGIC;
           COUNT_TO : in integer;
           CLKOUT : out STD_LOGIC);
end component;

component display_clock_div
    Port ( CLKIN : in STD_LOGIC;
           SELECT_OUT : out STD_LOGIC_VECTOR(2 downto 0));
end component;

component display_multiplexer
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
end component;

component frequency_modifier
    Port ( CLKIN : STD_LOGIC;
           RESET : STD_LOGIC;
           UP : in STD_LOGIC;
           DOWN : in STD_LOGIC;
           CLKLIMIT : out integer);
end component;

component debouncer
    Port (
        clk : in std_logic;             -- Clock signal (100MHz)
        input : in std_logic;           -- Input button signal
        output : out std_logic);        -- Output debounced signal
end component;

component BCD_to_7SEG
    Port ( bcd_in : in STD_LOGIC_VECTOR (3 downto 0);
           leds_out : out STD_LOGIC_VECTOR (1 to 7));
end component;

component toggle
    Port ( CLKIN : in STD_LOGIC;
           RESET : in STD_LOGIC;
           INPUT : in STD_LOGIC;
           OUTPUT : out STD_LOGIC);
end component;

begin
    cpu_reset_invert <= NOT cpu_reset;
    clock_reset <= cpu_reset_invert OR debounced_left;
    
    
    clock_div : clock_divider port map(CLKIN     =>  CLK100MHZ,
                                       EN        =>  clock_pause,
                                       COUNT_TO  =>  clock_div_to,
                                       CLKOUT    =>  count_clock);
                                       
    screen_clock_div : display_clock_div port map(CLKIN       =>  CLK100MHZ,
                                                  SELECT_OUT  =>  screen_select);
    
    freq_mod : frequency_modifier port map(CLKIN     =>  CLK100MHZ,
                                           RESET     =>  cpu_reset_invert,
                                           UP        =>  debounced_up,
                                           DOWN      =>  debounced_down,
                                           CLKLIMIT  =>  clock_div_to);
                                           
    counter0 : counter port map(CLKIN   =>  count_clock,
                                RESET   =>  clock_reset,
                                BINOUT  =>  binout0,
                                COUT    =>  cout1);
                                
    counter1 : counter port map(CLKIN   =>  cout1,
                                RESET   =>  clock_reset,
                                BINOUT  =>  binout1,
                                COUT    =>  cout2);
                                
    counter2 : counter port map(CLKIN   =>  cout2,
                                RESET   =>  clock_reset,
                                BINOUT  =>  binout2,
                                COUT    =>  cout3);
                                
    counter3 : counter port map(CLKIN   =>  cout3,
                                RESET   =>  clock_reset,
                                BINOUT  =>  binout3,
                                COUT    =>  cout4);
                                
    counter4 : counter port map(CLKIN   =>  cout4,
                                RESET   =>  clock_reset,
                                BINOUT  =>  binout4,
                                COUT    =>  cout5);
                                
    counter5 : counter port map(CLKIN   =>  cout5,
                                RESET   =>  clock_reset,
                                BINOUT  =>  binout5,
                                COUT    =>  cout6);
                                
    counter6 : counter port map(CLKIN   =>  cout6,
                                RESET   =>  clock_reset,
                                BINOUT  =>  binout6,
                                COUT    =>  cout7);
                               
    counter7 : counter port map(CLKIN   =>  cout7,
                                RESET   =>  clock_reset,
                                BINOUT  =>  binout7,
                                COUT    =>  cout8);
                                
    disp_multi : display_multiplexer port map(BININ0  =>  binout0,
                                              BININ1  =>  binout1,
                                              BININ2  =>  binout2,
                                              BININ3  =>  binout3,
                                              BININ4  =>  binout4,
                                              BININ5  =>  binout5,
                                              BININ6  =>  binout6,
                                              BININ7  =>  binout7,
                                              CS      =>  screen_select,
                                              BINOUT  =>  screen_bin,
                                              ANOUT   =>  AN);
     
     bcd_to_seg : BCD_to_7SEG port map(bcd_in=>screen_bin,
                                       leds_out(1)  =>  CA,
                                       leds_out(2)  =>  CB,
                                       leds_out(3)  =>  CC,
                                       leds_out(4)  =>  CD,
                                       leds_out(5)  =>  CE,
                                       leds_out(6)  =>  CF,
                                       leds_out(7)  =>  CG);
     
     debouncer_left : debouncer port map(clk     =>  CLK100MHZ,
                                         input   =>  BTNL,
                                         output  =>  debounced_left);
       
     debouncer_up : debouncer port map(clk     =>  CLK100MHZ,
                                       input   =>  BTNU,
                                       output  =>  debounced_up);
                                           
     debouncer_down : debouncer port map(clk     =>  CLK100MHZ,
                                         input   =>  BTND,
                                         output  =>  debounced_down);
                                       
     debouncer_centre : debouncer port map(clk     =>  CLK100MHZ,
                                         input   =>  BTNC,
                                         output  =>  debounced_centre);
                                         
     debouncer_cpu : debouncer port map(clk     =>  CLK100MHZ,
                                         input   =>  CPU_RESETN,
                                         output  =>  cpu_reset);
                                         
     pause_toggle : toggle port map(CLKIN   =>  CLK100MHZ,
                                    RESET   =>  cpu_reset_invert,
                                    INPUT   =>  debounced_centre,
                                    OUTPUT  =>  clock_pause);                                                                  

end Behavioral;
