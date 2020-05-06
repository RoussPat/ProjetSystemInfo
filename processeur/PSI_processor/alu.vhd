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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is

    Port ( A : in  STD_LOGIC_VECTOR (size-1 downto 0);
           B : in  STD_LOGIC_VECTOR (size-1 downto 0);
           S : out  STD_LOGIC_VECTOR (size-1 downto 0);
           Ctrl_Alu : in  STD_LOGIC_VECTOR (2 downto 0);
           C_Flag : out  STD_LOGIC;
           Z_Flag : out  STD_LOGIC;
           O_Flag : out  STD_LOGIC;
           N_Flag : out  STD_LOGIC);
end alu;

architecture Behavioral of alu is
	 constant size : natural := 8;

	-- Declaration des operations
	signal S_add : STD_LOGIC_VECTOR(size downto 0);
	signal S_sou : STD_LOGIC_VECTOR(size-1 downto 0);
	signal S_mul : STD_LOGIC_VECTOR(size-1 downto 0);
	Signal S_div : STD_LOGIC_VECTOR(size-1 downto 0);
	signal S_equ : STD_LOGIC;
	signal S_inf : STD_LOGIC;
	signal S_sup : STD_LOGIC;
	signal C : STD_LOGIC := '0';
	signal N : STD_LOGIC := '0';
	signal Z : STD_LOGIC := '0';
	signal V : STD_LOGIC := '0';
	
begin

-- Implementation des operations
	-- Gestion des OpCodes
	S <=  S_add(size downto 0) when Ctrl_Alu = X"1" else 
			S_sou(size-1 downto 0) when Ctrl_Alu = X"3" else
			S_mul(size-1 downto 0) when Ctrl_Alu = X"2" else
			(X"0" & S_equ) when Ctrl_Alu = X"B" else
			(X"0" & S_inf) when Ctrl_Alu = X"9" else
			(X"0" & S_sup) when Ctrl_Alu = X"A" else
			X"00000000";
			
	-- Actions a faire en fonction de l'OpCode
	S_add <= ("0" & A)+ ("0" & B);
	S_sou <= A-B;
	S_mul <= A*B;
	
	S_equ <= '1' when (Ctrl_Alu = X"0B" and A = B) else '0'; -- egalite
	S_inf <= '1' when (Ctrl_Alu = X"09" and A < B) else '0'; -- inferieur stricte
	S_sup <= '1' when (Ctrl_Alu = X"0A" and A > B) else '0'; -- superieur stricte
	
	-- Flag Carry
	C <=  S_add(size) when (Ctrl_Alu = X"01" and S_add(size) = '1') else '0';
	
	-- Flag Negative
	N <=  S_add(size-1) when (Ctrl_Alu = X"01" and S_add(size-1) = '1') else	-- addition
			S_sou(size-1) when (Ctrl_Alu = X"03" and S_sou(size-1) = '1') else	-- soustraction
			S_mul(size-1) when (Ctrl_Alu = X"02" and S_mul(size-1) = '1') else	-- multiplication
			'0';
	
	-- Flag Zero
	Z <=  '1' when (Ctrl_Alu = X"01" and S_add(size-1 downto 0) = X"00") else -- addition
			'1' when (Ctrl_Alu = X"03" and S_sou(size-1 downto 0) = X"00") else -- soustraction
			'1' when (Ctrl_Alu = X"02" and S_mul(size-1 downto 0) = X"00") else -- multiplication
			'0';
	
	-- Flag Overflow
	V <=  '1' when (S_add(size-1) = '1' and A(size-1) = '0' and B(size-1) = '0') else 	-- add cas 1 : A et B positifs
			'1' when (S_add(size-1) = '0' and A(size-1) = '1' and B(size-1) = '1') else	-- add cas 2 : A et B negatifs
			'1' when (S_sou(size-1) = '0' and A(size-1) = '1' and B(size-1) = '0') else	-- sou cas 1 : A negatif, B positif
			'1' when (S_sou(size-1) = '1' and A(size-1) = '0' and B(size-1) = '1') else 	-- sou cas 2 : A positif, B negatif
			'0';

end Behavioral;