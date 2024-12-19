----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/21/2024 10:32:06 AM
-- Design Name: 
-- Module Name: PipelineStage - Behavioral
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

entity PipelineStage is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           Ain : in STD_LOGIC_VECTOR (7 downto 0);
           Bin : in STD_LOGIC_VECTOR (7 downto 0);
           Cin : in STD_LOGIC_VECTOR (7 downto 0);
           OPin : in STD_LOGIC_VECTOR (7 downto 0);
           Aout : out STD_LOGIC_VECTOR (7 downto 0);
           Bout : out STD_LOGIC_VECTOR (7 downto 0);
           Cout : out STD_LOGIC_VECTOR (7 downto 0);
           OPout : out STD_LOGIC_VECTOR (7 downto 0));
end PipelineStage;

architecture Behavioral of PipelineStage is

-- Registros internos para almacenar los valores de la etapa
    signal reg_A, reg_B, reg_C, reg_OP : STD_LOGIC_VECTOR(7 downto 0);
    
begin

    -- Proceso de la etapa de pipeline (se dispara con cada flanco de reloj)
    process(CLK, RST)
    begin
        if RST = '0' then
            -- Si hay reset, los registros se inicializan a 0
            reg_A <= (others => '0');
            reg_B <= (others => '0');
            reg_C <= (others => '0');
            reg_OP <= (others => '0');
        elsif rising_edge(CLK) then
        
            -- Al flanco de subida del reloj, se cargan las entradas en los registros
            reg_A <= Ain;
            reg_B <= Bin;
            reg_C <= Cin;
            reg_OP <= OPin;
        end if;
    end process;

    -- Asignación de las señales de salida desde los registros internos
    Aout <= reg_A;
    Bout <= reg_B;
    Cout <= reg_C;
    Opout <= reg_OP;


end Behavioral;
