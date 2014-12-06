----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:01:32 12/06/2014 
-- Design Name: 
-- Module Name:    stagemem - Behavioral 
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

entity STAGE_MEM is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Clk_x2 : in  STD_LOGIC;
           Clk_x4 : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (15 downto 0);
           ALU_out_q : out  STD_LOGIC_VECTOR (15 downto 0);
		   R2_data : in  STD_LOGIC_VECTOR (15 downto 0);
           Mem_op : in  STD_LOGIC_VECTOR (1 downto 0);
           Mem_op_q : out  STD_LOGIC_VECTOR (1 downto 0);
           Mem_out_q : out  STD_LOGIC_VECTOR (15 downto 0);
           Reg_des : in  STD_LOGIC_VECTOR (3 downto 0);
           Reg_des_q : out  STD_LOGIC_VECTOR (15 downto 0);
		   RAM1_addr : out  STD_LOGIC_VECTOR (15 downto 0);
		   RAM1_data : inout  STD_LOGIC_VECTOR (15 downto 0);
		   RAM1_en : out  STD_LOGIC;
		   RAM1_oe : out  STD_LOGIC;
		   RAM1_we : out  STD_LOGIC;
		   COM_wrn : out  STD_LOGIC;
		   COM_rdn : out  STD_LOGIC);
end STAGE_MEM;

architecture STRUCTRAL of STAGE_MEM is

COMPONENT MEMORY PORT(
	Clk : IN std_logic;
	Rst : IN std_logic;
	MEMop : IN std_logic_vector(1 downto 0);
	addr : IN std_logic_vector(15 downto 0);
	data : IN std_logic_vector(15 downto 0);
	Clk2 : IN std_logic;    
	RAM1_data : INOUT std_logic_vector(15 downto 0);      
	RAM1_we : OUT std_logic;
	RAM1_oe : OUT std_logic;
	RAM1_en : OUT std_logic;
	memout : OUT std_logic_vector(15 downto 0);
	COM_rdn : OUT std_logic;
	COM_wrn : OUT std_logic;
	RAM1_addr : OUT std_logic_vector(17 downto 0)
	);
END COMPONENT;

COMPONENT MEM_WB_REGS PORT(
	Clk : IN std_logic;
	Rst : IN std_logic;
	ALU_out_d : IN std_logic_vector(15 downto 0);
	Mem_out_d : IN std_logic_vector(15 downto 0);
	Mem_op_d : IN std_logic_vector(1 downto 0);
	Reg_des_d : IN std_logic_vector(3 downto 0);          
	ALU_out_q : OUT std_logic_vector(15 downto 0);
	Mem_out_q : OUT std_logic_vector(15 downto 0);
	Mem_op_q : OUT std_logic_vector(1 downto 0);
	Reg_des_q : OUT std_logic_vector(3 downto 0)
	);
END COMPONENT;

signal Mem_out : STD_LOGIC_VECTOR (15 downto 0);

begin

	Memory_c : MEMORY PORT MAP(
		Clk => Clk,
		Rst => Rst,
		RAM1_we => RAM1_we,
		RAM1_oe => RAM1_oe,
		RAM1_en => RAM1_en,
		MEMop => Mem_op,
		addr => ALU_out,
		data => R2_data,
		memout => Mem_out,
		Clk2 => Clk_x2,
		COM_rdn => COM_rdn,
		COM_wrn => COM_wrn,
		RAM1_addr => RAM1_addr,
		RAM1_data => RAM1_data
	);

	Inst_MEM_WB_REGS: MEM_WB_REGS PORT MAP(
		Clk => Clk,
		Rst => Rst,
		ALU_out_d => ALU_out,
		Mem_out_d => Mem_out,
		Mem_op_d => Mem_op,
		Reg_des_d => Reg_des,
		ALU_out_q => ALU_out_q,
		Mem_out_q => Mem_out_q,
		Mem_op_q => Mem_op_q,
		Reg_des_q => Reg_des_q
	);

end STRUCTRAL;

