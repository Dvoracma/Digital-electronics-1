----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:12:04 03/26/2020 
-- Design Name: 
-- Module Name:    traffic - Behavioral 
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
use ieee.numeric_std.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity traffic is
port (clk_i		: in STD_LOGIC;
		srst_n_i	: in STD_LOGIC;
		lights_o	: out STD_LOGIC_VECTOR(5 downto 0));
end traffic;

architecture traffic of traffic is

type state_type is (GR, YR, RR, RG, RY, RR_2);
signal state: state_type;
signal count: UNSIGNED(3 downto 0):=(others => '0');
constant sec5: UNSIGNED (3 downto 0):="1111";
constant sec1: UNSIGNED (3 downto 0):="0011";

begin

	process(clk_i,srst_n_i)

		begin
			if srst_n_i = '0' then --synchronous reset(active low)
				state <= GR;
				count <= x"0";
			elsif rising_edge(clk_i) then	
			if srst_n_i = '1' then

			case state is 
				when GR =>
					if count < sec5 then
						state <= GR;
						count <= count+1;
					else 
						state <= YR;
						count <= x"0";
					end if;
				when YR =>
					if count < sec1 then
						state <= YR;
						count <= count+1;
					else 
						state <= RR;
						count <= x"0";
					end if;
				when RR =>
					if count < sec1 then
						state <= RR;
						count <= count+1;
					else
						state <= RG;
						count <= x"0";
					end if;
				when RG =>
					if count < sec5 then
						state <= RG;
						count <= count+1;
					else
						state <= RY;
						count <= x"0";
					end if;
				when RY =>
					if count < sec1 then
						state <= RY;
						count <= count+1;
					else
						state <= RR_2;
						count <= x"0";
					end if;
				when RR_2 =>
					if count < sec1 then
						state <= RR_2;
						count <= count+1;
					else
						state <= GR;
						count <= x"0";
					end if;
				when others =>
						state <= GR;
			end case;
		
		end if;
		end if;
	end process;
	
	c2: process(state)
		begin
		case state is 
			when GR => lights_o <= "100001";
			when YR => lights_o <= "100010";
			when RR => lights_o <= "100100";
			when RG => lights_o <= "001100";
			when RY => lights_o <= "010100";
			when RR_2 => lights_o <= "100100";
			when others => lights_o <= "100001";
		end case;
	end process;
end traffic;

