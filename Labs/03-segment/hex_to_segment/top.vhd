------------------------------------------------------------------------
--
-- Implementation of hex to seven-segment decoder.
-- Xilinx XC2C256-TQ144 CPLD, ISE Design Suite 14.7
--
-- Copyright (c) 2018-2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for top level
------------------------------------------------------------------------
entity top is
    port (SW0, SW1:           in  std_logic;
          BTN0, BTN1:         in  std_logic;
          LD0, LD1, LD2, LD3: out std_logic;
          disp_seg_o:         out std_logic_vector(7-1 downto 0);
          disp_dig_o:         out std_logic_vector(4-1 downto 0));
end entity top;

------------------------------------------------------------------------
-- Architecture declaration for top level
------------------------------------------------------------------------
architecture Behavioral of top is
    signal s_hex: std_logic_vector(4-1 downto 0);   -- Internal signals
begin

    -- Combine inputs [SW1, SW0, BTN1, BTN0] into internal vector
    s_hex(3) <= SW1;
    s_hex(2) <= SW0;
    s_hex(1) <= not BTN1;
    s_hex(0) <= not BTN0;


    --------------------------------------------------------------------
    -- Sub-block of hex_to_7seg entity
    HEX2SSEG: entity work.hex_to_7seg
        port map (-- <entity port_name> => <signal_name>,
                  -- <entity port_name> => <signal_name>,
                  -- ...
                  -- <entity port_name> => <signal_name>);
                  hex_i => s_hex,
                  seg_o => disp_seg_o);

    -- Select display position
    disp_dig_o <= "1110";


    -- Turn on LD3 if the input value is equal to "0000"
    LD3 <= '0' when (s_hex = "0000") else '1';

    -- Turn on LD2 if the input value is A, B, C, D, E, or F
    LD2 <= '0' when (s_hex = "1010") else 
			  '0' when (s_hex = "1011") else 
			  '0' when (s_hex = "1100") else 
			  '0' when (s_hex = "1101") else 
			  '0' when (s_hex = "1110") else 
			  '0' when (s_hex = "1111") else '1';

    -- Turn on LD1 if the input value is odd, ie 1, 3, etc.
    LD1 <= '0' when (BTN0) else '1';


    -- Turn on LD0 if the input value is a power of two, ie 1, 2, 4, or 8.
    LD0 <= '0' when ((not BTN0 or BTN1 or SW0 or SW1) and ( BTN0 or not BTN1 or SW0 or SW1) 
					and ( BTN0 or BTN1 or not SW0 or SW1)and ( BTN0 or BTN1 or SW0 or not SW1)) else '1';

end architecture Behavioral;

