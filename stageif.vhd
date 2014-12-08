----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:30:05 12/01/2014 
-- Design Name: 
-- Module Name:    STAGE_IF - STRUCTRAL 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity STAGE_IF is
    Port ( Clk : in  STD_LOGIC;
           Clk_x2 : in  STD_LOGIC;
           Clk_x4 : in  STD_LOGIC;
		   Data_to_RAM2 : in  STD_LOGIC_VECTOR (15 downto 0);
		   Data_from_RAM2 : out  STD_LOGIC_VECTOR (15 downto 0);
		   Addr_to_RAM2 : in  STD_LOGIC_VECTOR (15 downto 0);
		   RAM2_op : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
		   Bubble : in  STD_LOGIC;
		   Freeze : in  STD_LOGIC;
           PC_src : in  STD_LOGIC;
		   Branch_PC : in  STD_LOGIC_VECTOR (15 downto 0);
           RAM2_we : out  STD_LOGIC;
           RAM2_oe : out  STD_LOGIC;
           RAM2_en : out  STD_LOGIC;
           RAM2_addr : out  STD_LOGIC_VECTOR (17 downto 0);
           RAM2_data : inout  STD_LOGIC_VECTOR (15 downto 0);
           Inst_ID : out  STD_LOGIC_VECTOR (15 downto 0);
           NPC_ID : out  STD_LOGIC_VECTOR (15 downto 0));
end STAGE_IF;

architecture STRUCTRAL of STAGE_IF is

component PC_REG is
	port ( Clk : in  STD_LOGIC;
		   Rst : in  STD_LOGIC;
		   Bubble : in  STD_LOGIC;
		   Freeze : in  STD_LOGIC;
           PC_d : in  STD_LOGIC_VECTOR (15 downto 0);
           PC_q : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component INST_FETCHER is
	port ( Clk : in  STD_LOGIC;
		   Rst : in  STD_LOGIC;
		   Freeze : in  STD_LOGIC;
		   RAM2_op : in  STD_LOGIC;
		   Data_from_RAM2 : out  STD_LOGIC_VECTOR (15 downto 0);
		   Data_to_RAM2 : in  STD_LOGIC_VECTOR (15 downto 0);
		   Addr_to_RAM2 : in  STD_LOGIC_VECTOR (15 downto 0);
           RAM2_we : out  STD_LOGIC;
           RAM2_oe : out  STD_LOGIC;
           RAM2_en : out  STD_LOGIC;
           PC : in  STD_LOGIC_VECTOR (15 downto 0);
           Inst : out  STD_LOGIC_VECTOR (15 downto 0);
           Clk2 : in  STD_LOGIC;
           RAM2_addr : out  STD_LOGIC_VECTOR (17 downto 0);
           RAM2_data : inout  STD_LOGIC_VECTOR (15 downto 0));
end component;

component IF_ID_REGS is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
		   Freeze : in  STD_LOGIC;
		   Bubble : in  STD_LOGIC;
           NPC_d : in  STD_LOGIC_VECTOR (15 downto 0);
           Inst_d : in  STD_LOGIC_VECTOR (15 downto 0);
           NPC_q : out  STD_LOGIC_VECTOR (15 downto 0);
           Inst_q : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component PC_MUX is
	port ( PC_next : in  STD_LOGIC_VECTOR (15 downto 0);
		   Branch_PC : in  STD_LOGIC_VECTOR (15 downto 0);
		   PC_src : in  STD_LOGIC;
           NPC : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component PC_INC is
	port ( PC : in  STD_LOGIC_VECTOR (15 downto 0);
		   PC_next : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

signal PC_d : STD_LOGIC_VECTOR (15 downto 0);
signal PC_q : STD_LOGIC_VECTOR (15 downto 0);
signal PC_next : STD_LOGIC_VECTOR (15 downto 0);
signal Inst_IF : STD_LOGIC_VECTOR (15 downto 0);

begin

	PC_reg_c : PC_REG port map ( 
		Clk => Clk, 
		Bubble => Bubble,
		Freeze => Freeze,
		PC_d => PC_d, 
		PC_q => PC_q, 
		Rst => Rst );
	Inst_fetcher_c : INST_FETCHER port map ( 
		Clk => Clk, 
		Freeze => Freeze,
		RAM2_op => RAM2_op,
		Data_to_RAM2 => Data_to_RAM2,
		Data_from_RAM2 => Data_from_RAM2,
		Addr_to_RAM2 => Addr_to_RAM2,
		RAM2_we => RAM2_we,
		RAM2_oe => RAM2_oe, 
		RAM2_en => RAM2_en, 
		PC => PC_q, 
		Inst => Inst_IF, 
		Clk2 => Clk_x4, 
		RAM2_addr => RAM2_addr,
		RAM2_data => RAM2_data, 
		Rst => Rst );
	IF_ID_regs_c : IF_ID_REGS port map ( 
		Clk => Clk, 
		Freeze => Freeze,
		Bubble => Bubble,
		NPC_d => PC_next, 
		NPC_q => NPC_ID, 
		Inst_d => Inst_IF, 
		Inst_q => Inst_ID, 
		Rst => Rst );
	PC_inc_c : PC_INC port map ( 
		PC => PC_q, 
		PC_next => PC_next );
	PC_mux_c : PC_MUX port map ( 
		NPC => PC_d, 
		Branch_PC => Branch_PC, 
		PC_next => PC_next,
		PC_src => PC_src );	

end STRUCTRAL;

