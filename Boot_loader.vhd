----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:20:39 12/08/2014 
-- Design Name: 
-- Module Name:    Boot_loader - RTL 
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

entity Boot_loader is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           flash_addr : out STD_LOGIC_VECTOR(22 downto 0);
           flash_data : in STD_LOGIC_VECTOR(15 downto 0);
           flash_rw : in STD_LOGIC;
           flash_judge : in STD_LOGIC;
           ram_addr : in STD_LOGIC_VECTOR(15 downto 0);
           ram_data : out STD_LOGIC_VECTOR(15 downto 0);
           ram_en : in STD_LOGIC;
           ram_oe : in STD_LOGIC;
           com_wrn : in STD_LOGIC;
           com_rdn : in STD_LOGIC;);
end Boot_loader;

architecture RTL of Boot_loader is
	signal addr : STD_LOGIC_VECTOR(15 downto 0);
	signal data : STD_LOGIC_VECTOR(15 downto 0);
	signal state : STD_LOGIC;
begin
	
	process (flash_judge) begin
		if flash_judge = '0' then
			data <= flash_data;
		end if;
	end process;

	process (rst, clk) begin
		if (rst = '0') then
			addr <= (others => '0');
			state <= '0';
		elsif rising_edge(clk) then
			if (addr < "0000001000000000000000") then
				state <= not state;
				if (state = '1')
					addr <= addr + 1;
				end if;
			end if;
		end if;
	end process;

	process (rst, state) begin
        if (rst = '0') then
	        flash_addr <= (others => 'Z');
	        flash_rw <= (others => 'Z');
	        ram_addr <= (others => 'Z');
			ram_data <= (others => 'Z');
	        ram_en <= 'Z';
            ram_we <= 'Z';
	        ram_oe <= 'Z';
	        com_wrn <= 'Z';
	        com_rdn <= 'Z';
        else
	        flash_addr <= "0000000"&addr;
	        flash_rw <= "11";
	        ram_addr <= "00"&addr;
			ram_data <= data;
	        ram_en <= '0';
            ram_we <= '1';
	        ram_oe <= '1';
	        com_wrn <= '1';
		    case state is
			    when '0' =>
				    ram_we <= '1';
			    when '1' =>
				    ram_we <= '0';
		    end case;
        end if;
	end process;

end RTL;
