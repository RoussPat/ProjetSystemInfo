----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:58:36 04/15/2020 
-- Design Name: 
-- Module Name:    pipeline - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pipeline is
    Port ( CLK   : in  STD_LOGIC;
           A_in   : in  STD_LOGIC_VECTOR (7 downto 0);
           OP_in  : in  STD_LOGIC_VECTOR (3 downto 0);
           B_in   : in  STD_LOGIC_VECTOR (7 downto 0);
           C_in   : in  STD_LOGIC_VECTOR (7 downto 0);
           A_out  : out  STD_LOGIC_VECTOR (7 downto 0);
           OP_out : out  STD_LOGIC_VECTOR (3 downto 0);
           B_out  : out  STD_LOGIC_VECTOR (7 downto 0);
           C_out  : out  STD_LOGIC_VECTOR (7 downto 0));
end pipeline;

architecture Behavioral of pipeline is

begin

-- comportement synchrone
	process
	begin
		wait until CLK'event and CLK = '1';
			OP_out <= OP_in;
			A_out  <= A_in;
			B_out  <= B_in;
			C_out  <= C_in;
	end process;

end Behavioral;

