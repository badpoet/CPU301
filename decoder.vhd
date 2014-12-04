----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:51:38 12/02/2014 
-- Design Name: 
-- Module Name:    DECODER - RTL 
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

entity DECODER is
    Port ( Inst : in  STD_LOGIC_VECTOR (15 downto 0);
           PC_branch : out  STD_LOGIC_VECTOR (1 downto 0);
		     PC_src : out  STD_LOGIC_VECTOR;
           Rx : out  STD_LOGIC_VECTOR (3 downto 0);
           Ry : out  STD_LOGIC_VECTOR (3 downto 0);
           Rz : out  STD_LOGIC_VECTOR (3 downto 0);
           Imm : out  STD_LOGIC_VECTOR (15 downto 0);
           MEM_op : out  STD_LOGIC_VECTOR (1 downto 0);
           REG_write : out  STD_LOGIC;
           REG_des : out  STD_LOGIC_VECTOR (2 downto 0);
           ALU_src_a : out  STD_LOGIC_VECTOR (1 downto 0);
           ALU_src_b : out  STD_LOGIC_VECTOR (2 downto 0);
           ALU_op : out  STD_LOGIC_VECTOR (3 downto 0));
end DECODER;

architecture RTL of DECODER is

begin

	process (Inst) begin
		
		-- PC_branch
		-- PC_src
		-- Mem_op
		-- REG_src
		-- REG_des
		case Inst(15 downto 11) is
			when "01001"=>
				PC_branch <=;
				PC_src <=;
				Rx <=;
				Ry <=;
				Rz <=;
				Imm <=;
				MEM_op <=;
				REG_src <=;
				REG_des <=;
				REG_write <=;
				REG_des <=;
				ALU_src_a <=;
				ALU_src_b <=;
				ALU_op <=;
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when "01001"=>
			when others=>
		end case;
		
	end process;

end RTL;

