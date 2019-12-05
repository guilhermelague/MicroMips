----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Guilherme Lague
-- 
-- Create Date: 15.08.2017 18:59:38
-- Design Name: 
-- Module Name: TestBench.vhd
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.MicroMipsPkg.all;

entity TestBench is
--  Port ( );
end TestBench;

architecture rtl of TestBench is
    
    signal clk       : std_logic := '0';
    signal rst       : std_logic := '1';
    signal halt      : std_logic := '0';
	
	-- Clock period definitions
	constant clk_period  : time := 10 ns;
	
begin
-------------------------------------------------------
-- Instancia da Unit Under Test (UUT)
-------------------------------------------------------
uut : MicroMips 
	port map (
		-- MicroMips ||    test_bench
		clk          => clk,
		rst          => rst,
		halt         => halt
	);

-------------------------------------------------------
-- Clock process definitions
-------------------------------------------------------
clk_process : process
begin
	clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

-------------------------------------------------------
-- Stimulus process 
-------------------------------------------------------
testbench_process_main : process
begin
	wait for 500ns;
	rst <= '0';
	-- fazer uma condição para parar a simulação em caso de halt
end process;

end rtl;
