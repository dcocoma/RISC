----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/12/2024 04:09:12 PM
-- Design Name: 
-- Module Name: Meminst_simu - Behavioral
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

entity Meminst_simu is
--  Port ( );
end Meminst_simu;

architecture Behavioral of Meminst_simu is
    
    signal ID : std_logic_vector(7 downto 0) := (others => '0');
    signal CLK : std_logic := '0';
    signal RST : std_logic := '1';
    
    

component Memoire_inst is
    Port ( Address : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           DOUT : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component Compteur_8bits is
    Port ( CLK : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Load : in STD_LOGIC;
           Enable : in STD_LOGIC;
           Sens : in STD_LOGIC;
           Din : in STD_LOGIC_VECTOR (7 downto 0);
           Dout : out STD_LOGIC_VECTOR (7 downto 0));
end component;

begin

mem : Memoire_inst
    port map (
        Address => ID,
        CLK => CLK,
        DOUT => open
    );

UUT_compteur : Compteur_8bits
    port map( 
        CLK => CLK,
        Reset => RST,
        Load => '0',
        Enable => '0',
        Sens => '1',
        Din => (others => '0'),
        Dout => ID 
 );
 
 CLK <= not CLK after 5 ns;



end Behavioral;
