----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 01:49:12 PM
-- Design Name: 
-- Module Name: ALU_testt - Behavioral
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

-- Testbench de la ALU
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
entity ALU_testt is
    Port ( A : in STD_LOGIC_VECTOR(7 downto 0);
           B : in STD_LOGIC_VECTOR(7 downto 0);
           op : in STD_LOGIC_VECTOR(2 downto 0);
           C : out STD_LOGIC;   -- Carry
           O : out STD_LOGIC;   -- Overflow
           N : out STD_LOGIC;   -- Negativo
           S : out STD_LOGIC_VECTOR(7 downto 0) );  -- Resultado
end ALU_testt;

architecture Behavioral of ALU_testt is

    -- Señales internas para conectar con la ALU
    signal A_int, B_int : STD_LOGIC_VECTOR(7 downto 0);
    signal op_int : STD_LOGIC_VECTOR(2 downto 0);
    signal C_int : STD_LOGIC;
    signal O_int : STD_LOGIC;
    signal N_int : STD_LOGIC;
    signal S_int : STD_LOGIC_VECTOR(7 downto 0);
    
    -- Instancia del componente ALU
    component ALU
        Port ( inA : in STD_LOGIC_VECTOR (7 downto 0);
               inB : in STD_LOGIC_VECTOR (7 downto 0);
               operation : in STD_LOGIC_VECTOR (2 downto 0);
               Carry : out STD_LOGIC;
               Overflow : out STD_LOGIC;
               Negatif : out STD_LOGIC;
               Dout : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

begin

    -- Instanciación de la ALU
    UUT: ALU port map (
        inA => A_int,
        inB => B_int,
        operation => op_int,
        Carry => C_int,
        Overflow => O_int,
        Negatif => N_int,
        Dout => S_int
    );

    -- Conectar las señales de salida al testbench
    C <= C_int;
    O <= O_int;
    N <= N_int;
    S <= S_int;

    -- Generación de estímulos
    process
    begin
        -- Test 1: Suma sin desbordamiento
        A_int <= "11111111";  -- A = 10
        B_int <= "00000011";  -- B = 1
        op_int <= "000";      -- Operación de suma
        wait for 10 ns;

        -- Test 2: Resta sin desbordamiento
        A_int <= "00000011";  -- A = 10
        B_int <= "00000101";  -- B = 1
        op_int <= "001";      -- Operación de resta
        wait for 10 ns;

        -- Test 3: Multiplicación sin desbordamiento
        A_int <= "11111111";  -- A = 3
        B_int <= "00000010";  -- B = 2
        op_int <= "010";      -- Operación de multiplicación
        wait for 10 ns;

        -- Test 4: Operación AND
        A_int <= "11110000";  -- A = 240
        B_int <= "11001100";  -- B = 204
        op_int <= "011";      -- Operación AND
        wait for 10 ns;

        -- Test 5: Operación OR
        A_int <= "10101010";  -- A = 170
        B_int <= "01010101";  -- B = 85
        op_int <= "100";      -- Operación OR
        wait for 10 ns;

        -- Test 6: Operación XOR
        A_int <= "11110000";  -- A = 240
        B_int <= "00001111";  -- B = 15
        op_int <= "101";      -- Operación XOR
        wait for 10 ns;

        -- Test 7: Operación NOT (de A)
        A_int <= "00001111";  -- A = 15
        B_int <= "00000000";  -- B = 0
        op_int <= "110";      -- Operación NOT
        wait for 10 ns;

        -- Finalizar simulación
        wait;
    end process;

end Behavioral;

