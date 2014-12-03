--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:48:37 12/02/2014
-- Design Name:   
-- Module Name:   C:/COA/cpu301/test_regheap.vhd
-- Project Name:  cpu301
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: REG_HEAP
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
--USE ieee.numeric_std.ALL;
 
ENTITY test_regheap IS
END test_regheap;
 
ARCHITECTURE behavior OF test_regheap IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT REG_HEAP
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         Rx : IN  std_logic_vector(2 downto 0);
         Ry : IN  std_logic_vector(2 downto 0);
		 Rw_en : IN  std_logic;
         Rw : IN  std_logic_vector(2 downto 0);
         Rw_d : IN  std_logic_vector(15 downto 0);
         Rx_q : OUT  std_logic_vector(15 downto 0);
         Ry_q : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';
   signal Rw_en : std_logic := '0';
   signal Rx : std_logic_vector(2 downto 0) := (others => '0');
   signal Ry : std_logic_vector(2 downto 0) := (others => '0');
   signal Rw : std_logic_vector(2 downto 0) := (others => '0');
   signal Rw_d : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal Rx_q : std_logic_vector(15 downto 0);
   signal Ry_q : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: REG_HEAP PORT MAP (
          Clk => Clk,
          Rst => Rst,
          Rx => Rx,
          Ry => Ry,
          Rw => Rw,
		  Rw_en => Rw_en,
          Rw_d => Rw_d,
          Rx_q => Rx_q,
          Ry_q => Ry_q
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
	  Rst <= '0';
      wait for 110 ns;	
	  Rst <= '1';
      wait for Clk_period*10;
	  --wait for Clk_period / 2;
	  Rw_en <= '1';
	
	  wait for Clk_period - 6 ns;
	  Rx <= "000";
	  Ry <= "000";
	  Rw <= "000";
	  Rw_d <= "1111111111111111";
	  wait for Clk_period;
	  Rx <= "000";
	  Ry <= "010";
	  Rw <= "000";
	  Rw_d <= "0000000000000000";
	  wait for Clk_period;
	  Rx <= "000";
	  Ry <= "010";
	  Rw <= "000";
	  Rw_d <= "1111111111111111";
	  wait for Clk_period;
	  Rx <= "000";
	  Ry <= "001";
	  Rw <= "001";
	  Rw_d <= "1110001110001110";
	  wait for Clk_period;
	  
	
      -- insert stimulus here 

      wait;
   end process;

END;
