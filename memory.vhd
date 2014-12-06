----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:27:22 11/29/2014 
-- Design Name: 
-- Module Name:    IFETCHER - RTL 
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

entity MEMORY is
    Port ( Clk : in  STD_LOGIC;
    	     Rst : in  STD_LOGIC;
           RAM1_we : out  STD_LOGIC;
           RAM1_oe : out  STD_LOGIC;
           RAM1_en : out  STD_LOGIC;
           MEMop : in  STD_LOGIC_VECTOR (1 downto 0);
           addr : in  STD_LOGIC_VECTOR (15 downto 0);
           data : in  STD_LOGIC_VECTOR (15 downto 0);
           memout : out  STD_LOGIC_VECTOR (15 downto 0);
           Clk2 : in  STD_LOGIC;
           COM_rdn : out  STD_LOGIC;
           COM_wrn : out  STD_LOGIC;
           COM_tsre: in  STD_LOGIC;
           COM_tbre: in  STD_LOGIC;
           COM_data_ready: in  STD_LOGIC;
           RAM1_addr : out  STD_LOGIC_VECTOR (17 downto 0);
           RAM1_data : inout  STD_LOGIC_VECTOR (15 downto 0));
end MEMORY;

architecture RTL of MEMORY is
	signal step: std_logic := '0';
begin

	process (Clk2, Rst, addr) begin
		if (Rst = '0') then
			step <= '0';
			RAM1_en <= '1';
		   RAM1_oe <= '1';
         RAM1_we <= '1';
			COM_rdn <= '1';
			COM_wrn <= '1';
			RAM1_addr <= (others => '0');
			RAM1_data <= (others => '0');
			memout <= (others => '0');
		elsif (Clk2'event and Clk2 = '1') then
			step <= not step;
         case addr(15 downto 1) is
           	when "101111110000000"=>
					RAM1_en <= '1';
					RAM1_oe <= '1';
					RAM1_we <= '1';
					RAM1_addr <= (others => '0');
					if addr(0) = '0' then
						memout <= RAM1_data;
						case MEMop is
							when "10"=>
								COM_wrn <= '1';
								if (step = '0') then
									COM_rdn <= '1';
									RAM1_data <= (others => 'Z');
								else
									COM_rdn <= '0';
								end if;
							when "11"=>
								COM_rdn <= '1';
								RAM1_data <= data;
								if (step = '0') then
									COM_wrn <= '1';
								else
									COM_wrn <= '0';
								end if;
							when others=>
								COM_rdn <= '1';
								COM_wrn <= '1';
								RAM1_data <= (others => '0');
						end case;
					else
						COM_rdn <= '1';
						COM_wrn <= '1';
						RAM1_data <= (others => 'Z');
						memout <= "00000000000000"&COM_data_ready&(COM_tsre and COM_tbre);
					end if;
            when others=>
					RAM1_en <= '0';
		    		RAM1_oe <= '0';
					COM_rdn <= '1';
					COM_wrn <= '1';
					RAM1_addr <= "00"&addr;
					memout <= RAM1_data;
					case MEMop is
						when "10"=>
							RAM1_we <= '1';
							if (step = '0') then
								RAM1_data <= (others => 'Z');
							end if;
						when "11"=>
							RAM1_data <= data;
							if (step = '0') then
								RAM1_we <= '1';
							else
								RAM1_we <= '0';
							end if;
						when others=>
							RAM1_we <= '1';
                    		RAM1_data <= (others => '0');
					end case;
            end case;
		end if;
	end process;
	
end RTL;