----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:31:38 12/04/2014 
-- Design Name: 
-- Module Name:    srcA_mux - Behavioral 
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

entity srcA_mux is
    Port ( id_ex : in  STD_LOGIC_VECTOR (15 downto 0);
           ex_mem : in  STD_LOGIC_VECTOR (15 downto 0);
           mem_wb : in  STD_LOGIC_VECTOR (15 downto 0);
           ALUsrcA : in  STD_LOGIC_VECTOR (3 downto 0);
           ex_mem_REGdes : in  STD_LOGIC_VECTOR (3 downto 0);
           mem_wb_REGdes : in  STD_LOGIC_VECTOR (3 downto 0);
           srcA : out  STD_LOGIC_VECTOR (15 downto 0));
end srcA_mux;

architecture RTL of srcA_mux is

begin

	process (ALUsrcA, ex_mem_REGdes, mem_wb_REGdes) begin
		if (ALUsrcA = ex_mem_REGdes) then
			srcA <= ex_mem;
		elsif (ALUsrcA = mem_wb_REGdes) then
			srcA <= mem_wb;
		else
			srcA <= id_ex;
		end if;
	end process;
	
end RTL;