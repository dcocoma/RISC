----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/12/2024 05:41:11 PM
-- Design Name: 
-- Module Name: Shema3 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Shema3 is
--  Port ( );
end Shema3;

architecture Behavioral of Shema3 is
    signal CLK : std_logic := '0';
    signal RST : std_logic := '0';


    component RISC3
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC);
    end component;
begin
    UUT: RISC3 
    port map (
        CLK => CLK,
        RST => RST
    );
    
    CLK <= not CLK after 5 ns;
    RST <= '1';
end Behavioral;
