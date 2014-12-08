----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:19:57 12/04/2014 
-- Design Name: 
-- Module Name:    MEM_WB_REGS - RTL 
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

entity MEM_WB_REGS is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
		   Freeze : in  STD_LOGIC;
           ALU_out_d : in  STD_LOGIC_VECTOR (15 downto 0);
           Mem_out_d : in  STD_LOGIC_VECTOR (15 downto 0);
           Mem_op_d : in  STD_LOGIC_VECTOR (1 downto 0);
           Reg_des_d : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out_q : out  STD_LOGIC_VECTOR (15 downto 0);
           Mem_out_q : out  STD_LOGIC_VECTOR (15 downto 0);
           Mem_op_q : out  STD_LOGIC_VECTOR (1 downto 0);
           Reg_des_q : out  STD_LOGIC_VECTOR (3 downto 0));
end MEM_WB_REGS;

architecture RTL of MEM_WB_REGS is
	signal ALU_out : STD_LOGIC_VECTOR (15 downto 0);
	signal Mem_out : STD_LOGIC_VECTOR (15 downto 0);
	signal Reg_des : STD_LOGIC_VECTOR (3 downto 0);
	signal Mem_op : STD_LOGIC_VECTOR (1 downto 0);
begin
	process (Clk, Rst) begin
		if Rst = '0' then
			ALU_out <= (others => '0');
			Mem_out <= (others => '0');
			Reg_des <= (others => '0');
			Mem_op <= (others => '0');
		elsif Clk'event and Clk = '1' and Freeze = '0' then
			ALU_out <= ALU_out_d;
			Mem_out <= Mem_out_d;
			Reg_des <= Reg_des_d;
			Mem_op <= Mem_op_d;
		end if;
	end process;
	ALU_out_q <= ALU_out;
	Mem_out_q <= Mem_out;
	Reg_des_q <= Reg_des;
	Mem_op_q <= Mem_op;
end RTL;

