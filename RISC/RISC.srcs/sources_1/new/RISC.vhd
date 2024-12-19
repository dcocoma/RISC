----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/21/2024 08:31:12 AM
-- Design Name: 
-- Module Name: RISC - Behavioral
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

entity RISC is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0));
end RISC;

architecture Behavioral of RISC is
    
    signal LI   : STD_LOGIC_VECTOR(31 downto 0)     := (others => '0');
    signal DI   : STD_LOGIC_VECTOR(31 downto 0)     := (others => '0');
    signal EX   : STD_LOGIC_VECTOR(31 downto 0)     := (others => '0');
    signal MEM  : STD_LOGIC_VECTOR(31 downto 0)     := (others => '0');
    signal RE   : STD_LOGIC_VECTOR(31 downto 0)     := (others => '0');
    signal LC   : STD_LOGIC_VECTOR(7 downto 0)     := (others => '0');
    
    signal ID : STD_LOGIC_VECTOR(7 downto 0);

    component PipelineStage
    Port ( 
            CLK : in STD_LOGIC;
            RST : in STD_LOGIC;
            Ain : in STD_LOGIC_VECTOR (7 downto 0);
            Bin : in STD_LOGIC_VECTOR (7 downto 0);
            Cin : in STD_LOGIC_VECTOR (7 downto 0);
            OPin : in STD_LOGIC_VECTOR (7 downto 0);
            Aout : out STD_LOGIC_VECTOR (7 downto 0);
            Bout : out STD_LOGIC_VECTOR (7 downto 0);
            Cout : out STD_LOGIC_VECTOR (7 downto 0);
            OPout : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component Compteur_8bits
    Port ( CLK : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Load : in STD_LOGIC;
           Enable : in STD_LOGIC;
           Sens : in STD_LOGIC;
           Din : in STD_LOGIC_VECTOR (7 downto 0);
           Dout : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    component Memoire_inst
    Port ( Address : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           DOUT : out STD_LOGIC_VECTOR (31 downto 0));
    end component;    
    
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
    
    component ALU
    Port ( inA : in STD_LOGIC_VECTOR (7 downto 0);
           inB : in STD_LOGIC_VECTOR (7 downto 0);
           operation : in STD_LOGIC_VECTOR (2 downto 0);
           Carry : out STD_LOGIC;
           Overflow : out STD_LOGIC;
           Negatif : out STD_LOGIC;
           Dout : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component Memoire_donnes
    Port ( Addres : in STD_LOGIC_VECTOR (7 downto 0);
           Data : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DOUT : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

begin
    
    LI_DI : PipelineStage
    port map (
        CLK => CLK,
        RST => RST,
        Cin => LI(7 downto 0),
        Bin => LI(15 downto 8),
        Ain => LI(23 downto 16),
        OPin => LI(31 downto 24),

        
        Aout => DI(7 downto 0),
        OPout => DI(15 downto 8),
        Bout => DI(23 downto 16),
        Cout => DI(31 downto 24)
    );
    
    DI_EX : PipelineStage
    port map (
        CLK => CLK,
        RST => RST,
        Ain => DI(7 downto 0),
        OPin => DI(15 downto 8),
        Bin => DI(23 downto 16),
        Cin => DI(31 downto 24),

        
        Aout => EX(7 downto 0),
        OPout => EX(15 downto 8),
        Bout => EX(23 downto 16),
        Cout => EX(31 downto 24)
    );
    
    EX_MEM : PipelineStage
    port map (
        CLK => CLK,
        RST => RST,
        Ain => EX(7 downto 0),
        OPin => EX(15 downto 8),
        Bin => EX(23 downto 16),
        Cin => EX(31 downto 24),

        
        Aout => MEM(7 downto 0),
        OPout => MEM(15 downto 8),
        Bout => MEM(23 downto 16),
        Cout => MEM(31 downto 24)
    );
    
    MEM_RE : PipelineStage
    port map (
        CLK => CLK,
        RST => RST,
        Ain => MEM(7 downto 0),
        OPin => MEM(15 downto 8),
        Bin => MEM(23 downto 16),
        Cin => MEM(31 downto 24),

        
        Aout => RE(7 downto 0),
        OPout => LC,
        Bout => RE(23 downto 16),
        Cout => RE(31 downto 24)
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
    
    UUT_Meminst : Memoire_inst
    port map (
        Address => ID,
        CLK => CLK,
        DOUT => LI
    );
    
    UUT_banc_regis: Banc_regis
    port map (
        atA => (others => '0'),  
        atB => (others => '0'),
        atW => RE(3 downto 0),
        
        W => LC(2),                 -- Puedes poner valores por defecto como '0' o '1'
        DATA => RE(23 downto 16),
        RST => RST,
        CLK => CLK,
        QA => open,               -- Usamos "open" si no vamos a usar esta señal por ahora
        QB => open                -- Igualmente para la salida QB
    );
    
    UUT_ALU : ALU
    port map (
        inA => (others => '0'),
        inB => (others => '0'),
        operation => (others => '0'),
        Carry => open,
        Overflow => open,
        Negatif => open,
        Dout => open
    );
    
    UUT_MEM: Memoire_donnes
    port map (
        Addres => (others => '0'),
        Data => (others => '0'),
        RW => '0',                  -- '0' para señal de lectura
        RST => RST,
        CLK => CLK,
        DOUT => open                -- conectamos la salida DOUT
    );

end Behavioral;
