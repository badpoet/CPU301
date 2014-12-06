----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:17:00 12/04/2014 
-- Design Name: 
-- Module Name:    STAGE_EXE - RTL 
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

entity STAGE_EXE is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           ALU_src_a : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_src_b : in  STD_LOGIC_VECTOR (3 downto 0);
		   Reg_src_b : in  STD_LOGIC_VECTOR (3 downto 0);
		   ALU_op : in  STD_LOGIC_VECTOR (3 downto 0);
           Mem_op : in  STD_LOGIC_VECTOR (1 downto 0);
           Reg_des : in  STD_LOGIC_VECTOR (3 downto 0);
           Rx : in  STD_LOGIC_VECTOR (15 downto 0);
           Ry : in  STD_LOGIC_VECTOR (15 downto 0);
           ALU_out_q : out  STD_LOGIC_VECTOR (15 downto 0);
           Mem_data_q : out  STD_LOGIC_VECTOR (15 downto 0);
           Mem_op_q : out  STD_LOGIC_VECTOR (1 downto 0);
           Reg_des_q : out  STD_LOGIC_VECTOR (3 downto 0);
           Exe_mem_reg_des : in  STD_LOGIC_VECTOR (3 downto 0);
           Exe_mem_alu_out : in  STD_LOGIC_VECTOR (15 downto 0);
           Mem_wb_reg_des : in  STD_LOGIC_VECTOR (3 downto 0);
           Mem_WB_res : in  STD_LOGIC_VECTOR (15 downto 0);
           Immediate : in  STD_LOGIC_VECTOR (15 downto 0));
end STAGE_EXE;

architecture STRUCTRAL of STAGE_EXE is

component srcA_mux is 
    Port ( id_ex : in  STD_LOGIC_VECTOR (15 downto 0);
           ex_mem : in  STD_LOGIC_VECTOR (15 downto 0);
           mem_wb : in  STD_LOGIC_VECTOR (15 downto 0);
           ALUsrcA : in  STD_LOGIC_VECTOR (3 downto 0);
           ex_mem_REGdes : in  STD_LOGIC_VECTOR (3 downto 0);
           mem_wb_REGdes : in  STD_LOGIC_VECTOR (3 downto 0);
           srcA : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component srcB_mux is 
    Port ( id_ex : in  STD_LOGIC_VECTOR (15 downto 0);
		   immediate : in  STD_LOGIC_VECTOR (15 downto 0);
           ex_mem : in  STD_LOGIC_VECTOR (15 downto 0);
           mem_wb : in  STD_LOGIC_VECTOR (15 downto 0);
           ALUsrcB : in  STD_LOGIC_VECTOR (3 downto 0);
           ex_mem_REGdes : in  STD_LOGIC_VECTOR (3 downto 0);
           mem_wb_REGdes : in  STD_LOGIC_VECTOR (3 downto 0);
           srcB : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component R2_mux is
	Port ( ID_Exe_r2_data : in  STD_LOGIC_VECTOR (15 downto 0);
           R2 : in  STD_LOGIC_VECTOR (3 downto 0);
           Exe_mem_reg_des : in  STD_LOGIC_VECTOR (3 downto 0);
           Exe_mem_alu_out : in  STD_LOGIC_VECTOR (15 downto 0);
           Mem_WB_reg_des : in  STD_LOGIC_VECTOR (3 downto 0);
           Mem_WB_res : in  STD_LOGIC_VECTOR (15 downto 0);
           R2_data : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component ALU is
	Port ( srcA : in  STD_LOGIC_VECTOR (15 downto 0);
           srcB : in  STD_LOGIC_VECTOR (15 downto 0);
           op : in  STD_LOGIC_VECTOR (3 downto 0);
           result : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component EXE_MEM_REGS is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           ALU_out_d : in  STD_LOGIC_VECTOR (15 downto 0);
           ALU_out_q : out  STD_LOGIC_VECTOR (15 downto 0);
           Mem_data_d : in  STD_LOGIC_VECTOR (15 downto 0);
           Mem_data_q : out  STD_LOGIC_VECTOR (15 downto 0);
           Reg_des_d : in  STD_LOGIC_VECTOR (3 downto 0);
           Reg_des_q : out  STD_LOGIC_VECTOR (3 downto 0);
           Mem_op_d : in  STD_LOGIC_VECTOR (1 downto 0);
           Mem_op_q : out  STD_LOGIC_VECTOR (1 downto 0));
end component;

signal Op_a, Op_b, ALU_res, R2_data : STD_LOGIC_VECTOR (15 downto 0);

begin

	Src_a_mux_c : srcA_mux port map (
		id_ex => Rx,
		ex_mem => Exe_mem_alu_out,
		mem_wb => Mem_WB_res,
		ALUsrcA => ALU_src_a,
		ex_mem_REGdes => Exe_mem_reg_des,
		mem_wb_REGdes => Mem_WB_reg_des,
		srcA => Op_a);
	
	Src_b_mux_c : srcB_mux port map (
		id_ex => Ry,
		immediate => Immediate,
		ex_mem => Exe_mem_alu_out,
		mem_wb => Mem_WB_res,
		ALUsrcB => ALU_src_b,
		ex_mem_REGdes => Exe_mem_reg_des,
		mem_wb_REGdes => Mem_WB_reg_des,
		srcB => Op_b);
		
	R2_mux_c : R2_mux port map (
		ID_Exe_r2_data => Ry,
		R2 => Reg_src_b,
		Exe_mem_reg_des => Exe_mem_reg_des,
		Exe_mem_alu_out => Exe_mem_alu_out,
		Mem_WB_reg_des => Mem_WB_reg_des,
		Mem_WB_res => Mem_WB_res,
		R2_data => R2_data);
	
	ALU_c : ALU port map (
		srcA => Op_a,
		srcB => Op_b,
		op => ALU_op,
		result => ALU_res);
		
	Exe_mem_regs_c : EXE_MEM_REGS port map (
		Clk => Clk,
		Rst => Rst,
		ALU_out_d => ALU_res,
		ALU_out_q => ALU_out_q,
		Mem_data_d => R2_data,
		Mem_data_q => Mem_data_q,
		Reg_des_d => Reg_des,
		Reg_des_q => Reg_des_q,
		Mem_op_d => Mem_op,
		Mem_op_q => Mem_op_q);
	

end STRUCTRAL;

