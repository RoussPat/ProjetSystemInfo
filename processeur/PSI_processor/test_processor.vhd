--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:43:47 05/11/2020
-- Design Name:   
-- Module Name:   /home/patrick/Documents/Cours/4A/TP/TP_PSI/ProjetSystemInfo/processeur/PSI_processor/test_processor.vhd
-- Project Name:  PSI_processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: processor
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_processor IS
END test_processor;
 
ARCHITECTURE behavior OF test_processor IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT processor
    PORT(
         CLK_PROC : IN  std_logic;
         RST_PROC : IN  std_logic;
         IP : IN  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_PROC : std_logic := '0';
   signal RST_PROC : std_logic := '0';
   signal IP : std_logic_vector(7 downto 0) := (others => '0');
   -- Clock period definitions
   constant CLK_PROC_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: processor PORT MAP (
          CLK_PROC => CLK_PROC,
          RST_PROC => RST_PROC,
          IP => IP
        );

   -- Clock process definitions
   CLK_PROC_process :process
   begin
		CLK_PROC <= '0';
		wait for CLK_PROC_period/2;
		CLK_PROC <= '1';
		wait for CLK_PROC_period/2;
   end process;
	
	IP<=X"00" after 50 ns,
	X"01" after 100 ns,
	X"02" after 150 ns,
	X"03" after 200 ns,
	X"04" after 250 ns,
	X"05" after 300 ns,
	X"06" after 350 ns,
	X"07" after 400 ns,
	X"08" after 450 ns,
	X"09" after 500 ns,
	X"0A" after 550 ns,
	X"0B" after 600 ns,
	X"0C" after 650 ns,
	X"0D" after 700 ns,
	X"0E" after 750 ns,
	X"0F" after 800 ns;
	RST_PROC <= '0', '1' after 50 ns;

END;
