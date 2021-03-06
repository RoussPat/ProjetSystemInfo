----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:56:17 04/19/2020 
-- Design Name: 
-- Module Name:    registre - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity registre is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           addrW : in  STD_LOGIC_VECTOR (3 downto 0);
           W : in  STD_LOGIC;
           DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           QA : out  STD_LOGIC_VECTOR (7 downto 0);
           QB : out  STD_LOGIC_VECTOR (7 downto 0));
end registre;

architecture Behavioral of registre is

	type registres is array (NATURAL range <>) of STD_LOGIC_VECTOR(7 downto 0);
	signal reg : registres(15 downto 0);

begin

	process
	begin
		wait until CLK'event and CLK = '1';
			if (RST='0') then
				-- initialisation du banc de registres a 0x00
				reg <= (others => X"00");
			elsif (W='1') then
				reg(to_integer(unsigned(addrW))) <= DATA;				
			end if;
	end process;
	
		QA <= reg(to_integer(unsigned(A)));
		QB <= reg(to_integer(unsigned(B)));
	
end Behavioral;

-- Notes : 

-- RST actif  0 --> contenu du banc mis  0x00

-- lecture de donnees : add_A, add_B, QA et QB
-- add_A et add_B permettent de lire 2 registres simultanment
-- QA et QB --> on leur donne les valeurs que l'on lit dans les registres (add_A, add_B)

-- ecriture de donnees : add_W, W et Data
-- W == 1 si ecriture
-- copier le contenu de Data dans le registre d'adresse add_W

--RST et ecrtiure se font en synchrone sur la CLK