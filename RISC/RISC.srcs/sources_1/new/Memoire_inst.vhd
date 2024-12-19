----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2024 01:11:29 PM
-- Design Name: 
-- Module Name: Memoire_inst - Behavioral
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

entity Memoire_inst is
    Port ( Address : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           DOUT : out STD_LOGIC_VECTOR (31 downto 0));
end Memoire_inst;

architecture Behavioral of Memoire_inst is
    type reg_array is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
    signal registers : reg_array := (others => x"00000000"); -- Inicializa registros a 0
    
begin

process(CLK)
begin
    if rising_edge(CLK) then
        registers(0) <= x"06" & x"00" & x"02" & x"00";  -- AFC 01 EN 00
        registers(1) <= x"06" & x"01" & x"05" & x"00";  -- AFC 02 EN 01
        registers(2) <= x"06" & x"02" & x"0a" & x"00";  -- AFC 03 EN 02
        registers(5) <= x"01" & x"03" & x"02" & x"02";  -- ADD DIR02 + DIR02 EN 03
        registers(6) <= x"02" & x"04" & x"02" & x"02";  -- MUL DIR02 * DIR02 00 EN 04
        registers(7) <= x"03" & x"05" & x"00" & x"02";  -- SOU DIR02 - DIR01 EN 05
        registers(8) <= x"05" & x"06" & x"03" & x"00";  -- COP 03 EN 06
        
        registers(15) <= x"08" & x"08" & x"04" & x"00";  -- STORE VALDIR04 EN DIR08
        registers(22) <= x"08" & x"01" & x"03" & x"00";  -- STORE VALDIR03 EN DIR01
        
        registers(30) <= x"07" & x"0a" & x"01" & x"00";  -- LOAD VALDIR01 EN 0a
        
    end if;
end process;

    process
    begin
        wait until CLK'event and CLK = '1';
        DOUT <= registers(conv_integer(unsigned(Address)));
    end process;

end Behavioral;
