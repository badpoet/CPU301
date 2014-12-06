----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:29:57 12/01/2014 
-- Design Name: 
-- Module Name:    PC_branch_calc - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BRANCH_CALC is
    Port ( PC : in  STD_LOGIC_VECTOR (15 downto 0);
           Immediate : in  STD_LOGIC_VECTOR (15 downto 0);
           Rx_data : in  STD_LOGIC_VECTOR (15 downto 0);
		   Rx : in  STD_LOGIC_VECTOR (3 downto 0);
		   Bubble_in_branch : out  STD_LOGIC;
		   ID_exe_reg_des : in  STD_LOGIC_VECTOR (3 downto 0);
		   Exe_mem_reg_des : in  STD_LOGIC_VECTOR (3 downto 0);
		   Exe_mem_alu_out : in  STD_LOGIC_VECTOR (15 downto 0);
		   Exe_mem_mem_op : in  STD_LOGIC_VECTOR (1 downto 0);
		   Mem_WB_reg_des : in  STD_LOGIC_VECTOR (3 downto 0);
		   Mem_WB_res : in  STD_LOGIC_VECTOR (15 downto 0);
		   Condition_jump : in  STD_LOGIC_VECTOR (2 downto 0);
           Branch_PC : out  STD_LOGIC_VECTOR (15 downto 0);
		   PC_src : out  STD_LOGIC);
end BRANCH_CALC;

architecture RTL of BRANCH_CALC is
	signal R_data : STD_LOGIC_VECTOR (15 downto 0);
begin

	process (Condition_jump, ID_exe_reg_des, Rx, Rx_data, Exe_mem_reg_des, 
		Exe_mem_alu_out, Exe_mem_mem_op, Mem_WB_reg_des, Mem_WB_res) begin
		
		if (ID_exe_reg_des = Rx) then
			Bubble_in_branch <= '1';
			R_data <= (others => '0');
		elsif (Exe_mem_reg_des = Rx) then
			if (Exe_mem_mem_op = "10") then
				Bubble_in_branch <= '1';
				R_data <= (others => '0');
			else
				Bubble_in_branch <= '0';
				R_data <= Exe_mem_alu_out;
			end if;
		elsif (Mem_WB_reg_des = Rx) then
			Bubble_in_branch <= '0';
			R_data <= Mem_WB_res;
		else
			Bubble_in_branch <= '0';
			R_data <= Rx_data;
		end if;
	end process;
	
	process (Condition_jump, R_data, PC, Immediate) begin
		case Condition_jump is
			when "001" =>
				Branch_PC <= STD_LOGIC_VECTOR(UNSIGNED(PC) + UNSIGNED(Immediate));
				PC_src <= '1';
			when "010" =>
				Branch_PC <= STD_LOGIC_VECTOR(UNSIGNED(PC) + UNSIGNED(Immediate));
				if R_data = (R_data'range => '0') then
					PC_src <= '1';
				else
					PC_src <= '0';
				end if;
			when "011" =>
				Branch_PC <= STD_LOGIC_VECTOR(UNSIGNED(PC) + UNSIGNED(Immediate));
				if R_data = (R_data'range => '0') then
					PC_src <= '0';
				else
					PC_src <= '1';
				end if;
			when "100" =>
				Branch_PC <= R_data; 
				PC_src <= '1';
			when others =>
				Branch_PC <= PC;
				PC_src <= '0';
		end case;
	end process;

end RTL;

