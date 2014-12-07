----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:20:20 12/05/2014 
-- Design Name: 
-- Module Name:    R2_mux - RTL 
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

entity R2_mux is
    Port ( ID_Exe_r2_data : in  STD_LOGIC_VECTOR (15 downto 0);
           R2 : in  STD_LOGIC_VECTOR (3 downto 0);
           Exe_mem_reg_des : in  STD_LOGIC_VECTOR (3 downto 0);
           Exe_mem_alu_out : in  STD_LOGIC_VECTOR (15 downto 0);
           Mem_WB_reg_des : in  STD_LOGIC_VECTOR (3 downto 0);
           Mem_WB_res : in  STD_LOGIC_VECTOR (15 downto 0);
           R2_data : out  STD_LOGIC_VECTOR (15 downto 0));
end R2_mux;

architecture RTL of R2_mux is

begin

	process (R2, Exe_mem_reg_des, Mem_WB_reg_des) begin
		if R2 = "0000" then
			R2_data <= (others => '0');
		elsif Exe_mem_reg_des = R2 then
			R2_data <= Exe_mem_alu_out;
		elsif Mem_WB_reg_des = R2 then
			R2_data <= Mem_WB_res;
		else
			R2_data <= ID_Exe_r2_data;
		end if;
	end process;

end RTL;

