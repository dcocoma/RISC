----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2024 03:26:25 PM
-- Design Name: 
-- Module Name: Shema1_sim - Behavioral
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

entity Shema1_sim is
--  Port ( );
end Shema1_sim;

architecture Behavioral of Shema1_sim is
    
    signal CLK : std_logic := '0';
    signal RST : std_logic := '0';


    component RISC
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
begin
    UUT: RISC 
    port map (
        CLK => CLK,
        RST => RST,
        S => open
    );
    
    CLK <= not CLK after 5 ns;
    RST <= '1';

end Behavioral;
