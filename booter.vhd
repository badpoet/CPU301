----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:01:09 12/08/2014 
-- Design Name: 
-- Module Name:    BOOTER - RTL 
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

entity BOOTER is
    Port ( Flash_byte : out  STD_LOGIC;
           Flash_vpen : out  STD_LOGIC;
           Flash_ce : out  STD_LOGIC;
           Flash_oe : out  STD_LOGIC;
           Flash_we : out  STD_LOGIC;
           Flash_rp : out  STD_LOGIC;
           Flash_addr : out  STD_LOGIC_VECTOR (22 downto 0);
           Flash_data : inout  STD_LOGIC_VECTOR (15 downto 0);
           Clk : in  STD_LOGIC;
		   Op : out  STD_LOGIC;
           Reload : in  STD_LOGIC;
           Data_to_RAM2 : out  STD_LOGIC_VECTOR (15 downto 0);
           Addr_to_RAM2 : out  STD_LOGIC_VECTOR (15 downto 0);
           Boot_state : out  STD_LOGIC);
end BOOTER;

architecture RTL of BOOTER is
	type FSM is (S_init1, S_init2, S_load, S_init3, S_init4, S_write, S_over);
	signal State : FSM := S_init1;
	signal Clk_slow : STD_LOGIC;
	signal Cnt : INTEGER RANGE 0 TO 250 := 0;
	signal Addr, Data : STD_LOGIC_VECTOR (15 downto 0);
begin

	Boot_state <= '1' when State = S_over else '0';
	Flash_ce <= '0';
	Flash_byte <= '1';
	Flash_vpen <= '1';
	Flash_rp <= '1';
	Flash_addr(22 downto 17) <= (others => '0');
	
	process (Clk, Reload) begin
		if (Reload = '0') then
			Cnt <= 0;
		elsif (Clk'event and Clk = '1') then
			if (Cnt = 0) then
				Clk_slow <= NOT(Clk_slow);
			end if;
			Cnt <= Cnt + 1;
		end if;
	end process;

	process (Clk_slow, Reload) begin
		if (Reload = '0') then
			State <= S_init1;
			Addr <= (others => '0');
			Data <= (others => '0');
		elsif (Clk_slow'event and Clk_slow = '1') then
			case State is
				when S_init1 =>
					Op <= '0';
					State <= S_init2;
					Flash_we <= '0';
				when S_init2 =>
					Op <= '0';
					Flash_data <= "0000000011111111";
					State <= S_init3;
				when S_init3 =>
					Op <= '0';
					State <= S_init4;
					Flash_we <= '1';
				when S_init4 =>
					Op <= '0';
					Flash_oe <= '0';
					State <= S_load;
				when S_load =>
					Op <= '0';
					Flash_addr(16 downto 0) <= Addr & "0";
					Flash_data <= (others => 'Z');
					State <= S_write;
				when S_write =>
					Data_to_RAM2 <= Flash_data;
					Addr_to_RAM2 <= Addr;
					Op <= '1';
					Flash_oe <= '1';
					Flash_addr(16 downto 0) <= Addr & "0";
					Addr <= STD_LOGIC_VECTOR(UNSIGNED(Addr) + 1);
					if (Addr = "0011111111111111") then
						State <= S_over;
					else
						State <= S_init1;
					end if;
				when others =>
					Op <= '0';
					State <= S_over;
			end case;
		end if;
	end process;

end RTL;

