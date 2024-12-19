----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 01:00:28 PM
-- Design Name: 
-- Module Name: Memoire_donnes - Behavioral
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

entity Memoire_donnes is
    Port ( Addres : in STD_LOGIC_VECTOR (7 downto 0);
           Data : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DOUT : out STD_LOGIC_VECTOR (7 downto 0));
end Memoire_donnes;

architecture Behavioral of Memoire_donnes is
    type reg_array is array (0 to 15) of STD_LOGIC_VECTOR(7 downto 0);
    signal registers : reg_array := (others => x"00"); -- Inicializa registros a 0
begin
    process(CLK, RST)
        begin
        if RST = '0' then
            registers <= (others => (others => '0')); -- Reinicio a 0
        elsif rising_edge(CLK) then
            if RW = '0' then
                registers(conv_integer(Addres)) <= Data;
            end if;
        end if;
    end process;
    
    DOUT <= registers(conv_integer(Addres)) when (RW = '1') else DATA;

end Behavioral;
