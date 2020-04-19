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
	signal reg : registres(3 downto 0); --a verifier pour la taille

begin

	process
	begin
	-- Le signal reset RST est actif à 0 : 
	-- le contenu du banc de registres est alors 
	-- initialisé à 0x00
		wait until CLK'event and CLK = '1';
			if (RST='0') then	
				reg <= (others => X"01") -- cmt tout mettre a 0? ?
			elsif (W='1') then
				reg(to_integer(unsigned(addrW))); <= DATA;				
			end if;				
-- @A et @B permettent de lire deux registres simultanément. 
-- Les valeurs correspondantes sont propagées vers les sorties QA et QB.
-- L’écriture de données dans un registre se fait par le biais des entrées @W, W et DATA. W
-- spécifie si une écriture doit être réalisée. Cette entrée est active à 1, pour une écriture. Lorsque
	end process;
	
		QA <= reg(to_integer(unsigned(A))) when W='0' else DATA;--verifier les conditions +bypass D ?
		QB <= reg(to_integer(unsigned(B))) when W='0' else DATA;
	
end Behavioral;

