----------------------------------------------------------------------------------
-- Company: Uergs
-- Engineer: Guilherme Lague, Marcio Jardim, Everton
-- 
-- Create Date: 17.10.2019 01:00:34
-- Design Name: 
-- Module Name: DataPath - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision: Trocar add por nop, nop == 0000
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.numeric_std.ALL;
library work;
use work.MicroMipsPkg.all;

entity DataPath is
    Port ( clk            : in std_logic;                     -- clock
           rst            : in std_logic;                     -- reset
           ir_enable      : in std_logic;                     -- habilitador do IR
           drm_enable     : in std_logic;                     -- habilitador do MDR
           arm_enable     : in std_logic;                     -- habilitador do MAR
           write_reg      : in std_logic;                     -- habilita escrita no BankRegister
           sel_mux_data   : in std_logic;                     -- seletor do mux de dados
           sel_mux_to_alu : in std_logic;                     -- seletor do mux de dado para ula
           sel_mux_to_mdr : in std_logic;                     -- seletor do mux de dado para o MDR
           jump           : in std_logic;                     -- seletor do mux de endereço
           pc_inc         : in std_logic;                     -- habilita contagem do pc
           pcr_enable     : in std_logic;                     -- habilitador do PCR
           alur_enable    : in std_logic;                     -- habilitador do ALUR
           ula_op         : in operation_code;                -- operador da ULA
           instruction    : in std_logic_vector(31 downto 0); -- instrução da InstructionMemory
           data_in        : in std_logic_vector(15 downto 0); -- dado da DataMemory
           zero           : out std_logic;                    -- flag de resultado zero na ula
           opcode         : out decoded_instruction;          -- Codigo da instrução
           address_im     : out std_logic_vector(7 downto 0); -- Endereo da InstructionMemory
           address_dm     : out std_logic_vector(7 downto 0); -- Endereço da DataMemory
           data_out       : out std_logic_vector(15 downto 0) -- Dado para a DataMemory
         );
end DataPath;

architecture Behavioral of DataPath is
    type registerr is array (0 to 3) of std_logic_vector(15 downto 0);
    signal R : registerr;
    
    signal pc_out          : std_logic_vector(7 downto 0);   -- saida do Program counter
    signal ir_out          : std_logic_vector(31 downto 0);  -- saida do Instruction register
    signal dr1_out         : std_logic_vector(15 downto 0);  -- saida 1 do bank register
    signal dr2_out         : std_logic_vector(15 downto 0);  -- saida 2 do bank register
    signal ula_out         : std_logic_vector(15 downto 0);  -- saida da ula
    signal alur_out        : std_logic_vector(15 downto 0);  -- saida do registrador da ula
    signal mux_data_out    : std_logic_vector(15 downto 0);  -- saida do mux de dado
    signal mux_addr_im_out : std_logic_vector(7 downto 0);   -- saida do mux de endereço da instruction memory
    signal mux_to_alu_out  : std_logic_vector(15 downto 0);  -- saida do mux para a entrada da ula
    signal mux_to_mdr_out  : std_logic_vector(15 downto 0);  -- saida do mux para a entrada do mdr
begin

-----------------------------------------------
-- IR - instruction register/ decoder
-----------------------------------------------
IR: process(clk)
begin
    if(rst = '1')then
        ir_out <= (others => '0');
    elsif (clk'event and clk = '1') then	
        if(ir_enable = '1') then
            ir_out <= instruction;
        end if;
    end if; 
end process IR;

opcode <= INOP   when ir_out(3 downto 0) = "0000" else
          IADD   when ir_out(3 downto 0) = "0001" else
          ISUB   when ir_out(3 downto 0) = "0010" else
          IOR    when ir_out(3 downto 0) = "0011" else
          IAND   when ir_out(3 downto 0) = "0100" else
          INOT   when ir_out(3 downto 0) = "0101" else
          ILOAD  when ir_out(3 downto 0) = "0110" else
          ISTORE when ir_out(3 downto 0) = "0111" else
          IJE    when ir_out(3 downto 0) = "1000" else
          IJUMP  when ir_out(3 downto 0) = "1001" else
          IADDST when ir_out(3 downto 0) = "1010" else
          ILDADD when ir_out(3 downto 0) = "1100" else
          IHALT  when ir_out(31 downto 0) = "11111111111111111111111111111111";
          
-----------------------------------------------
-- MUX to ALU
-----------------------------------------------
mux_to_alu_out <= data_in when sel_mux_to_alu = '1' else
                  dr1_out when sel_mux_to_alu = '0';

-----------------------------------------------
-- MUX to MDR
-----------------------------------------------
mux_to_mdr_out <= dr1_out when sel_mux_to_mdr = '1' else
                 ula_out when sel_mux_to_mdr = '0';         
          
-----------------------------------------------
-- MUX data
-----------------------------------------------
mux_data_out <= alur_out when sel_mux_data = '1' else
                data_in when sel_mux_data = '0';

-----------------------------------------------
-- Register bank
-----------------------------------------------          
BANKR: process(clk) 
begin
    if(rst = '1')then
		R <= (others => (others => '0'));
	elsif (clk'event and clk = '1') then
        if(write_reg = '1')then                          
            if(ir_out(5 downto 4) = "00")then
               R(0) <= mux_data_out; 
            elsif(ir_out(5 downto 4) = "01")then
               R(1) <= mux_data_out;
            elsif(ir_out(5 downto 4) = "10")then
               R(2) <= mux_data_out;
            elsif(ir_out(5 downto 4) = "11")then
               R(3) <= mux_data_out;
            end if;
        end if;
    end if;
end process BANKR;
    
dr1_out <=  R(0) when ir_out(5 downto 4) = "00" else
            R(1) when ir_out(5 downto 4) = "01" else
            R(2) when ir_out(5 downto 4) = "10" else
            R(3) when ir_out(5 downto 4) = "11";
            
dr2_out <=  R(0) when ir_out(7 downto 6) = "00" else
            R(1) when ir_out(7 downto 6) = "01" else
            R(2) when ir_out(7 downto 6) = "10" else
            R(3) when ir_out(7 downto 6) = "11";
      
-----------------------------------------------
-- MEMORY DATA REGISTER
-----------------------------------------------
MDR: process(clk)
begin
    if(rst = '1')then
        data_out <= (others => '0');	
    elsif (clk'event and clk = '1')then
        if(drm_enable = '1')then
            data_out <= mux_to_mdr_out;
        end if;
	end if;
end process MDR;

-----------------------------------------------
-- MEMORY ADRESS REGISTER 
-----------------------------------------------
MAR: process(clk)
begin
    if(rst = '1')then
        address_dm <= (others => '0');	
	elsif (clk'event and clk = '1')then
        if(arm_enable = '1')then
            address_dm <= ir_out(31 downto 24);
        end if;
	end if;
end process MAR;

-----------------------------------------------
-- ALU - 
----------------------------------------------- 
ula_out <= mux_to_alu_out + dr2_out when ula_op = OADD else
           mux_to_alu_out - dr2_out when ula_op = OSUB else
           mux_to_alu_out or dr2_out when ula_op = OOR else
           mux_to_alu_out and dr2_out when ula_op = OAND else 
           not mux_to_alu_out;

-----------------------------------------------
-- ALUR - ALU REGISTER
-----------------------------------------------
ALUR: process(clk)
begin
    if(rst = '1')then
        alur_out <= (others => '0');
    elsif (clk'event and clk = '1') then
        if(alur_enable = '1')then
            alur_out <= ula_out;
        end if;        
    end if;
end process ALUR;

zero <= '1' when alur_out = "0000000000000000" else '0';

-----------------------------------------------
-- PC - PROGRAM COUNTER
-----------------------------------------------
PC: process(clk)
begin
    if(rst = '1')then
        pc_out <= (others => '0');
    elsif (clk'event and clk = '1') then
        if(pc_inc = '1')then
            pc_out <= pc_out + 2;
        end if;        
    end if;
end process PC;

-----------------------------------------------
-- MUX jump
-----------------------------------------------
mux_addr_im_out <= pc_out when jump = '0' else 
                   ir_out(31 downto 24) when jump = '1';

-----------------------------------------------
-- PCR - PROGRAM COUNTER REGISTER
-----------------------------------------------
PCR: process(clk)
begin
    if(rst = '1')then
		address_im <= (others => '0');
	elsif (clk'event and clk = '1') then
        if(pcr_enable = '1')then
            address_im <= mux_addr_im_out;
        end if;
    end if;
end process PCR;

end Behavioral;
