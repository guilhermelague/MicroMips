----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.10.2019 01:00:34
-- Design Name: 
-- Module Name: MicroMips - Behavioral
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
library work;
use work.MicroMipsPkg.all;

entity MicroMips is
    Port ( clk  : in std_logic;
           rst  : in std_logic;
           halt : out std_logic
         );
end MicroMips;

architecture Behavioral of MicroMips is
    
    signal ir_enable   : std_logic;
    signal drm_enable  : std_logic;
    signal arm_enable  : std_logic;
    signal write_reg   : std_logic;
    signal sel_mux_data: std_logic;
    
    signal sel_mux_to_alu: std_logic;
    signal sel_mux_to_mdr: std_logic;
    
    signal zero        : std_logic;
    signal jump        : std_logic;
    signal pc_inc      : std_logic;
    signal pcr_enable  : std_logic;
    signal alur_enable : std_logic;
    signal ula_op      : operation_code;
    signal mem_read    : std_logic;
    signal mem_write   : std_logic;
    signal opcode      : decoded_instruction;
    signal instruction : std_logic_vector(31 downto 0);
    
    signal addr_im : std_logic_vector(7 downto 0);
    signal addr_dm : std_logic_vector(7 downto 0);
    
    signal data_x : std_logic_vector(15 downto 0);
    signal data_y : std_logic_vector(15 downto 0);
    
begin
    -------------------------------------------------------
    -- instancia da control unit
    -------------------------------------------------------
    control_unit: ControlUnit
        port map(
            -- ControlUnit => mips
            clk          => clk,
            rst          => rst,
            halt         => halt,
            opcode       => opcode,
            ir_enable    => ir_enable,
            drm_enable   => drm_enable,
            arm_enable   => arm_enable,
            write_reg    => write_reg,
            sel_mux_data => sel_mux_data,
            
            sel_mux_to_alu => sel_mux_to_alu,
            sel_mux_to_mdr => sel_mux_to_mdr,
            
            jump         => jump,
            zero         => zero,
            pc_inc       => pc_inc,
            pcr_enable    => pcr_enable,
            alur_enable  => alur_enable,
            ula_op       => ula_op,
            mem_read     => mem_read,
            mem_write    => mem_write   
        );
    
    -------------------------------------------------------
    -- instancia do data_path
    -------------------------------------------------------        
    data_path: DataPath
        port map(
            -- DataPath => mips
            clk            => clk,
            rst            => rst,
            ir_enable      => ir_enable,  
            drm_enable     => drm_enable,
            arm_enable     => arm_enable,
            write_reg      => write_reg,
            sel_mux_data   => sel_mux_data,
            
            sel_mux_to_alu => sel_mux_to_alu,
            sel_mux_to_mdr => sel_mux_to_mdr,
            
            jump           => jump,
            zero           => zero,
            pc_inc         => pc_inc,
            pcr_enable     => pcr_enable,
            alur_enable    => alur_enable,
            ula_op         => ula_op,
            instruction    => instruction ,
            opcode         => opcode,
            address_im     => addr_im,
            address_dm     => addr_dm,
            data_in        => data_y,
            data_out       => data_x    
        );
    -------------------------------------------------------
    -- instancia da InstructionMemory
    -------------------------------------------------------
    instruction_memory: InstructionMemory
        port map(
            -- InstructionMemory => mips
            clk         => clk,
            rst         => rst,
            address     => addr_im,
            instruction => instruction 
        );
    
    -------------------------------------------------------
    -- instancia da DataMemory
    -------------------------------------------------------
    data_memory: DataMemory
        port map(
            -- DataMemory => mips
            clk        => clk,
            rst        => rst,
            mem_read   => mem_read,
            mem_write  => mem_write,
            address    => addr_dm,
            data_in    => data_x,
            data_out   => data_y
        );

end Behavioral;
