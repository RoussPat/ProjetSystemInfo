----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:19:56 04/15/2020 
-- Design Name: 
-- Module Name:    processor - Behavioral 
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

entity processor is
	port( CLK : in STD_LOGIC;
			RST : in STD_LOGIC);
end processor;

architecture Behavioral of processor is
	-- Composants du processeur
	component alu is
		Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
				  B : in  STD_LOGIC_VECTOR (7 downto 0);
				  S : out  STD_LOGIC_VECTOR (7 downto 0);
				  Crtl_Alu : in  STD_LOGIC_VECTOR (2 downto 0);
				  C_Flag : out  STD_LOGIC;
				  Z_Flag : out  STD_LOGIC;
				  O_Flag : out  STD_LOGIC;
				  N_Flag : out  STD_LOGIC);
	end component;

	component pipeline is
		Port ( CLK   : in  STD_LOGIC;
				  A_in   : in  STD_LOGIC_VECTOR (7 downto 0);
				  OP_in  : in  STD_LOGIC_VECTOR (2 downto 0);
				  B_in   : in  STD_LOGIC_VECTOR (7 downto 0);
				  C_in   : in  STD_LOGIC_VECTOR (7 downto 0);
				  A_out  : out  STD_LOGIC_VECTOR (7 downto 0);
				  OP_out : out  STD_LOGIC_VECTOR (2 downto 0);
				  B_out  : out  STD_LOGIC_VECTOR (7 downto 0);
				  C_out  : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component registre is
		Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
				  B : in  STD_LOGIC_VECTOR (3 downto 0);
				  addrW : in  STD_LOGIC_VECTOR (3 downto 0);
				  W : in  STD_LOGIC;
				  DATA : in  STD_LOGIC_VECTOR (7 downto 0);
				  RST : in  STD_LOGIC;
				  CLK : in  STD_LOGIC;
				  QA : out  STD_LOGIC_VECTOR (7 downto 0);
				  QB : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component memory is
		Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
				  v_IN : in  STD_LOGIC_VECTOR (7 downto 0);
				  RW : in  STD_LOGIC;
				  RST : in  STD_LOGIC;
				  CLK : in  STD_LOGIC;
				  v_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component instr_memory is
		Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
				  CLK : in  STD_LOGIC;
				  instr_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component mux is
		Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
				  B : out  STD_LOGIC_VECTOR (7 downto 0);
				  OP : in  STD_LOGIC_VECTOR (2 downto 0);
				  S : in  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component lc is
		Port ( OP : in  STD_LOGIC_VECTOR (7 downto 0);
				  val : out  STD_LOGIC);
	end component;

begin


end Behavioral;

