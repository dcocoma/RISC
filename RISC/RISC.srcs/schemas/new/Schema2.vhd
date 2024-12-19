----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/08/2024 11:45:20 PM
-- Design Name: 
-- Module Name: Schema2 - Behavioral
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

entity Schema2 is
--  Port ( );
end Schema2;

architecture Behavioral of Schema2 is
    signal CLK : std_logic := '0';
    signal RST : std_logic := '0';


    component RISC2
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC);
    end component;
begin
    UUT: RISC2 
    port map (
        CLK => CLK,
        RST => RST
    );
    
    CLK <= not CLK after 5 ns;
    RST <= '1';
end Behavioral;
