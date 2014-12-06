----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:56:17 12/06/2014 
-- Design Name: 
-- Module Name:    STAGE_ID - RTL 
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

entity STAGE_ID is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
		   Branch_PC : out  STD_LOGIC_VECTOR (15 downto 0);
		   PC_src : out  STD_LOGIC;
           NPC : in  STD_LOGIC_VECTOR (15 downto 0);
           Inst : in  STD_LOGIC_VECTOR (15 downto 0);
		   ID_exe_reg_des : in  STD_LOGIC_VECTOR (3 downto 0);
		   Exe_mem_reg_des : in  STD_LOGIC_VECTOR (3 downto 0);
		   Exe_mem_alu_out : in  STD_LOGIC_VECTOR (15 downto 0);
		   Exe_mem_mem_op : in  STD_LOGIC_VECTOR (1 downto 0);
		   Mem_WB_reg_des : in  STD_LOGIC_VECTOR (3 downto 0);
		   Mem_WB_res : in  STD_LOGIC_VECTOR (15 downto 0);
		   ALU_op_q : out STD_LOGIC_VECTOR (3 downto 0);
           ALU_src_a_q : out  STD_LOGIC_VECTOR (3 downto 0);
           ALU_src_b_q : out  STD_LOGIC_VECTOR (3 downto 0);
           Reg_src_b_q : out  STD_LOGIC_VECTOR (3 downto 0);
           Immediate_q : out  STD_LOGIC_VECTOR (15 downto 0);
           Mem_op_q : out  STD_LOGIC_VECTOR (1 downto 0);
           Rx_q : out  STD_LOGIC_VECTOR (15 downto 0);
           Ry_q : out  STD_LOGIC_VECTOR (15 downto 0);
		   Rw : in  STD_LOGIC_VECTOR (3 downto 0);
		   Rw_data : in  STD_LOGIC_VECTOR (15 downto 0);
           Reg_des_q : out  STD_LOGIC_VECTOR (3 downto 0));
end STAGE_ID;

architecture STRUCTRAL of STAGE_ID is

COMPONENT DECODER PORT(
	Inst : IN std_logic_vector(15 downto 0);          
	PC_branch : OUT std_logic_vector(2 downto 0);
	Imm : OUT std_logic_vector(15 downto 0);
	MEM_op : OUT std_logic_vector(1 downto 0);
	REG_des : OUT std_logic_vector(3 downto 0);
	ALU_src_a : OUT std_logic_vector(3 downto 0);
	ALU_src_b : OUT std_logic_vector(3 downto 0);
	REG_src_b : OUT std_logic_vector(3 downto 0);
	ALU_op : OUT std_logic_vector(3 downto 0)
	);
END COMPONENT;

COMPONENT REG_HEAP PORT(
	Clk : IN std_logic;
	Rst : IN std_logic;
	Rx : IN std_logic_vector(3 downto 0);
	Ry : IN std_logic_vector(3 downto 0);
	Rw : IN std_logic_vector(3 downto 0);
	Rw_data : IN std_logic_vector(15 downto 0);
	PC : IN std_logic_vector(15 downto 0);          
	T_q : OUT std_logic_vector(15 downto 0);
	Rx_q : OUT std_logic_vector(15 downto 0);
	Ry_q : OUT std_logic_vector(15 downto 0)
	);
END COMPONENT;


COMPONENT ID_EXE_REGS PORT(
	Clk : IN std_logic;
	Rst : IN std_logic;
	ALU_src_a_d : IN std_logic_vector(3 downto 0);
	ALU_src_b_d : IN std_logic_vector(3 downto 0);
	Reg_src_b_d : IN std_logic_vector(3 downto 0);
	Rx_d : IN std_logic_vector(15 downto 0);
	Ry_d : IN std_logic_vector(15 downto 0);
	Immediate_d : IN std_logic_vector(15 downto 0);
	Mem_op_d : IN std_logic_vector(1 downto 0);
	Reg_des_d : IN std_logic_vector(3 downto 0);
	ALU_op_d : in STD_LOGIC_VECTOR (3 downto 0);
	ALU_op_q : out STD_LOGIC_VECTOR (3 downto 0);
	ALU_src_a_q : out std_logic_vector(3 downto 0);
	ALU_src_b_q : out std_logic_vector(3 downto 0);
	Reg_src_b_q : out std_logic_vector(3 downto 0);
	Rx_q : out std_logic_vector(15 downto 0);
	Ry_q : out std_logic_vector(15 downto 0);
	Immediate_q : out std_logic_vector(15 downto 0);
	Mem_op_q : out std_logic_vector(1 downto 0);
	Reg_des_q : out std_logic_vector(3 downto 0));
END COMPONENT;

COMPONENT BRANCH_CALC PORT(
	PC : IN std_logic_vector(15 downto 0);
	Immediate : IN std_logic_vector(15 downto 0);
	Rx_data : IN std_logic_vector(15 downto 0);
	Rx : IN std_logic_vector(3 downto 0);
	ID_exe_reg_des : IN std_logic_vector(3 downto 0);
	Exe_mem_reg_des : IN std_logic_vector(3 downto 0);
	Exe_mem_alu_out : IN std_logic_vector(15 downto 0);
	Exe_mem_mem_op : IN std_logic_vector(1 downto 0);
	Mem_WB_reg_des : IN std_logic_vector(3 downto 0);
	Mem_WB_res : IN std_logic_vector(15 downto 0);
	Condition_jump : IN std_logic_vector(2 downto 0);          
	Bubble_in_branch : OUT std_logic;
	Branch_PC : OUT std_logic_vector(15 downto 0);
	PC_src : OUT std_logic);
END COMPONENT;

COMPONENT HAZARD
PORT(
	MEM_op : IN std_logic_vector(1 downto 0);
	REG_des : IN std_logic_vector(3 downto 0);
	ALU_src_a : IN std_logic_vector(3 downto 0);
	REG_src_b : IN std_logic_vector(3 downto 0);
	Bubble_in_branch : IN std_logic;          
	bubble : OUT std_logic
	);
END COMPONENT;

	
signal PC_branch : STD_LOGIC_VECTOR (2 downto 0);
signal Immediate, T, Rx_data, Ry_data : STD_LOGIC_VECTOR (15 downto 0);
signal Mem_op : STD_LOGIC_VECTOR (1 downto 0);
signal ALU_op, ALU_src_a, ALU_src_b, Reg_src_b, Reg_des : STD_LOGIC_VECTOR (3 downto 0);
signal Bubble, Bubble_in_branch : STD_LOGIC;

begin

	Decoder_c : DECODER PORT MAP(
		Inst => Inst,
		PC_branch => PC_branch,
		Imm => Immediate,
		MEM_op => Mem_op,
		REG_des => Reg_des,
		ALU_src_a => ALU_src_a,
		ALU_src_b => ALU_src_b,
		REG_src_b => Reg_src_b,
		ALU_op => ALU_op
	);

	Reg_heap_c : REG_HEAP PORT MAP(
		Clk => Clk,
		Rst => Rst,
		Rx => ALU_src_a,
		Ry => Reg_src_b,
		Rw => Rw,
		Rw_data => Rw_data,
		PC => NPC,
		T_q => T,
		Rx_q => Rx_data,
		Ry_q => Ry_data
	);

	ID_exe_regs_c: ID_EXE_REGS PORT MAP(
		Clk => Clk,
		Rst => Rst,
		ALU_src_a_d => ALU_src_a,
		ALU_src_b_d => ALU_src_b,
		Reg_src_b_d => Reg_src_b,
		Rx_d => Rx_data,
		Ry_d => Ry_data,
		Immediate_d => Immediate,
		Mem_op_d => Mem_op,
		Reg_des_d => Reg_des,
		ALU_op_d => ALU_op,
		ALU_op_q => ALU_op_q,
		ALU_src_a_q => ALU_src_a_q,
		ALU_src_b_q => ALU_src_b_q,
		Reg_src_b_q => Reg_src_b_q,
		Rx_q => Rx_q,
		Ry_q => Ry_q,
		Immediate_q => Immediate_q,
		Mem_op_q => Mem_op_q,
		Reg_des_q => Reg_des_q 
	);
	
	Branch_calc_c : BRANCH_CALC PORT MAP(
		PC => NPC,
		Immediate => Immediate,
		Rx_data => Rx_data,
		Rx => ALU_src_a,
		Bubble_in_branch => Bubble_in_branch,
		ID_exe_reg_des => ID_exe_reg_des,
		Exe_mem_reg_des => Exe_mem_reg_des,
		Exe_mem_alu_out => Exe_mem_alu_out,
		Exe_mem_mem_op => Exe_mem_mem_op,
		Mem_WB_reg_des => Mem_WB_reg_Des,
		Mem_WB_res => Mem_WB_res,
		Condition_jump => PC_branch,
		Branch_PC => Branch_PC,
		PC_src => PC_src
	);
	
	Hazard_c : HAZARD PORT MAP(
		MEM_op => Mem_op,
		REG_des => Reg_des,
		ALU_src_a => ALU_src_a,
		REG_src_b => REG_src_b,
		Bubble_in_branch => Bubble_in_branch,
		bubble => Bubble
	);

end STRUCTRAL;

