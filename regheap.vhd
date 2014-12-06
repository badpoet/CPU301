----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:32:45 12/02/2014 
-- Design Name: 
-- Module Name:    REGHEAP - RTL 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REG_HEAP is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Rx : in  STD_LOGIC_VECTOR (3 downto 0);
           Ry : in  STD_LOGIC_VECTOR (3 downto 0);
           Rw : in  STD_LOGIC_VECTOR (3 downto 0);
           Rw_data : in  STD_LOGIC_VECTOR (15 downto 0);
		   PC : in  STD_LOGIC_VECTOR (15 downto 0);
		   T_q : out  STD_LOGIC_VECTOR (15 downto 0);
           Rx_q : out  STD_LOGIC_VECTOR (15 downto 0);
           Ry_q : out  STD_LOGIC_VECTOR (15 downto 0));
end REG_HEAP;

-- 0000 zero (write behavior effects nothing)
-- 0001 SP
-- 0010 T
-- 0011 RA
-- 0100 IH
-- 0101 PC (write behavior effects nothing)
-- 0111 Imm (read behavior is uncertain!)
-- 1xxx Rx

architecture RTL of REG_HEAP is
	type Reg_t is ARRAY (0 to 15) of STD_LOGIC_VECTOR (15 downto 0);
	signal Reg : Reg_t;
begin
	process (Clk, Rst) begin
		if (Rst = '0') then
			Reg <= (others => (others => '0'));
		elsif (Clk'event and Clk = '1') then
			Reg(TO_INTEGER(unsigned(Rw(3 downto 0)))) <= Rw_data;
		end if;
	end process;
	
	process (Rx, Rw, Rw_data) begin
		if (Rx = "0000" or Rx = "0111") then 
			Rx_q <= (others => '0');
		elsif (Rx = "0101") then
			Rx_q <= PC;
		elsif (Rx = Rw) then
			Rx_q <= Rw_data;
		else
			Rx_q <= Reg(TO_INTEGER(unsigned(Rx)));
		end if;
	end process;
	
	process (Ry, Rw, Rw_data) begin
		if (Ry = "0000" or Rx = "0111") then
			Ry_q <= (others => '0');
		elsif (Ry = "0101") then
			Ry_q <= PC;
		elsif (Ry = Rw) then
			Ry_q <= Rw_data;
		else
			Ry_q <= Reg(TO_INTEGER(unsigned(Ry)));
		end if;
	end process;
	
	T_q <= Reg(2);
	
end RTL;

