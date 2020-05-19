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
	port( CLK_PROC : in STD_LOGIC;
			RST_PROC : in STD_LOGIC;
			IP: in STD_LOGIC_VECTOR(7 downto 0));
end processor;

architecture Behavioral of processor is
	-- Composants du processeur
	component alu is
		Port (  A : in  STD_LOGIC_VECTOR (7 downto 0);
				  B : in  STD_LOGIC_VECTOR (7 downto 0);
				  S : out  STD_LOGIC_VECTOR (7 downto 0);
				  Crtl_Alu : in  STD_LOGIC_VECTOR (3 downto 0);
				  C_Flag : out  STD_LOGIC;
				  Z_Flag : out  STD_LOGIC;
				  O_Flag : out  STD_LOGIC;
				  N_Flag : out  STD_LOGIC);
	end component;

	component pipeline is
		Port (  CLK    : in  STD_LOGIC;
				  A_in   : in  STD_LOGIC_VECTOR (7 downto 0);
				  OP_in  : in  STD_LOGIC_VECTOR (3 downto 0);
				  B_in   : in  STD_LOGIC_VECTOR (7 downto 0);
				  C_in   : in  STD_LOGIC_VECTOR (7 downto 0);
				  A_out  : out  STD_LOGIC_VECTOR (7 downto 0);
				  OP_out : out  STD_LOGIC_VECTOR (3 downto 0);
				  B_out  : out  STD_LOGIC_VECTOR (7 downto 0);
				  C_out  : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component registre is
		Port (  A 		: in  STD_LOGIC_VECTOR (3 downto 0);
				  B 		: in  STD_LOGIC_VECTOR (3 downto 0);
				  addrW  : in  STD_LOGIC_VECTOR (3 downto 0);
				  W 		: in  STD_LOGIC;
				  DATA 	: in  STD_LOGIC_VECTOR (7 downto 0);
				  RST 	: in  STD_LOGIC;
				  CLK 	: in  STD_LOGIC;
				  QA		: out  STD_LOGIC_VECTOR (7 downto 0);
				  QB 		: out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component memory is
		Port (  addr  : in  STD_LOGIC_VECTOR (7 downto 0);
				  v_IN  : in  STD_LOGIC_VECTOR (7 downto 0);
				  RW 	  : in  STD_LOGIC;
				  RST   : in  STD_LOGIC;
				  CLK   : in  STD_LOGIC;
				  v_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component instr_memory is
		Port (  addr 		: in  STD_LOGIC_VECTOR (7 downto 0);
				  CLK 		: in  STD_LOGIC;
				  instr_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component mux is
		Generic ( num_Mux : NATURAL := 0); -- permet de definir le numero du multiplexeur a utiliser
		Port ( 	 A 	: in  STD_LOGIC_VECTOR (7 downto 0);
					 B 	: in  STD_LOGIC_VECTOR (7 downto 0);
					 OP 	: in  STD_LOGIC_VECTOR (3 downto 0);
					 S 	: out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component lc is
		Port ( OP  : in  STD_LOGIC_VECTOR (3 downto 0);
				 val : out  STD_LOGIC);
	end component;
	signal IP_AUX : STD_LOGIC_VECTOR(7 downto 0);
	signal OP_DI,OP_EX, OP_MEM, OP_RE:STD_LOGIC_VECTOR(3 downto 0);
	signal A_DI, B_DI, C_DI : STD_LOGIC_VECTOR(7 downto 0);
	signal A_EX, B_EX, C_EX : STD_LOGIC_VECTOR(7 downto 0);
	signal A_MEM, B_MEM, C_MEM : STD_LOGIC_VECTOR(7 downto 0);
	signal A_RE, B_RE, C_RE : STD_LOGIC_VECTOR(7 downto 0);
	signal Reg_QA, Reg_QB : STD_LOGIC_VECTOR(7 downto 0);
	signal Mux_BdR_Out: STD_LOGIC_VECTOR(7 downto 0);
	signal Instruction: STD_LOGIC_VECTOR(31 downto 0);
	signal LC_out : STD_LOGIC;
begin
	--au RST et au debut mettre IP a 0
	Instr_Mem : instr_memory PORT MAP(
		addr=>IP,
		CLK=>CLK_PROC,
		instr_OUT=>Instruction
		);

	Li_Di: pipeline PORT MAP (
		CLK => CLK_PROC,
		A_in => Instruction(23 downto 16),   
		OP_in => Instruction(27 downto 24), -- une chance sur 2 Little indian or big indian ?? pour tous
		B_in => Instruction(15 downto 8),
		C_in => Instruction(7 downto 0),
		A_out => A_DI,
		OP_out => OP_DI,
		B_out => B_DI,
		C_out => C_DI
	);
	
	Di_EX: pipeline PORT MAP (
		CLK => CLK_PROC,
		A_in => A_DI,   
		OP_in => OP_DI,
		B_in => Mux_BdR_Out,
		C_in => C_DI,
		A_out => A_EX,
		OP_out => OP_EX,
		B_out => B_EX,
		C_out => C_EX
	);
	
	EX_MEM: pipeline PORT MAP (
		CLK => CLK_PROC,
		A_in => A_EX,   
		OP_in => OP_EX,
		B_in => B_EX,
		C_in => C_EX,
		A_out => A_MEM,
		OP_out => OP_MEM,
		B_out => B_MEM,
		C_out => C_MEM
	);
	
	MEM_RE: pipeline PORT MAP (
		CLK => CLK_PROC,
		A_in => A_MEM,   
		OP_in => OP_MEM,
		B_in => B_MEM,
		C_in => C_MEM,
		A_out => A_RE,
		OP_out => OP_RE,
		B_out => B_RE,
		C_out => C_RE
	);
	
	LOG_C : lc PORT MAP (
		OP=>OP_RE,
		val => LC_out
	);
	
	Reg : registre PORT MAP( 
		A=>X"0",
		B=>X"0",
		addrW => A_RE(3 downto 0),
		W=>LC_out,
		DATA=> B_RE,
		RST=>RST_PROC,
		CLK=>CLK_PROC,
		QA=>Reg_QA,
		QB=>Reg_QB
	);
	
	Multiplexeur_BdR : MUX 
	Generic map (1)
	PORT MAP(
		A=>B_DI,
		B=>Reg_QA,
		OP=>OP_DI,
		S=>Mux_BdR_Out
	);

end Behavioral;

