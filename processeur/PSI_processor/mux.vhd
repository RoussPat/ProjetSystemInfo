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
	Generic ( num_Mux : NATURAL := 0); -- permet de definir le numero du multiplexeur a utiliser
	Port ( 	 A  : in  STD_LOGIC_VECTOR (7 downto 0);
				 B  : out  STD_LOGIC_VECTOR (7 downto 0);
				 OP : in  STD_LOGIC_VECTOR (2 downto 0);
				 S  : in  STD_LOGIC_VECTOR (7 downto 0));
end mux;

architecture Behavioral of mux is
begin
	S <=  B when (num_Mux = 1 and OP = X"06") else -- mux DI/EX, AFC
			B when (num_Mux = 1 and OP = X"05") else -- mux DI/EX, COP	
			A when (num_Mux = 2 and OP = X"01") else -- mux EX/Mem, ADD 1
			A when (num_Mux = 2 and OP = X"02") else -- mux EX/Mem, MUL 2
			A when (num_Mux = 2 and OP = X"04") else -- mux EX/Mem, DIV 4
			A when (num_Mux = 2 and OP = X"03") else -- mux EX/Mem, SOU 3
			B;
	-- LOAD ??
	-- STORE ??
end Behavioral;
