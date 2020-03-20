------------------------------------------------------------------------
--
-- Generates clock enable signal.
-- Xilinx XC2C256-TQ144 CPLD, ISE Design Suite 14.7
--
-- Copyright (c) 2019-2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stopwatch is
port(
		clk_i			: in std_logic;
		srst_n_i		: in std_logic;
		ce_100Hz_i	: in std_logic;
		cnt_en_i		: in std_logic;
		
		sec_h_o		: out std_logic_vector(4-1 downto 0); --(counter for tens of seconds)
		sec_1_o		: out std_logic_vector(4-1 downto 0); --(counter for seconds)
		hth_h_o		: out std_logic_vector(4-1 downto 0); --(counter for tenths of seconds)
		hth_l_o		: out std_logic_vector(4-1 downto 0)  --(counter for hundredths of seconds)
		);
end entity stopwatch;

architecture Behavioral of stopwatch is
	
    signal s_cnt0	   : std_logic;
	 signal s_hth_1_o	: unsigned(4-1 downto 0):= (others => '0');
	 signal s_hth_h_o	: unsigned(4-1 downto 0):= (others => '0');
	 signal s_sec_1_o	: unsigned(4-1 downto 0):= (others => '0');
	 signal s_sec_h_o	: unsigned(4-1 downto 0):= (others => '0');

begin
	
	p_stopwatch_cnt : process(clk_i)
	begin
 	   if rising_edge(clk_i) then  -- Rising clock edge
			if srst_n_i = '0' then  -- Synchronous reset (active low)
				s_hth_1_o <= x"0";
				s_hth_h_o <= x"0";
				s_sec_1_o <= x"0";
				s_sec_h_o <= x"0";
				
				else if s_cnt0 = '1' then
					if ce_100Hz_i = '1' then
						if s_hth_1_o <= "1001" then
							s_hth_1_o <= "0000";
	
							if s_hth_h_o <= "1001" then
								s_hth_h_o <= "0000";
					
								if s_sec_1_o <= "1001" then
									s_sec_1_o <= "0000";
						
									if s_sec_h_o <= "0101" then
										s_sec_h_o <= "0000";
							
									else 
										s_sec_h_o <= s_sec_h_o + 1;
									end if;
						
								else
									s_sec_1_o <= s_sec_1_o + 1;
								end if;
					
							else 
								s_hth_h_o <= s_hth_h_o + 1;
							end if;
				
						else 
							s_hth_1_o <= s_hth_1_o + 1;
						end if;	

					end if;
				end if;
			end if;
		end if;
end process p_stopwatch_cnt;

    hth_l_o <= std_logic_vector(s_hth_1_o);
	 hth_h_o <= std_logic_vector(s_hth_h_o);
	 sec_1_o <= std_logic_vector(s_sec_1_o);
 	 sec_h_o <= std_logic_vector(s_sec_h_o);


end architecture Behavioral;
