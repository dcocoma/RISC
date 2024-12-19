----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/24/2024 11:43:11 AM
-- Design Name: 
-- Module Name: Banc_regis - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Banc_regis is
    Port ( atA : in STD_LOGIC_VECTOR (3 downto 0);
           atB : in STD_LOGIC_VECTOR (3 downto 0);
           atW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end Banc_regis;


architecture Behavioral of Banc_regis is
    type reg_array is array (0 to 15) of STD_LOGIC_VECTOR(7 downto 0);
    signal registers : reg_array := (others => x"00"); -- Inicializa registros a 0
begin
 process(CLK, RST)
   begin
        if RST = '0' then
            registers <= (others => (others => '0')); -- Reinicio a 0
        elsif rising_edge(CLK) then
            if W = '1' then
                registers(conv_integer(atW)) <= DATA;
            end if;
        end if;
    end process;

    -- Lectura de registros
    QA <= registers(conv_integer(atA)) when (W = '0' or atA /= atW) else DATA; -- Manejo de aléas
    QB <= registers(conv_integer(atB)) when (W = '0' or atB /= atW) else DATA; -- Manejo de aléas

end Behavioral;
