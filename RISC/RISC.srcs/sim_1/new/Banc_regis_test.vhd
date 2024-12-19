----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 02:40:31 PM
-- Design Name: 
-- Module Name: Banc_regis_test - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity Banc_regis_test is
    Port ( atA : in STD_LOGIC_VECTOR (3 downto 0);
           atB : in STD_LOGIC_VECTOR (3 downto 0);
           atW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end Banc_regis_test;

architecture Behavioral of Banc_regis_test is

    -- Señales internas para conectar a la entidad Banc_regis
    signal atA_int, atB_int, atW_int : STD_LOGIC_VECTOR(3 downto 0);
    signal W_int : STD_LOGIC;
    signal DATA_int : STD_LOGIC_VECTOR(7 downto 0);
    signal RST_int : STD_LOGIC;
    signal CLK_int : STD_LOGIC := '0';
    signal QA_int, QB_int : STD_LOGIC_VECTOR(7 downto 0);

    -- Componente banc_regis
    component Banc_regis
        Port ( atA : in STD_LOGIC_VECTOR (3 downto 0);
               atB : in STD_LOGIC_VECTOR (3 downto 0);
               atW : in STD_LOGIC_VECTOR (3 downto 0);
               W : in STD_LOGIC;
               DATA : in STD_LOGIC_VECTOR (7 downto 0);
               RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               QA : out STD_LOGIC_VECTOR (7 downto 0);
               QB : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

begin

    

    -- Instanciación del componente Banc_regis
    UUT: Banc_regis port map (
        atA => atA_int,
        atB => atB_int,
        atW => atW_int,
        W => W_int,
        DATA => DATA_int,
        RST => RST_int,
        CLK => CLK_int,
        QA => QA_int,
        QB => QB_int
    );

    -- Conectar las señales de salida al testbench
    QA <= QA_int;
    QB <= QB_int;

    -- Generación de reloj
    CLK_int <= not CLK_int after 5 ns;  -- Generación de señal de reloj con 10 ns de ciclo


    -- Proceso de estímulos
    process
    begin
        
        -- Inicialización
        RST_int <= '1';  -- Iniciar con reset inactivo
        W_int <= '1';    -- Escribir dato
        DATA_int <= "11111111";  -- Valor de datos por defecto val ff
        atA_int <= "0001"; -- Registro A de lectura reg 1
        atB_int <= "0010"; -- Registro B de lectura reg 2
        atW_int <= "0000"; -- Registro de escritura reg 0
        wait for 10 ns;

        -- Test 2: Escribir en el registro 2 (atW = "0010")
        DATA_int <= "10101010";  -- Escribir el valor 0xAA
        atW_int <= "0001"; -- Registra el val en reg 1
        W_int <= '1';  -- Activar escritura
        wait for 10 ns;

        -- Test 3: Leer desde el registro 2 (atA = "0010")
        W_int <= '0';  -- Desactivar escritura
        atA_int <= "0000";  -- Leer desde el registro 0
        atB_int <= "0001";  -- Leer desde el registro 1
        wait for 10 ns;

        -- Test 4: Leer desde otro registro (atB = "0001")
        atB_int <= "0001";  -- Leer desde el registro 1
        wait for 10 ns;

        -- Test 5: Escribir en el registro 5 (atW = "0101")
        DATA_int <= "11110000";  -- Escribir el valor 0xF0
        W_int <= '1';  -- Activar escritura
        atW_int <= "0101";  -- Escribir en el registro 5
        wait for 10 ns;

        -- Test 6: Leer desde el registro 5 (atA = "0101")
        W_int <= '0';  -- Desactivar escritura
        atA_int <= "0101";  -- Leer desde el registro 5
        wait for 10 ns;

        -- Test 7: Reiniciar los registros (RST = '0')
        RST_int <= '0';  -- Activar reset
        wait for 10 ns;

        -- Test 8: Verificar el efecto de reset (Leer registros después de reset)
        RST_int <= '1';  -- Desactivar reset
        atA_int <= "0000";  -- Leer desde el registro 0
        atB_int <= "0001";  -- Leer desde el registro 1
        wait for 10 ns;

        -- Finalizar simulación
        wait;
    end process;

end Behavioral;
