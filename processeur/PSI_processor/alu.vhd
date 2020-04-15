----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:07:50 04/15/2020 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           S : out  STD_LOGIC_VECTOR (7 downto 0);
           Crtl_Alu : in  STD_LOGIC_VECTOR (2 downto 0);
           C_Flag : out  STD_LOGIC;
           Z_Flag : out  STD_LOGIC;
           O_Flag : out  STD_LOGIC;
           N_Flag : out  STD_LOGIC);
end alu;

architecture Behavioral of alu is

	-- Declaration des operations
	signal S_add : STD_LOGIC_VECTOR(7 downto 0);
	signal S_sou : STD_LOGIC_VECTOR(7 downto 0);
	signal S_mul : STD_LOGIC_VECTOR(7 downto 0);
	signal S_equ : STD_LOGIC;
	signal S_inf : STD_LOGIC;
	signal S_sup : STD_LOGIC;
	-- estce quon fait la division ??
	signal C : STD_LOGIC := '0';
	signal N : STD_LOGIC := '0';
	signal Z : STD_LOGIC := '0';
	signal V : STD_LOGIC := '0';
	
begin

-- Implementation des operations
	-- Gestion des erreurs
	S <=  S_add(7 downto 0) when Ctrl_ALU = X"01" else 
			S_sou(7 downto 0) when Ctrl_ALU = X"03" else
			S_mul(7 downto 0) when Ctrl_ALU = X"02" else
			S_equ when Ctrl_ALU = X"0B" else
			S_inf when Ctrl_ALU = X"09" else
			S_sup when Ctrl_ALU = X"0A" ;
			
	S_add <= ("0" & A)+ ("0" & B); 
	S_sou <= A-B;
	S_mul <= A*B;
	
	S_equ <= when else;
	S_inf <= when else;
	S_sup <= when else;
	
	C <= when else;
	N <= when else;
	Z <= when else;
	V <= when else;

--Ex prof : pq pb puisquon a dit quon etait sur 8 bits ??
-- resultat <= a+b;
--resultat_tmp <= (b"0" & a) + (b"0" & b);
--resultat <= resultat_tmp(3 downto 0);
--carry_flag <= resultat_tmp(4);


end Behavioral;

