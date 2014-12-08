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
		   COM_rdn : out  STD_LOGIC;
		   COM_wrn : out  STD_LOGIC;
		   COM_tsre: in  STD_LOGIC;
		   COM_tbre: in  STD_LOGIC;
	   	   COM_data_ready: in  STD_LOGIC;
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

component STAGE_IF is
	port ( Clk : in  STD_LOGIC;
           Clk_x2 : in  STD_LOGIC;
           Clk_x4 : in  STD_LOGIC;
		   Freeze : in  STD_LOGIC;
		   RAM2_op : in  STD_LOGIC;
		   Data_from_RAM2 : out  STD_LOGIC_VECTOR (15 downto 0);
		   Data_to_RAM2 : in  STD_LOGIC_VECTOR (15 downto 0);
		   Addr_to_RAM2 : in  STD_LOGIC_VECTOR (15 downto 0);
           Rst : in  STD_LOGIC;
           PC_src : in  STD_LOGIC;
		   Branch_PC : in  STD_LOGIC_VECTOR (15 downto 0);
		   Bubble : in  STD_LOGIC;
           RAM2_we : out  STD_LOGIC;
           RAM2_oe : out  STD_LOGIC;
           RAM2_en : out  STD_LOGIC;
           RAM2_addr : out  STD_LOGIC_VECTOR (17 downto 0);
           RAM2_data : inout  STD_LOGIC_VECTOR (15 downto 0);
           Inst_ID : out  STD_LOGIC_VECTOR (15 downto 0);
           NPC_ID : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

COMPONENT STAGE_ID is
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		NPC : IN std_logic_vector(15 downto 0);
		Inst : IN std_logic_vector(15 downto 0);
		Freeze : in STD_LOGIC;
		ID_exe_reg_des : IN std_logic_vector(3 downto 0);
		Exe_mem_reg_des : IN std_logic_vector(3 downto 0);
		Exe_mem_alu_out : IN std_logic_vector(15 downto 0);
		Exe_mem_mem_op : IN std_logic_vector(1 downto 0);
		Mem_WB_reg_des : IN std_logic_vector(3 downto 0);
		Mem_WB_res : IN std_logic_vector(15 downto 0);
		Rw : IN std_logic_vector(3 downto 0);
		Rw_data : IN std_logic_vector(15 downto 0);   
		Bubble_to_PC : out  STD_LOGIC;       
		Branch_PC : OUT std_logic_vector(15 downto 0);
		PC_src : OUT std_logic;
		ALU_op_q : OUT std_Logic_vector (3 downto 0);
		ALU_src_a_q : OUT std_logic_vector(3 downto 0);
		ALU_src_b_q : OUT std_logic_vector(3 downto 0);
		Reg_src_b_q : OUT std_logic_vector(3 downto 0);
		Immediate_q : OUT std_logic_vector(15 downto 0);
		Mem_op_q : OUT std_logic_vector(1 downto 0);
		Rx_q : OUT std_logic_vector(15 downto 0);
		Ry_q : OUT std_logic_vector(15 downto 0);
		Reg_des_q : OUT std_logic_vector(3 downto 0)
		);
END COMPONENT;

COMPONENT STAGE_EXE is
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		Freeze : IN std_logic;
		ALU_src_a : IN std_logic_vector(3 downto 0);
		ALU_src_b : IN std_logic_vector(3 downto 0);
		Reg_src_b : IN std_logic_vector(3 downto 0);
		ALU_op : IN std_logic_vector(3 downto 0);
		Mem_op : IN std_logic_vector(1 downto 0);
		Reg_des : IN std_logic_vector(3 downto 0);
		Rx : IN std_logic_vector(15 downto 0);
		Ry : IN std_logic_vector(15 downto 0);
		Exe_mem_reg_des : IN std_logic_vector(3 downto 0);
		Exe_mem_alu_out : IN std_logic_vector(15 downto 0);
		Mem_wb_reg_des : IN std_logic_vector(3 downto 0);
		Mem_WB_res : IN std_logic_vector(15 downto 0);
		Immediate : IN std_logic_vector(15 downto 0);    
		ALU_out_q : OUT std_logic_vector(15 downto 0);
		Mem_data_q : OUT std_logic_vector(15 downto 0);
		Mem_op_q : OUT std_logic_vector(1 downto 0);
		Reg_des_q : OUT std_logic_vector(3 downto 0)
		);
END COMPONENT;

COMPONENT STAGE_MEM PORT(
	Clk : IN std_logic;
	Rst : IN std_logic;
	Freeze : out std_logic;
	RAM2_op : out std_logic;
	Data_from_RAM2 : in std_logic_vector (15 downto 0);
	Data_to_RAM2 : out std_Logic_vector (15 downto 0);
	Addr_to_RAM2 : out std_logic_vector (15 downto 0);
	Clk_x2 : IN std_logic;
	Clk_x4 : IN std_logic;
	Step_out_msg : OUT std_logic;
	ALU_out : IN std_logic_vector(15 downto 0);
	R2_data : IN std_logic_vector(15 downto 0);
	Mem_op : IN std_logic_vector(1 downto 0);
	Reg_des : IN std_logic_vector(3 downto 0);    
	RAM1_data : INOUT std_logic_vector(15 downto 0);      
	ALU_out_q : OUT std_logic_vector(15 downto 0);
	Mem_op_q : OUT std_logic_vector(1 downto 0);
	Mem_out_q : OUT std_logic_vector(15 downto 0);
	Reg_des_q : OUT std_logic_vector(3 downto 0);
	RAM1_addr : OUT std_logic_vector(17 downto 0);
	RAM1_en : OUT std_logic;
	RAM1_oe : OUT std_logic;
	RAM1_we : OUT std_logic;
    COM_tsre: in  STD_LOGIC;
    COM_tbre: in  STD_LOGIC;
    COM_data_ready: in  STD_LOGIC;
	COM_wrn : OUT std_logic;
	COM_rdn : OUT std_logic
	);
END COMPONENT;

COMPONENT WB_MUX
PORT(
	ALU_out : IN std_logic_vector(15 downto 0);
	Mem_out : IN std_logic_vector(15 downto 0);
	Mem_op : IN std_logic_vector(1 downto 0);          
	WB_data : OUT std_logic_vector(15 downto 0)
	);
END COMPONENT;

COMPONENT Boot_loader is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           flash_addr : out STD_LOGIC_VECTOR(22 downto 0);
           flash_data : in STD_LOGIC_VECTOR(15 downto 0);
           flash_rw : in STD_LOGIC;
           flash_judge : in STD_LOGIC;
           ram_addr : in STD_LOGIC_VECTOR(15 downto 0);
           ram_data : out STD_LOGIC_VECTOR(15 downto 0);
           ram_en : in STD_LOGIC;
           ram_oe : in STD_LOGIC;
           com_wrn : in STD_LOGIC;
           com_rdn : in STD_LOGIC);
end COMPONENT;

-- WIRES

-- 16 bit integer passed to seven segment displays
signal SSD_data : STD_LOGIC_VECTOR (7 downto 0); 

signal Clk_base : STD_LOGIC;
signal Clk : STD_LOGIC;
signal Clk_x2 : STD_LOGIC;
signal Clk_x4 : STD_LOGIC;
signal PC_src : STD_LOGIC;

signal Step_out_msg, Bubble: STD_LOGIC;
signal NPC_ID, Inst_ID, Branch_PC : STD_LOGIC_VECTOR (15 downto 0);
signal ID_exe_reg_des, Exe_mem_reg_des, Mem_WB_reg_des : STD_LOGIC_VECTOR (3 downto 0);
signal ID_exe_ALU_src_a, ID_exe_ALU_src_b, ID_exe_reg_src_b : STD_LOGIC_VECTOR (3 downto 0);
signal ID_exe_ALU_op : STD_LOGIC_VECTOR (3 downto 0);
signal ID_exe_immediate, ID_exe_rx, ID_exe_ry : STD_LOGIC_VECTOR (15 downto 0);
signal Exe_mem_alu_out, Mem_WB_res, Exe_mem_mem_data, Mem_WB_alu_out : STD_LOGIC_VECTOR (15 downto 0);
signal Mem_WB_mem_data : STD_LOGIC_VECTOR (15 downto 0);
signal Exe_mem_mem_op, ID_exe_mem_op, Mem_WB_mem_op : STD_LOGIC_VECTOR (1 downto 0);

signal Freeze, RAM2_op : STD_LOGIC;
signal Data_to_RAM2, Addr_to_RAM2, Data_from_RAM2 : STD_LOGIC_VECTOR (15 downto 0);

begin
	
	--LED(9 downto 0) <= NPC_ID(9 downto 0);
	LED(9 downto 0) <= Inst_ID(9 downto 0);
	LED(15) <= Clk;
	LED(14) <= Clk_x2;
	LED(13) <= Step_out_msg;
	LED(12) <= Bubble;
	LED(11) <= Freeze;
	LED(10) <= RAM2_op;
	SSD_data <= Mem_WB_res(7 downto 0);
	
	Seven_seg_display_c : SEVEN_SEG_DISPLAY port map ( 
		Data => SSD_data,
		Output_h => SSD_h, 
		Output_l => SSD_l );
	
	Clk_base_gen_c : CLK_BASE_GEN port map ( 
		Clk_in => Clk_in, 
		Clk_base => Clk_base, 
		Rst => Rst );
	Clk_gen_c : CLK_GEN port map ( 
		Clk_base => Clk_base, 
		Clk => Clk, 
		Clk_x2 => Clk_x2, 
		Clk_x4 => Clk_x4, 
		Rst => Rst );
	
	Stage_IF_c : STAGE_IF port map ( 
		Clk => Clk, 
		Clk_x2 => Clk_x2, 
		Clk_x4 => Clk_x4,
		Freeze => Freeze,
		RAM2_op => RAM2_op,
		Data_to_RAM2 => Data_to_RAM2,
		Data_from_RAM2 => Data_from_RAM2,
		Addr_to_RAM2 => Addr_to_RAM2,
		Rst => Rst, 
		Branch_PC => Branch_PC,
		Bubble => Bubble,
		RAM2_we => RAM2_we, 
		RAM2_oe => RAM2_oe, 
		RAM2_data => RAM2_data,
		RAM2_addr => RAM2_addr, 
		RAM2_en => RAM2_en, 
		NPC_ID => NPC_ID, 
		Inst_ID => Inst_ID,
		PC_src => PC_src );
		
	Stage_ID_c : STAGE_ID PORT MAP(
		Clk => Clk,
		Rst => Rst,
		Freeze => Freeze,
		Branch_PC => Branch_PC,
		Bubble_to_PC => Bubble,
		PC_src => PC_src,
		NPC => NPC_ID,
		Inst => Inst_ID,
		ID_exe_reg_des => ID_exe_reg_des,
		Exe_mem_reg_des => Exe_mem_reg_des,
		Exe_mem_alu_out => Exe_mem_alu_out,
		Exe_mem_mem_op => Exe_mem_mem_op,
		Mem_WB_reg_des => Mem_WB_reg_des,
		Mem_WB_res => Mem_WB_res,
		ALU_src_a_q => ID_exe_ALU_src_a,
		ALU_src_b_q => ID_exe_ALU_src_b,
		ALU_op_q => ID_exe_ALU_op,
		Reg_src_b_q => ID_exe_Reg_src_b,
		Immediate_q => ID_exe_Immediate,
		Mem_op_q => ID_exe_mem_op,
		Rx_q => ID_exe_rx,
		Ry_q => ID_exe_ry,
		Rw => Mem_WB_reg_des,
		Rw_data => Mem_WB_res,
		Reg_des_q => ID_exe_reg_des
	);
	
	Stage_exe_c: STAGE_EXE PORT MAP(
		Clk => Clk,
		Rst => Rst,
		Freeze => Freeze,
		ALU_src_a => ID_exe_ALU_src_a,
		ALU_src_b => ID_exe_ALU_src_b,
		Reg_src_b => ID_exe_Reg_src_b,
		ALU_op => ID_exe_ALU_op,
		Mem_op => ID_exe_Mem_op,
		Reg_des => ID_exe_reg_des,
		Rx => ID_exe_rx,
		Ry => ID_exe_ry,
		ALU_out_q => Exe_mem_alu_out,
		Mem_data_q => Exe_mem_mem_data,
		Mem_op_q => Exe_mem_mem_op,
		Reg_des_q => Exe_mem_reg_des,
		Exe_mem_reg_des => Exe_mem_reg_des,
		Exe_mem_alu_out => Exe_mem_alu_out,
		Mem_wb_reg_des => Mem_WB_reg_des,
		Mem_WB_res => Mem_WB_res,
		Immediate => ID_exe_Immediate
	);
	
	Stage_mem_c : STAGE_MEM PORT MAP(
		Clk => Clk,
		Rst => Rst,
		Freeze => Freeze,
		Data_to_RAM2 => Data_to_RAM2,
		Data_from_RAM2 => Data_from_RAM2,
		Addr_to_RAM2 => Addr_to_RAM2,
		RAM2_op => RAM2_op,
		Clk_x2 => Clk_x2,
		Clk_x4 => CLk_x4,
		Step_out_msg => Step_out_msg,
		R2_data => Exe_mem_mem_data,
		ALU_out => Exe_mem_alu_out,
		ALU_out_q => Mem_WB_alu_out,
		Mem_op => Exe_mem_mem_op,
		Mem_op_q => Mem_WB_mem_op,
		Mem_out_q => Mem_WB_mem_data,
		Reg_des => Exe_mem_reg_des,
		Reg_des_q => Mem_WB_reg_des,
		RAM1_addr => RAM1_addr,
		RAM1_data => RAM1_data,
		RAM1_en => RAM1_en,
		RAM1_oe => RAM1_oe,
		RAM1_we => RAM1_we,
		COM_tsre => COM_tsre,
		COM_tbre => COM_tbre,
		COM_data_ready => COM_data_ready,
		COM_wrn => COM_wrn,
		COM_rdn => COM_rdn
	);
	
	WB_mux_c : WB_MUX PORT MAP(
		ALU_out => Mem_WB_alu_out,
		Mem_out => Mem_WB_mem_data,
		Mem_op => Mem_WB_mem_op,
		WB_data => Mem_WB_res
	);

	

end STRUCTRUAL;

