----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:21:34 04/24/2020 
-- Design Name: 
-- Module Name:    instr_memory - Behavioral 
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

entity instr_memory is
    Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           instr_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end instr_memory;

architecture Behavioral of instr_memory is

	-- a modifier pr prendre fichier code
	signal instr : := rom(file => "test_intr_memory"); 

	--voir pour lecture fichier 
	--fopen

begin
	
	process
	begin
		wait until CLK'event and CLK = '1';
		instr_OUT <= instr(to_integer(unsigned(addr)));
	end process;

end Behavioral;

