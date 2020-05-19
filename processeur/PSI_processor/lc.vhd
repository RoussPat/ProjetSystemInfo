----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:49:32 04/29/2020 
-- Design Name: 
-- Module Name:    lc - Behavioral 
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
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lc is
	Generic ( num_lc : STD_LOGIC:='0'); -- gestion du numero du LC 
   Port ( 	OP : in  STD_LOGIC_VECTOR (3 downto 0);
				val : out  STD_LOGIC);
end lc;

architecture Behavioral of lc is

begin

	val <= '1' when (num_lc = '0' AND (OP=X"5" OR OP=X"6" OR OP=X"7" OR OP=X"1" OR OP=X"2" OR OP=X"3"  )) else --gestion de LOG_C (registre) AFC COP 
			 '1' when (num_lc = '1' AND (OP=X"8")) else --gestion de LC_MEM (MEM) LOAD AND STORE
			 '0';
	

	
end Behavioral;

-- LC permet de dire s'il faut ecrire dans le banc de registre


