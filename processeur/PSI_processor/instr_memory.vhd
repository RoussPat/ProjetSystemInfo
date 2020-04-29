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
use std.textio.all;
use ieee.std_logic_textio.all;
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

entity instr_memory is
    Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           instr_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end instr_memory;

architecture Behavioral of instr_memory is
	--mem_array <= init_mem("nom du fichier, il faut le chemin je crois");
	-- INIT a faire ???
	signal instruction_OUT: mem_array_t := init_mem(filename => "./executable.hex");
	-- Permet de recuperer un fichier avec les instructions a executer
	type mem_array is array(0 to 2**8-1) of std_logic_vector(7 downto 0);
	-- Init memory with the filename "init_file" or not.
	impure function init_mem(filename: in string) return mem_array_t is
	 file f_handler: text;
	 variable mem: mem_array_t;
	 variable f_line: line;
	 variable data_line : std_logic_vector(7 downto 0);
	 variable good: boolean;
	 variable lineno: integer := 0;
	 
  begin
    mem := (others => (others => '0'));
    file_open(f_handler, filename, READ_MODE);
    while (not endfile(f_handler)) loop
      readline(f_handler, f_line);
      hread(f_line, data_line, good);
      assert good report "READ ERROR" severity warning;
      mem(lineno) := data_line;
      lineno := lineno + 1;
    end loop;
    file_close(f_handler);
    return mem;
  end function;

begin
	
	process
	begin
		wait until CLK'event and CLK = '1';
		instr_OUT <= instruction_OUT(to_integer(unsigned(addr)));
	end process;

end Behavioral;

