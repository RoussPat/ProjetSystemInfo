--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:08:45 05/11/2020
-- Design Name:   
-- Module Name:   /home/patrick/Documents/Cours/4A/TP/TP_PSI/ProjetSystemInfo/processeur/PSI_processor/test_intr_memory.vhd
-- Project Name:  PSI_processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: instr_memory
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
 
ENTITY test_intr_memory IS
END test_intr_memory;
 
ARCHITECTURE behavior OF test_intr_memory IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT instr_memory
    PORT(
         addr : IN  std_logic_vector(7 downto 0);
         CLK : IN  std_logic;
         instr_OUT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal addr : std_logic_vector(7 downto 0) := (others => '0');
   signal CLK : std_logic := '0';

 	--Outputs
   signal instr_OUT : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: instr_memory PORT MAP (
          addr => addr,
          CLK => CLK,
          instr_OUT => instr_OUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

	addr <=X"01";

      -- insert stimulus here 

END;
