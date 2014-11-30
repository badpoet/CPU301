--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   03:05:20 12/01/2014
-- Design Name:   
-- Module Name:   C:/COA/cpu301/test_top.vhd
-- Project Name:  cpu301
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPU_TOP
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY test_top IS
END test_top;
 
ARCHITECTURE behavior OF test_top IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU_TOP
    PORT(
         Clk_in : IN  std_logic;
         Rst : IN  std_logic;
         RAM1_we : OUT  std_logic;
         RAM1_oe : OUT  std_logic;
         RAM1_en : OUT  std_logic;
         RAM1_addr : OUT  std_logic_vector(17 downto 0);
         RAM1_data : INOUT  std_logic_vector(15 downto 0);
         RAM2_we : OUT  std_logic;
         RAM2_oe : OUT  std_logic;
         RAM2_en : OUT  std_logic;
         RAM2_addr : OUT  std_logic_vector(17 downto 0);
         RAM2_data : INOUT  std_logic_vector(15 downto 0);
         LED : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk_in : std_logic := '0';
   signal Rst : std_logic := '0';

	--BiDirs
   signal RAM1_data : std_logic_vector(15 downto 0);
   signal RAM2_data : std_logic_vector(15 downto 0);

 	--Outputs
   signal RAM1_we : std_logic;
   signal RAM1_oe : std_logic;
   signal RAM1_en : std_logic;
   signal RAM1_addr : std_logic_vector(17 downto 0);
   signal RAM2_we : std_logic;
   signal RAM2_oe : std_logic;
   signal RAM2_en : std_logic;
   signal RAM2_addr : std_logic_vector(17 downto 0);
   signal LED : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant Clk_in_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU_TOP PORT MAP (
          Clk_in => Clk_in,
          Rst => Rst,
          RAM1_we => RAM1_we,
          RAM1_oe => RAM1_oe,
          RAM1_en => RAM1_en,
          RAM1_addr => RAM1_addr,
          RAM1_data => RAM1_data,
          RAM2_we => RAM2_we,
          RAM2_oe => RAM2_oe,
          RAM2_en => RAM2_en,
          RAM2_addr => RAM2_addr,
          RAM2_data => RAM2_data,
          LED => LED
        );

   -- Clock process definitions
   Clk_in_process :process
   begin
		Clk_in <= '0';
		wait for Clk_in_period/2;
		Clk_in <= '1';
		wait for Clk_in_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
	  Rst <= '0';
      wait for 100 ns;	
	  Rst <= '1';
      wait for Clk_in_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
