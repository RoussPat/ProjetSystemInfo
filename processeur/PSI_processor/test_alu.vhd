
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
USE ieee.numeric_std.ALL;
 
ENTITY test_alu IS
END test_alu;
 
ARCHITECTURE behavior OF test_alu IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         S : OUT  std_logic_vector(7 downto 0);
         Ctrl_Alu : IN  std_logic_vector(3 downto 0);
         C_Flag : OUT  std_logic;
         Z_Flag : OUT  std_logic;
         O_Flag : OUT  std_logic;
         N_Flag : OUT  std_logic
        );
    END COMPONENT;
	
	  -- Clock period definitions
   constant CLK_period : time := 50 ns;
	
   --Inputs
	signal CLK : std_logic :='0';
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');
   signal Ctrl_Alu : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal S : std_logic_vector(7 downto 0);
   signal C_Flag : std_logic;
   signal Z_Flag : std_logic;
   signal O_Flag : std_logic;
   signal N_Flag : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu PORT MAP (
			 A => A,
			 B => B,
          S => S,
          Ctrl_Alu => Ctrl_Alu,
          C_Flag => C_Flag,
          Z_Flag => Z_Flag,
          O_Flag => O_Flag,
          N_Flag => N_Flag
        );

   -- Clock process definitions
	CLK_process :process
	begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
	end process;
 
	 -- Stimulus process
	 
		A <= X"01";
		B <= X"02";
      Ctrl_Alu <= X"0", X"1" after 100ns, X"2" after 200 ns, X"3" after 300ns;
     
--    Stimulus process
--   stim_proc: process
--   begin		
--       hold reset state for 100 ns.
--      wait for 100 ns;	
--
--      wait for CLK_period*10;
--
--       insert stimulus here 
--
--      wait;
--   end process;

END;