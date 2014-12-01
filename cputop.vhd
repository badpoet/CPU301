----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:04:19 11/29/2014 
-- Design Name: 
-- Module Name:    CPU_TOP - Behavioral 
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

entity CPU_TOP is
	Port ( Clk_in : in  STD_LOGIC;
		   Rst : in  STD_LOGIC;
           RAM1_we : out  STD_LOGIC;
           RAM1_oe : out  STD_LOGIC;
           RAM1_en : out  STD_LOGIC;
           RAM1_addr : out  STD_LOGIC_VECTOR (17 downto 0);
           RAM1_data : inout  STD_LOGIC_VECTOR (15 downto 0);
           RAM2_we : out  STD_LOGIC;
           RAM2_oe : out  STD_LOGIC;
           RAM2_en : out  STD_LOGIC;
           RAM2_addr : out  STD_LOGIC_VECTOR (17 downto 0);
           RAM2_data : inout  STD_LOGIC_VECTOR (15 downto 0);
		   LED : out  STD_LOGIC_VECTOR (15 downto 0);
		   SSD_h : out  STD_LOGIC_VECTOR (6 downto 0);
		   SSD_l : out  STD_LOGIC_VECTOR (6 downto 0));
end CPU_TOP;

architecture STRUCTRUAL of CPU_TOP is

-- COMPONENTS

component SEVEN_SEG_DISPLAY is
    Port ( Data : in  STD_LOGIC_VECTOR (7 downto 0);
           Output_l : out  STD_LOGIC_VECTOR (6 downto 0);
		   Output_h : out  STD_LOGIC_VECTOR (6 downto 0));
end component;

component CLK_BASE_GEN is 
    Port ( Clk_in : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Clk_base : out  STD_LOGIC);
end component;

component CLK_GEN is
    port ( Clk_base : in  STD_LOGIC;
		   Rst : in  STD_LOGIC;
           Clk : out  STD_LOGIC;
           Clk_x2 : out  STD_LOGIC;
           Clk_x4 : out  STD_LOGIC);
end component;

component PC_REG is
	port ( Clk : in  STD_LOGIC;
		   Rst : in  STD_LOGIC;
           Pc_d : in  STD_LOGIC_VECTOR (15 downto 0);
           Pc_q : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component PC_MUX is
	port ( Pc : in  STD_LOGIC_VECTOR (15 downto 0);
		   Branch_pc : in  STD_LOGIC_VECTOR (15 downto 0);
		   Pc_src : in  STD_LOGIC;
           Npc : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component INST_FETCHER is
	port ( Clk : in  STD_LOGIC;
		   Rst : in  STD_LOGIC;
           RAM2_we : out  STD_LOGIC;
           RAM2_oe : out  STD_LOGIC;
           RAM2_en : out  STD_LOGIC;
           Pc : in  STD_LOGIC_VECTOR (15 downto 0);
           Inst : out  STD_LOGIC_VECTOR (15 downto 0);
           Clk2 : in  STD_LOGIC;
           RAM2_addr : out  STD_LOGIC_VECTOR (17 downto 0);
           RAM2_data : inout  STD_LOGIC_VECTOR (15 downto 0));
end component;

component IF_ID_REGS is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Npc_d : in  STD_LOGIC_VECTOR (15 downto 0);
           Inst_d : in  STD_LOGIC_VECTOR (15 downto 0);
           Npc_q : out  STD_LOGIC_VECTOR (15 downto 0);
           Inst_q : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

-- WIRES

-- 16 bit integer passed to seven segment displays
signal SSD_data : STD_LOGIC_VECTOR (7 downto 0); 

signal Clk_base : STD_LOGIC;
signal Clk : STD_LOGIC;
signal Clk_x2 : STD_LOGIC;
signal Clk_x4 : STD_LOGIC;

signal Pc_d : STD_LOGIC_VECTOR (15 downto 0);
signal Pc_q : STD_LOGIC_VECTOR (15 downto 0);
signal Inst_IF : STD_LOGIC_VECTOR (15 downto 0);

signal Npc_ID : STD_LOGIC_VECTOR (15 downto 0);
signal Inst_ID : STD_LOGIC_VECTOR (15 downto 0);

begin
	
	LED(11 downto 0) <= Pc_q(11 downto 0);
	LED(15) <= Clk;
	LED(14) <= Clk_x2;
	LED(13) <= Clk_x4;
	LED(12) <= Clk_base;
	SSD_data <= Inst_ID(7 downto 0);
	
	Seven_seg_display_c : SEVEN_SEG_DISPLAY port map ( Data => SSD_data,
		Output_h => SSD_h, Output_l => SSD_l );
	
	Clk_base_gen_c : CLK_BASE_GEN port map ( Clk_in => Clk_in, 
		Clk_base => Clk_base, Rst => Rst );
	
	Clk_gen_c : CLK_GEN port map ( Clk_base => Clk_base, Clk => Clk, 
		Clk_x2 => Clk_x2, Clk_x4 => Clk_x4, Rst => Rst );
	
	Pc_reg_c : PC_REG port map ( Clk => Clk, Pc_d => Pc_d, Pc_q => Pc_q, Rst => Rst );
	Inst_fetcher_c : INST_FETCHER port map ( 
		Clk => Clk, RAM2_we => RAM2_we, RAM2_oe => RAM2_oe, RAM2_en => RAM2_en, 
		Pc => Pc_q, Inst => Inst_IF, Clk2 => Clk_x4, RAM2_addr => RAM2_addr,
		RAM2_data => RAM2_data, Rst => Rst );
	If_ID_regs_c : IF_ID_REGS port map ( Clk => Clk, Npc_d => Pc_q, Npc_q => Npc_ID, 
		Inst_d => Inst_IF, Inst_q => Inst_ID, Rst => Rst );

	Pc_mux_c : PC_MUX port map ( Npc => Pc_d, Branch_pc => Pc_q, Pc => Pc_q,
		Pc_src => '0' );	
	RAM1_data <= (others => 'Z');
	RAM1_addr <= (others => '0');
	RAM1_oe <= '1';
	RAM1_we <= '1';
	RAM1_en <= '1';

end STRUCTRUAL;

