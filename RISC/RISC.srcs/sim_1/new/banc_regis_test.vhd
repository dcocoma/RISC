----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/08/2024 02:15:43 PM
-- Design Name: 
-- Module Name: banc_regis_test - Behavioral
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

entity banc_regis_test is
    Port ( atA : in STD_LOGIC_VECTOR (3 downto 0);
           atB : in STD_LOGIC_VECTOR (3 downto 0);
           atW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           Data : in STD_LOGIC_VECTOR (7 downto 0);
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end banc_regis_test;

architecture Behavioral of banc_regis_test is

signal CLK : std_logic := '0';
signal RST : std_logic := '1';
signal WW : std_logic := '1';
signal A : std_logic_vector(3 downto 0) := (others => '0');
signal B : std_logic_vector(3 downto 0) := (others => '0');
signal aW : std_logic_vector(3 downto 0) := (others => '0');
signal Dat : std_logic_vector(7 downto 0) := (others => '0');


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

banc : Banc_regis
port map (
    atA => A,
    atB => B,
    atW => aW,
    W => WW,
    DATA => Dat,
    RST => RST,
    CLK => CLK,
    QA => QA,
    QB => QB
 );
    
    CLK <= not CLK after 5 ns;
    RST <= '1';
    
    process
    begin
    A <= "0001";
    B <= "0010";
    aW <= "0011";
    WW <= '1';
    Dat <= x"06";
    end process;
   

end Behavioral;
