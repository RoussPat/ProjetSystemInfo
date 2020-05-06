--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:38:23 05/05/2020
-- Design Name:   
-- Module Name:   /home/erpeldin/Documents/4IR/S8/ProjetSystemInfo/processeur/PSI_processor/test_alu.vhd
-- Project Name:  PSI_processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_alu IS
END test_alu;
 
ARCHITECTURE behavior OF test_alu IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         S : OUT  std_logic_vector(7 downto 0);
         Ctrl_Alu : IN  std_logic_vector(2 downto 0);
         C_Flag : OUT  std_logic;
         Z_Flag : OUT  std_logic;
         O_Flag : OUT  std_logic;
         N_Flag : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal SIGNAL_A : std_logic_vector(7 downto 0) := (others => '0');
   signal SIGNAL_B : std_logic_vector(7 downto 0) := (others => '0');
   signal SIGNAL_Ctrl_Alu : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal SIGNAL_S : std_logic_vector(7 downto 0);
   signal SIGNAL_C_Flag : std_logic;
   signal SIGNAL_Z_Flag : std_logic;
   signal SIGNAL_O_Flag : std_logic;
   signal SIGNAL_N_Flag : std_logic;
   -- No clocks detected in port list. Replace CLK below with 
   -- appropriate port name 
 
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu PORT MAP (
          SIGNAL_A => SIGNAL_A,
          SIGNAL_B => SIGNAL_B,
          SIGNAL_S => SIGNAL_S,
          SIGNAL_Ctrl_Alu => SIGNAL_Ctrl_Alu,
          SIGNAL_C_Flag => SIGNAL_C_Flag,
          SIGNAL_Z_Flag => SIGNAL_Z_Flag,
          SIGNAL_O_Flag => SIGNAL_O_Flag,
          SIGNAL_N_Flag => SIGNAL_N_Flag
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
	SIGNAL_A 			<= (others => (others => '1'));
	SIGNAL_B 			<= (others => (others => '1'));
	SIGNAL_Ctrl_Alu 	<= (others => (others => '1'));
	SIGNAL_S 			<= (others => (others => '1'));
	
	SIGNAL_C_Flag <= '0', '1' after 30 ns, '0' after 600 ns;
	SIGNAL_Z_Flag <= '0', '1' after 250 ns, '0' after 270 ns;
	SIGNAL_O_Flag <= '0', '1' after 500 ns , '0' after 570 ns;
	SIGNAL_N_Flag <= '1', '0' after 300 ns;

   -- Stimulus process
--   stim_proc: process
--   begin		
--      -- hold reset state for 100 ns.
--      wait for 100 ns;	
--
--      wait for CLK_period*10;
--
--      -- insert stimulus here 
--
--      wait;
--   end process;

END;--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:38:23 05/05/2020
-- Design Name:   
-- Module Name:   /home/erpeldin/Documents/4IR/S8/ProjetSystemInfo/processeur/PSI_processor/test_alu.vhd
-- Project Name:  PSI_processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_alu IS
END test_alu;
 
ARCHITECTURE behavior OF test_alu IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         S : OUT  std_logic_vector(7 downto 0);
         Ctrl_Alu : IN  std_logic_vector(2 downto 0);
         C_Flag : OUT  std_logic;
         Z_Flag : OUT  std_logic;
         O_Flag : OUT  std_logic;
         N_Flag : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
	signal SIGNAL_CLK : std_logic;
   signal SIGNAL_A : std_logic_vector(7 downto 0) := (others => '0');
   signal SIGNAL_B : std_logic_vector(7 downto 0) := (others => '0');
   signal SIGNAL_Ctrl_Alu : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal SIGNAL_S : std_logic_vector(7 downto 0);
   signal SIGNAL_C_Flag : std_logic;
   signal SIGNAL_Z_Flag : std_logic;
   signal SIGNAL_O_Flag : std_logic;
   signal SIGNAL_N_Flag : std_logic;
   -- No clocks detected in port list. Replace CLK below with 
   -- appropriate port name 
 
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu PORT MAP (
          A=> SIGNAL_A,
          SIGNAL_B,
          SIGNAL_S,
          SIGNAL_Ctrl_Alu,
          SIGNAL_C_Flag,
          SIGNAL_Z_Flag,
          SIGNAL_O_Flag,
          SIGNAL_N_Flag
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
	SIGNAL_A 			<= X"ff";
	SIGNAL_B 			<= X"ff";
	SIGNAL_Ctrl_Alu 	<= X"ff";
	SIGNAL_S 			<= X"ff"; 
	
	SIGNAL_C_Flag <= '0', '1' after 30 ns, '0' after 600 ns;
	SIGNAL_Z_Flag <= '0', '1' after 250 ns, '0' after 270 ns;
	SIGNAL_O_Flag <= '0', '1' after 500 ns , '0' after 570 ns;
	SIGNAL_N_Flag <= '1', '0' after 300 ns;

   -- Stimulus process
--   stim_proc: process
--   begin		
--      -- hold reset state for 100 ns.
--      wait for 100 ns;	
--
--      wait for CLK_period*10;
--
--      -- insert stimulus here 
--
--      wait;
--   end process;

END;