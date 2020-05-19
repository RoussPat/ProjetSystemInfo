----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:48:15 04/29/2020 
-- Design Name: 
-- Module Name:    mux - Behavioral 
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

entity mux is
	Generic ( num_Mux : NATURAL := 0); -- permet de definir le numero du multiplexeur a utiliser (etage)
	Port ( 	 A  : in  STD_LOGIC_VECTOR (7 downto 0);
				 B  : in  STD_LOGIC_VECTOR (7 downto 0);
				 OP : in  STD_LOGIC_VECTOR (3 downto 0);
				 S  : out  STD_LOGIC_VECTOR (7 downto 0));
end mux;

architecture Behavioral of mux is
begin
	S <=  A when (num_Mux = 1 and OP = X"6") else -- mux DI/EX, AFC
			B when (num_Mux = 1 and OP = X"5") else -- mux DI/EX, COP
			B when (num_Mux = 1 and OP = X"7") else -- mux DI/EX, LOAD
			A when (num_Mux = 1 and OP = X"8") else -- mux DI/EX, STORE
			B when (num_Mux = 1) else
			B when (num_Mux = 2 and OP = X"1") else -- mux EX/Mem, ADD
			B when (num_Mux = 2 and OP = X"2") else -- mux EX/Mem, MUL
			B when (num_Mux = 2 and OP = X"4") else -- mux EX/Mem, DIV
			B when (num_Mux = 2 and OP = X"3") else -- mux EX/Mem, SOU
			A when (num_Mux = 2 ) else
			A when (num_Mux = 3 and OP = X"8") else -- mux sortie EX/Mem, STORE
			B when (num_mux = 3 ) else
			A when (num_Mux = 4 and OP = X"7") else -- mux Mem/RE, LOAD
			B;
end Behavioral;

