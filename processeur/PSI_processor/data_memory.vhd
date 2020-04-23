----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:59:46 04/19/2020 
-- Design Name: 
-- Module Name:    memory - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory is
    Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
           v_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           RW : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           v_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
end memory;

architecture Behavioral of memory is

	type data is array (NATURAL range <>) of STD_LOGIC_VECTOR(7 downto 0);
	signal d : data(13 downto 0); --a verifier pour la taille

begin

	process
	begin
		-- synchrone
		wait until CLK'event and CLK = '1';
			if (RST='0') then	
				d <= (others => X"00"); -- cmt tout mettre a 0? ?
			elsif (RST='1') then
				-- lecture
				-- ???if (RW='1') then
					
				-- ecriture
				if (RW='0') then
					data(to_integer(unsigned(addr))) <= v_IN;
				end if;
			end if;
	end process;

end Behavioral;