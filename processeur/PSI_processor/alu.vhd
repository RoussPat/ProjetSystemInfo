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
	Signal S_div : STD_LOGIC_VECTOR(7 downto 0);
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
	S <=  S_add(7 downto 0) when Ctrl_Alu = X"01" else 
			S_sou(7 downto 0) when Ctrl_Alu = X"03" else
			S_mul(7 downto 0) when Ctrl_Alu = X"02" else
			S_div(7 downto 0) when Ctrl_Alu = X"04" else
			S_equ when Ctrl_Alu = X"0B" else
			S_inf when Ctrl_Alu = X"09" else
			S_sup when Ctrl_Alu = X"0A";
			-- division ???
			
	-- Actions a faire en fonction de l'OpCode
	S_add <= ("0" & A)+ ("0" & B); -- est-ce quon utilise une variable temporaire comme a ecrit la prof dans le forum ?
	S_sou <= A-B;
	S_mul <= A*B;
	S_div <= A/B; --gestion automatique du cas B=0 ??? (ex : A/B when (B != '0') else '0')
	
	S_equ <= '1' when (Ctrl_Alu = X"09" and A = B) else '0'; -- egalite
	S_inf <= '1' when (Ctrl_Alu = X"09" and A < B) else '0'; -- inferieur stricte
	S_sup <= '1' when (Ctrl_Alu = X"09" and A > B) else '0'; -- superieur stricte
	
	-- Flag Carry
	C <=  S_add(8) (when Ctrl_Alu = X"01" and S_add(8) = '1') else '0';
	
	-- Flag Negative
	N <=  S_add(7) when (Ctrl_Alu = X"01" and S_add(7) = '1') else	-- addition
			S_sou(7) when (Ctrl_Alu = X"03" and S_sou(7) = '1') else	-- soustraction
			S_mul(7) when (Ctrl_Alu = X"02" and S_mul(7) = '1') else	-- multiplication
			S_div(7) when (Ctrl_Alu = X"04" and S_div(7) = '1') else	-- division
			'0';
	
	-- Flag Zero
	Z <=  '1' when (Ctr_Alu = X"01" and S_add(7 downto 0) = X"00") else -- addition
			'1' when (Ctr_Alu = X"03" and S_sou(7 downto 0) = X"00") else -- soustraction
			'1' when (Ctr_Alu = X"02" and S_mul(7 downto 0) = X"00") else -- multiplication
			'1' when (Ctr_Alu = X"04" and S_div(7 downto 0) = X"00") else -- division
			'0';
	
	-- Flag Overflow
	V <=  '1' when (S_add(7) = '1' and A(7) = '0' and B(7) = '0') else 	-- add cas 1 : A et B positifs
			'1' when (S_add(7) = '0' and A(7) = '1' and B(7) = '1') else	-- add cas 2 : A et B negatifs
			'1' when (S_sou(7) = '0' and A(7) = '1' and B(7) = '0') else	-- sou cas 1 : A negatif, B positif
			'1' when (S_sou(7) = '1' and A(7) = '0' and B(7) = '1') else 	-- sou cas 2 : A positif, B negatif
			'0';
			
			
--Ex prof :
-- resultat <= a+b;
--resultat_tmp <= (b"0" & a) + (b"0" & b);
--resultat <= resultat_tmp(3 downto 0);
--carry_flag <= resultat_tmp(4);


end Behavioral;

