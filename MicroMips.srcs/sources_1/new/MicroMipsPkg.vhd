----------------------------------------------------------------------------------
-- Company: UERGS
-- Engineer: Guilherme Lague, Marcio Jardim, Everton 
-- 
-- Create Date: 17.10.2019 01:05:56
-- Design Name: 
-- Module Name: MicroMipsPkg - Behavioral
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package MicroMipsPkg is

  	type operation_code is (OADD, OSUB, OAND, OOR, ONOT); -- operações da ula
  	type decoded_instruction is (IADD, ISUB, IOR, IAND, INOT, IADDST, ILDADD, ILOAD, ISTORE, IJE, IJUMP, INOP, IHALT); -- instruções decodificadas
  	
	-------------------------------------------------
	-- Processador
	-------------------------------------------------
	component MicroMips
		port (
			clk  : in  std_logic;
			rst  : in  std_logic;
			halt : out std_logic
		);
	end component;

	-------------------------------------------------
	-- Unidade de controle
	-------------------------------------------------
	component ControlUnit
        port(
            clk            : in std_logic;
            rst            : in std_logic;
            halt           : out std_logic;
            zero           : in std_logic;
            opcode         : in decoded_instruction;
            ir_enable      : out std_logic;
            drm_enable     : out std_logic;
            arm_enable     : out std_logic;
            write_reg      : out std_logic;
            sel_mux_data   : out std_logic;
            sel_mux_to_alu : out std_logic;
            sel_mux_to_mdr : out std_logic;
            jump           : out std_logic;
            pc_inc         : out std_logic;
            pcr_enable     : out std_logic;
            alur_enable    : out std_logic;
            ula_op         : out operation_code;
            mem_read       : out std_logic;
            mem_write      : out std_logic
		);
	end component;

	-------------------------------------------------
	-- Unidade operativa
	-------------------------------------------------
    component DataPath
        port(
            clk            : in std_logic;
            rst            : in std_logic;
            ir_enable      : in std_logic;
            drm_enable     : in std_logic;
            arm_enable     : in std_logic;
            write_reg      : in std_logic;
            sel_mux_data   : in std_logic;
            sel_mux_to_alu : in std_logic;
            sel_mux_to_mdr : in std_logic;
            jump           : in std_logic;
            pc_inc         : in std_logic;
            pcr_enable     : in std_logic;
            alur_enable    : in std_logic;
            ula_op         : in operation_code;
            instruction    : in std_logic_vector(31 downto 0);
            data_in        : in std_logic_vector(15 downto 0);
            zero           : out std_logic;
            opcode         : out decoded_instruction;
            address_im     : out std_logic_vector(7 downto 0);
            address_dm     : out std_logic_vector(7 downto 0);
            data_out       : out std_logic_vector(15 downto 0)
		);
	end component;
	
	-------------------------------------------------
	-- Memória de dados
	-------------------------------------------------
	component DataMemory
        port(
            clk        : in std_logic;
            rst        : in std_logic;
            mem_read   : in std_logic;
            mem_write  : in std_logic;
            address    : in STD_LOGIC_VECTOR (7 downto 0);
            data_in    : in STD_LOGIC_VECTOR (15 downto 0);
            data_out   : out STD_LOGIC_VECTOR (15 downto 0)
		);
	end component;
	
	-------------------------------------------------
	-- Memória de instruções
	-------------------------------------------------
	component InstructionMemory
		port(
            clk     : in std_logic;
            rst     : in std_logic;
            address : in std_logic_vector(7 downto 0); 
            instruction : out std_logic_vector(31 downto 0)
		);
	end component;
end MicroMipsPkg;

package body MicroMipsPkg is
end MicroMipsPkg;