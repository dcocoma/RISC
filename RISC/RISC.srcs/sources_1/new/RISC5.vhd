----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/12/2024 11:44:14 PM
-- Design Name: 
-- Module Name: RISC5 - Behavioral
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

entity RISC5 is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC);
end RISC5;

architecture Behavioral of RISC5 is

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
    
    
    signal LI_A, LI_OP, LI_B, LI_C   : STD_LOGIC_VECTOR(7 downto 0)     := (others => '0');
    signal DI_A, DI_OP, DI_B, DI_C   : STD_LOGIC_VECTOR(7 downto 0)     := (others => '0');
    signal EX_A, EX_OP, EX_B, EX_C   : STD_LOGIC_VECTOR(7 downto 0)     := (others => '0');
    signal MEM_A, MEM_OP, MEM_B, MEM_C   : STD_LOGIC_VECTOR(7 downto 0)     := (others => '0');
    signal RE_A, RE_OP, RE_B, RE_C   : STD_LOGIC_VECTOR(7 downto 0)     := (others => '0');
    
    signal LC   : STD_LOGIC_VECTOR(2 downto 0)     := (others => '0');
    signal LC_MEMREG, LC_MEMDON : std_logic;
    signal ID : STD_LOGIC_VECTOR(7 downto 0):= (others => '0');
    
    signal DIBin,EXBin, MemAdd : std_logic_vector(7 downto 0) := (others => '0');
    signal QAout, QBout, ALUOUT, MEMDOUT, MEMREBin : std_logic_vector(7 downto 0) := (others => '0');
    

begin
    
    LI_DI : PipelineStage
    port map (
        CLK => CLK,
        RST => RST,
        Ain => LI_A,
        OPin => LI_OP,
        Cin => LI_C,
        Bin => LI_B,
   
        Aout => DI_A,
        OPout => DI_OP,
        Bout => DI_B,
        Cout => DI_C
    );
    
    DI_EX : PipelineStage
    port map (
        CLK => CLK,
        RST => RST,
        Ain => DI_A,
        OPin => DI_OP,
        Bin => DIBin,
        Cin => QBout,

        
        Aout => EX_A,
        OPout => EX_OP,
        Bout => EX_B,
        Cout => EX_C
    );

    
    EX_MEM : PipelineStage
    port map (
        CLK => CLK,
        RST => RST,
        Ain => EX_A,
        OPin => EX_OP,
        Bin => EXBin,
        Cin => EX_C,

        
        Aout => MEM_A,
        OPout => MEM_OP,
        Bout => MEM_B,
        Cout => MEM_C
    );
    
    MEM_RE : PipelineStage
    port map (
        CLK => CLK,
        RST => RST,
        Ain => MEM_A,
        OPin => MEM_OP,
        Bin => MEMREBin,
        Cin => MEM_C,

        
        Aout => RE_A,
        OPout => RE_OP,
        Bout => RE_B,
        Cout => RE_C
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
        DOUT(7 downto 0) => LI_C,
        DOUT(15 downto 8) => LI_B,
        DOUT(23 downto 16) => LI_A,
        DOUT(31 downto 24) => LI_OP
    );
    
    UUT_banc_regis: Banc_regis
    port map (
        atA => DI_B(3 downto 0),
        atB => DI_C(3 downto 0),
        atW => RE_A(3 downto 0),
        W =>  LC_MEMREG,                 -- Puedes poner valores por defecto como '0' o '1'
        DATA => RE_B,
        RST => RST,
        CLK => CLK,
        QA => QAout,               
        QB => QBout                -- Igualmente para la salida QB
    );
    
    UUT_ALU : ALU
    port map (
        inA => EX_B,
        inB => EX_C,
        operation => LC,
        Carry => open,
        Overflow => open,
        Negatif => open,
        Dout => ALUOUT
    );
    
    UUT_MEM: Memoire_donnes
    port map (
        Addres => MemAdd,
        Data => MEM_B,
        RW => LC_MEMDON,                  -- '0' para señal de lectura
        RST => RST,
        CLK => CLK,
        DOUT => MEMDOUT                -- conectamos la salida DOUT
    );
    
    
    -- LC final config
    LC_MEMREG <= '0' when RE_OP(3) = '1' else '1'; -- LC final 
    -- LC ALU CONF
    LC <=   "000" when EX_OP = x"01" else  --Addition
            "010" when EX_OP = x"02" else  -- Multiplication
            "001" when EX_OP = x"03" else  -- Sustraction
            "000";
    -- LC mem don conf
    LC_MEMDON <= '0' when MEM_OP = x"08" else '1';
    
    -- Mux ALU conf
    EXBin <= ALUOUT when EX_OP < x"04" and EX_OP /= x"00" else EX_B;
            
    -- Mux banc registers config
    DIBin <= DI_B when (DI_OP = x"06" or DI_OP = x"07") else QAout;
    
    -- MUX MEMM DON out
    MEMREBin <= MEMDOUT when MEM_OP = x"07" else MEM_B;
    
    -- MUX Mem don in
    MemAdd <=   MEM_A when MEM_OP = x"08" else
                MEM_B;

end Behavioral;
