----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/24/2024 11:12:44 AM
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( inA : in STD_LOGIC_VECTOR (7 downto 0);
           inB : in STD_LOGIC_VECTOR (7 downto 0);
           operation : in STD_LOGIC_VECTOR (2 downto 0);
           Carry : out STD_LOGIC;
           Overflow : out STD_LOGIC;
           Negatif : out STD_LOGIC;
           Dout : out STD_LOGIC_VECTOR (7 downto 0));
end ALU;
architecture Behavioral of ALU is

    signal temp_sum : STD_LOGIC_VECTOR(8 downto 0); -- 9 bit Sum
    signal temp_rest : STD_LOGIC_VECTOR(7 downto 0); -- 8 bit rest 
    signal temp_mul_result : STD_LOGIC_VECTOR(15 downto 0); -- 15 bit Mult
    signal result_output : STD_LOGIC_VECTOR(7 downto 0); -- 8 bit logic op
    signal r_and : STD_LOGIC_VECTOR(7 downto 0);
    signal r_or : STD_LOGIC_VECTOR(7 downto 0);
    signal r_xor : STD_LOGIC_VECTOR(7 downto 0);
    signal r_nota : STD_LOGIC_VECTOR(7 downto 0);
    
    begin
        
        temp_sum <= ('0' & inA) + ('0' & inB);
        temp_rest <= inA - inB when (inA > inB) else
                     inB - inA;
        temp_mul_result <= inA * inB;
        r_and <= inA and inB;
        r_or <= inA or inB;
        r_xor <= inA xor inB;
        r_nota <= not inA;
        
        Carry <= std_logic(temp_sum(8)) when operation = "000" else '0';
        Overflow <= '1' when (temp_mul_result(15 downto 8) /= x"00" and operation = "010")  else '0';
        Negatif <= '1' when (inA < inB and operation = "001") else '0';
        
        result_output <=    temp_sum(7 downto 0) when operation = "000" else
                            temp_rest(7 downto 0) when operation = "001" else
                            temp_mul_result(7 downto 0) when operation = "010" else
                            r_and when operation = "011" else
                            r_or when operation = "100" else
                            r_xor when operation = "101" else                           
                            r_nota;
        Dout <= result_output;
end Behavioral;