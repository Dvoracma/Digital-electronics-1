----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:40:48 04/28/2020 
-- Design Name: 
-- Module Name:    PWM - Behavioral 
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

entity PWM is
	port(
			clk_i		:in std_logic;
			pwm_en	:in std_logic; -- output when counter reach 0
			pwm_o		:out std_logic
			);
end PWM;

architecture Behavioral of PWM is

	signal s_cnt		:std_logic_vector(7 downto 0);
	signal duty_cyc	:unsigned(g_NBIT-1 downto 0) := (others => '0');
	signal s_pwm_o 	:std_logic;
	
begin

	pwm: process(clk_i)
		begin
			if rising_edge(clk_i) then
				if pwm_en = '1' then				--counter reached 0
					duty_cyc <= "00000000";
				else
					duty_cyc <= "01100100";
				end if;
				s_cnt <= s_cnt+1;
			end if;
		end process;
	s_pwm_o <= '1' when  duty_cyc = "00000000" else '0';
	
	s_pwm_o <= pwm_o;
	
end Behavioral;




