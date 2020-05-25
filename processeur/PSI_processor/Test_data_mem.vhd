--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:55:38 05/25/2020
-- Design Name:   
-- Module Name:   /home/patrick/Documents/Cours/4A/TP/TP_PSI/ProjetSystemInfo/processeur/PSI_processor/Test_data_mem.vhd
-- Project Name:  PSI_processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: memory
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
 
ENTITY Test_data_mem IS
END Test_data_mem;
 
ARCHITECTURE behavior OF Test_data_mem IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT memory
    PORT(
         addr : IN  std_logic_vector(7 downto 0);
         v_IN : IN  std_logic_vector(7 downto 0);
         RW : IN  std_logic;
         RST : IN  std_logic;
         CLK : IN  std_logic;
         v_OUT : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal addr : std_logic_vector(7 downto 0) := (others => '0');
   signal v_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal RW : std_logic := '0';
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal v_OUT : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: memory PORT MAP (
          addr => addr,
          v_IN => v_IN,
          RW => RW,
          RST => RST,
          CLK => CLK,
          v_OUT => v_OUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
	RST<='0', '1' after 10 ns;
   RW<= '1' after 100 ns;
	v_in<=X"05"; 
	addr<=x"02";
	

END;
