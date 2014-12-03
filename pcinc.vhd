----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:56:38 12/01/2014 
-- Design Name: 
-- Module Name:    PC_INC - RTL 
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

entity PC_INC is
    Port ( PC : in  STD_LOGIC_VECTOR (15 downto 0);
           PC_next : out  STD_LOGIC_VECTOR (15 downto 0));
end PC_INC;

architecture RTL of PC_INC is

begin
	PC_next <= STD_LOGIC_VECTOR(UNSIGNED(PC) + 1);
end RTL;

