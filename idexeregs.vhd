----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:35:13 12/06/2014 
-- Design Name: 
-- Module Name:    ID_EXE_REGS - RTL 
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

entity ID_EXE_REGS is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
		   Bubble : in  STD_LOGIC;
           ALU_src_a_d : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_src_b_d : in  STD_LOGIC_VECTOR (3 downto 0);
           Reg_src_b_d : in  STD_LOGIC_VECTOR (3 downto 0);
           Rx_d : in  STD_LOGIC_VECTOR (15 downto 0);
           Ry_d : in  STD_LOGIC_VECTOR (15 downto 0);
           Immediate_d : in  STD_LOGIC_VECTOR (15 downto 0);
           Mem_op_d : in  STD_LOGIC_VECTOR (1 downto 0);
           Reg_des_d : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_src_a_q : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_src_b_q : in  STD_LOGIC_VECTOR (3 downto 0);
           Reg_src_b_q : in  STD_LOGIC_VECTOR (3 downto 0);
           Rx_q : in  STD_LOGIC_VECTOR (15 downto 0);
           Ry_q : in  STD_LOGIC_VECTOR (15 downto 0);
           Immediate_q : in  STD_LOGIC_VECTOR (15 downto 0);
           Mem_op_q : in  STD_LOGIC_VECTOR (1 downto 0);
           Reg_des_q : in  STD_LOGIC_VECTOR (3 downto 0));
end ID_EXE_REGS;

architecture RTL of ID_EXE_REGS is
		signal ALU_src_a : STD_LOGIC_VECTOR (3 downto 0);
		signal ALU_src_b : STD_LOGIC_VECTOR (3 downto 0);
		signal Reg_src_b : STD_LOGIC_VECTOR (3 downto 0);
		signal Rx : STD_LOGIC_VECTOR (15 downto 0);
		signal Ry : STD_LOGIC_VECTOR (15 downto 0);
		signal Immediate : STD_LOGIC_VECTOR (15 downto 0);
		signal Mem_op : STD_LOGIC_VECTOR (1 downto 0);
		signal Reg_des : STD_LOGIC_VECTOR (3 downto 0);
begin
	process (Clk, Rst, Bubble) begin
		if Rst = '0' then
			ALU_src_a <= (others => '0');
			ALU_src_b <= (others => '0');
			Reg_src_b <= (others => '0');
			Rx <= (others => '0');
			Ry <= (others => '0');
			Immediate <= (others => '0');
			Mem_op <= (others => '0');
			Reg_des <= (others => '0');
		elsif Clk'event and Clk = '1' then
			if Bubble = '1' then
				ALU_src_a <= (others => '0');
				ALU_src_b <= (others => '0');
				Reg_src_b <= (others => '0');
				Rx <= (others => '0');
				Ry <= (others => '0');
				Immediate <= (others => '0');
				Mem_op <= (others => '0');
				Reg_des <= (others => '0');
			else
				ALU_src_a <= ALU_src_a_d;
				ALU_src_b <= ALU_src_b_d;
				Reg_src_b <= Reg_src_b_d;
				Rx <= Rx_d;
				Ry <= Ry_d;
				Immediate <= Immediate_d;
				Mem_op <= Mem_op_d;
				Reg_des <= Reg_des_d;
			end if;
		end if;
	end process;
	ALU_src_a_q <= ALU_src_a;
	ALU_src_b_q <= ALU_src_b;
	Reg_src_b_q <= Reg_src_b;
	Rx_q <= Rx;
	Ry_q <= Ry;
	Immediate_q <= Immediate;
	Mem_op_q <= Mem_op;
	Reg_des_q <= Reg_des;
end RTL;

