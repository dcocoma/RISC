----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2024 04:24:59 PM
-- Design Name: 
-- Module Name: Compteur_8bits - Behavioral
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

entity Compteur_8bits is
    Port ( CLK : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Load : in STD_LOGIC;
           Enable : in STD_LOGIC;
           Sens : in STD_LOGIC;
           Din : in STD_LOGIC_VECTOR (7 downto 0);
           Dout : out STD_LOGIC_VECTOR (7 downto 0));
end Compteur_8bits;

architecture Behavioral of Compteur_8bits is
    signal counter : STD_LOGIC_VECTOR(7 downto 0) := (others => '0'); -- Señal interna del contador
	begin
	   process
	   begin
	       wait until rising_edge(CLK); -- if rising_edge(CLK) then  -- Activo en la bajada del reloj
	       if Reset = '0' then  counter <= (others => '0');  -- Reinicia el contador a 0
	       elsif Enable = '0' then  -- Enable en cero
	           if Load = '1' then counter <= Din; -- 
	           else  -- Operar el contador
	               if Sens = '1' then counter <= counter + 1;
	               else  counter <= counter - 1;
	               end if;
	           end if;
	       end if;
	   end process;
	
	Dout <= counter;  -- Asignar el valor del contador a la salida
end Behavioral;
