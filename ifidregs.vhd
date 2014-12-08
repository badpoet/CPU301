----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:23:13 12/01/2014 
-- Design Name: 
-- Module Name:    IF_ID_REGS - RTL 
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

entity IF_ID_REGS is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
		   Bubble : in  STD_LOGIC;
		   Freeze : in  STD_LOGIC;
           NPC_d : in  STD_LOGIC_VECTOR (15 downto 0);
           Inst_d : in  STD_LOGIC_VECTOR (15 downto 0);
           NPC_q : out  STD_LOGIC_VECTOR (15 downto 0);
           Inst_q : out  STD_LOGIC_VECTOR (15 downto 0));
end IF_ID_REGS;

architecture RTL of IF_ID_REGS is
	signal NPC : STD_LOGIC_VECTOR (15 downto 0);
	signal Inst : STD_LOGIC_VECTOR (15 downto 0);
begin
	process (Clk, Rst, NPC, Inst) begin
		if (Rst = '0') then
			NPC <= (others => '0');
			Inst <= (others => '0');
		elsif (Clk'event and Clk = '1' and Bubble = '0' and Freeze = '0') then
			NPC <= NPC_d;
			Inst <= Inst_d;
		end if;
	end process;
	NPC_q <= NPC;
	Inst_q <= Inst;
end RTL;

