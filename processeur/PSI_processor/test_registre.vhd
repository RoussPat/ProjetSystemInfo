--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:43:11 05/11/2020
-- Design Name:   
-- Module Name:   /home/erpeldin/Documents/4IR/S8/ProjetSystemInfo/processeur/PSI_processor/test_registre.vhd
-- Project Name:  PSI_processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: registre
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
 
ENTITY test_registre IS
END test_registre;
 
ARCHITECTURE behavior OF test_registre IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT registre
    PORT(
         A : IN  std_logic_vector(3 downto 0);
         B : IN  std_logic_vector(3 downto 0);
         addrW : IN  std_logic_vector(3 downto 0);
         W : IN  std_logic;
         DATA : IN  std_logic_vector(7 downto 0);
         RST : IN  std_logic;
         CLK : IN  std_logic;
         QA : OUT  std_logic_vector(7 downto 0);
         QB : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');
   signal addrW : std_logic_vector(3 downto 0) := (others => '0');
   signal W : std_logic := '0';
   signal DATA : std_logic_vector(7 downto 0) := (others => '0');
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal QA : std_logic_vector(7 downto 0);
   signal QB : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: registre PORT MAP (
          A => A,
          B => B,
          addrW => addrW,
          W => W,
          DATA => DATA,
          RST => RST,
          CLK => CLK,
          QA => QA,
          QB => QB
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
      -- insert stimulus here 
	
	RST <= '0', '1' after 100 ns,'0' after 850 ns; -- RST=0 => initialisation des registres a 0
	W <= '0', '1' after 260 ns, '0' after 700 ns;
	DATA <=X"00", X"02" after 250 ns, X"05" after 500 ns;
	addrW <= X"0", X"1" after 250 ns, X"2" after 500 ns;
	A <= X"1" after 690 ns;
	B <= X"2" after 690 ns;

  

END;
