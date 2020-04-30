----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:09:45 04/28/2020 
-- Design Name: 
-- Module Name:    timer - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity timer is

generic (
			g_NBIT: positive := 10
			);

Port ( 	clk_i			: in STD_LOGIC;
        stopwatch_i		: in STD_LOGIC;
        pwm-en			: out STD_LOGIC;

end timer;

architecture Behavioral of timer is

	signal s_cnt : unsigned(g_NBIT-1 downto 0) := (others => '0');

begin

	timer_down: process (clk_i, stopwatch_0)
		begin
			if rising_edge(clk_i) then
				if stopwatch_i = '1' then
					if not s_cnt = x"0000" then
						s_cnt <= s_cnt - 1;
					else
						s_cnt <= enc_val; 		--value set by encoder
					end if;
				end if;
			end if;
		end process timer_down;
		
		pwm_en <= "1";
		
end Behavioral;

