----------------------------------------------------------------------------------
-- Company: Uergs
-- Engineer: Guilherme Lague, Marcio Jardim, Everton
-- 
-- Create Date: 17.10.2019 01:00:34
-- Design Name: 
-- Module Name: ControlUnit - Behavioral
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

entity ControlUnit is
    Port ( clk            : in std_logic;             -- clock                           
           rst            : in std_logic;             -- reset                           
           halt           : out STD_LOGIC;            -- sinal de parada para o testbench              
           opcode         : in decoded_instruction;   -- Codigo da instru��o              
           zero           : in std_logic;             -- flag de resultado zero na ula              
           ir_enable      : out std_logic;            -- habilitador do IR              
           drm_enable     : out std_logic;            -- habilitador do MDR                               
           arm_enable     : out std_logic;            -- habilitador do MAR
           write_reg      : out std_logic;            -- habilita escrita no registrador        
           sel_mux_data   : out std_logic;            -- seletor do mux de dados
           sel_mux_to_alu : out std_logic;
           sel_mux_to_mdr : out std_logic;          
           jump           : out std_logic;            -- seletor do mux de endere�o          
           pc_inc         : out std_logic;            -- habilita contagem do pc                
           pcr_enable     : out std_logic;            -- habilitador do PCR   
           alur_enable    : out std_logic;            -- habilitador do ALUR              
           ula_op         : out operation_code;       -- operador da ULA                                
           mem_read       : out std_logic;            -- habilita leitura da DataMemory           
           mem_write      : out std_logic             -- habilita escrita da DataMemory   
         );                                              
end ControlUnit;          

architecture Behavioral of ControlUnit is
    type state is (START, SBUSCA1, SBUSCA2, SBUSCA3, SDECOD, SLOAD1, SLOAD2, SLOAD3, SSTORE1,SSTORE2, SULA1, SULA2, SJE, SJUMP, SNOP, SADDST1, SADDST2, SLDADD1, SLDADD2, SLDADD3, SLDADD4, SHALT); 
	signal estado_atual: state;
begin

-----------------------------------------------------------
------ Troca estados da maquina
-----------------------------------------------------------
troca_estado: process(clk)
begin
    if (rst = '1') then
        estado_atual <= START;
    elsif (clk'event and clk='1') then
        case estado_atual is
            when START => 
                estado_atual <= SDECOD;
            when SBUSCA1 =>
            	estado_atual <= SBUSCA2;
            when SBUSCA2 =>
            	estado_atual <= SBUSCA3;
            when SBUSCA3 =>
            	estado_atual <= SDECOD;           
            when SDECOD =>
                if(opcode = IADD or opcode = ISUB or opcode = IAND or opcode = IOR or opcode = INOT)then
                    estado_atual <= SULA1;
                elsif(opcode = ILOAD)then
                    estado_atual <= SLOAD1;
                elsif(opcode = ISTORE)then
                    estado_atual <= SSTORE1;
                elsif(opcode = IJE)then
                    estado_atual <= SJE;
                elsif(opcode = IJUMP)then
                    estado_atual <= SJUMP;
                elsif(opcode = INOP)then
                    estado_atual <= SNOP;
                elsif(opcode = IADDST)then
                    estado_atual <= SADDST1;
                elsif(opcode = ILDADD)then
                    estado_atual <= SLDADD1;
                elsif(opcode = IHALT)then
                    estado_atual <= SHALT;
                end if;
            when SLOAD1 =>
                estado_atual <= SLOAD2;
            when SLOAD2 =>
                estado_atual <= SLOAD3;
            when SLOAD3 =>
                estado_atual <= SBUSCA1;
            when SSTORE1 =>
                estado_atual <= SSTORE2;
            when SSTORE2 =>
                estado_atual <= SBUSCA1;
            when SULA1 =>
                estado_atual <= SULA2;
            when SULA2 =>
                estado_atual <= SBUSCA1;
            when SJUMP =>
                estado_atual <= SBUSCA2;
            when SJE =>
                if(zero = '1')then
                    estado_atual <= SBUSCA2;
                else 
                    estado_atual <= SBUSCA1;
                end if;
            when SADDST1 =>
                estado_atual <= SADDST2;
            when SADDST2 =>
                estado_atual <= SBUSCA1;
            when SLDADD1 =>
                estado_atual <= SLDADD2;
            when SLDADD2 =>
                estado_atual <= SLDADD3;
            when SLDADD3 =>
                estado_atual <= SLDADD4;
            when SLDADD4 =>
                estado_atual <= SBUSCA1;
            when SNOP =>
                estado_atual <= SBUSCA1;
            when SHALT =>
                estado_atual <= SHALT;
            when others => 
                estado_atual <= START;
      end case;
   end if;
end process troca_estado;

-----------------------------------------------------------
------ Estados da maquina
-----------------------------------------------------------
state_machine: process(estado_atual)
begin
    case estado_atual is
        ------------------------------------------------------------------------------------------
        -- STATE START
        ------------------------------------------------------------------------------------------
        when START =>
            halt         <= '0';
            ir_enable    <= '1';
            drm_enable   <= '0';
            arm_enable   <= '0';
            write_reg    <= '0';
            sel_mux_data <= '0';
            sel_mux_to_alu <= '0';
            sel_mux_to_mdr <= '1';
            jump         <= '0';
            pc_inc       <= '0';
            pcr_enable   <= '0';
            ula_op       <= OADD;
            alur_enable  <= '0';
            mem_read     <= '0';
            mem_write    <= '0';
        ------------------------------------------------------------------------------------------
        -- STATE SBUSCA2
        ------------------------------------------------------------------------------------------
        when SBUSCA2 =>
            pc_inc <= '0';
            pcr_enable <= '1';                                                              
        ------------------------------------------------------------------------------------------
        -- STATE SBUSCA3
        ------------------------------------------------------------------------------------------
        when SBUSCA3 =>
            ir_enable <= '1';
            pc_inc <= '0';
            pcr_enable <= '0';
        ------------------------------------------------------------------------------------------
        -- STATE DECOD
        ------------------------------------------------------------------------------------------
        when SDECOD => 
            ir_enable <= '0';
            pc_inc <= '0';
            jump <= '0';
            pcr_enable <= '0';
        ------------------------------------------------------------------------------------------
        -- STATE SLOAD1
        ------------------------------------------------------------------------------------------
        when SLOAD1 => 
           arm_enable <= '1';
        ------------------------------------------------------------------------------------------
        -- STATE SLOAD2
        ------------------------------------------------------------------------------------------
        when SLOAD2 =>
           arm_enable <= '0'; 
           mem_read <= '1';
        ------------------------------------------------------------------------------------------
        -- STATE SLOAD3
        ------------------------------------------------------------------------------------------
        when SLOAD3 => 
           mem_read <= '0';
           sel_mux_data <= '0';
           write_reg <= '1';
        ------------------------------------------------------------------------------------------
        -- STATE SSTORE1
        ------------------------------------------------------------------------------------------
        when SSTORE1 =>
            arm_enable <= '1';
            drm_enable <= '1';
        ------------------------------------------------------------------------------------------
        -- STATE SSTORE2
        ------------------------------------------------------------------------------------------
        when SSTORE2 => 
            arm_enable <= '0';
            drm_enable <= '0';
            mem_write <= '1';
        ------------------------------------------------------------------------------------------
        -- STATE SULA1
        ------------------------------------------------------------------------------------------
        when SULA1 => 
            if(opcode = IADD)then
                ula_op <= OADD;
            elsif(opcode = ISUB)then
                ula_op <= OSUB;
            elsif(opcode = IAND)then
                ula_op <= OAND;
            elsif(opcode = IOR)then
                ula_op <= OOR;
            elsif(opcode = INOT)then
                ula_op <= ONOT;
            end if;
            alur_enable <= '1';
        ------------------------------------------------------------------------------------------
        -- STATE SULA2
        ------------------------------------------------------------------------------------------
        when SULA2 =>
            alur_enable <= '0';
            sel_mux_data <= '1';
            write_reg <= '1';
        ------------------------------------------------------------------------------------------
        -- STATE SJE
        ------------------------------------------------------------------------------------------
        when SJE =>
            if(zero = '1')then
                jump <= '1';
                pcr_enable <= '1';
            else 
                jump <= '0';
            end if;
        ------------------------------------------------------------------------------------------
        -- STATE SJUMP
        ------------------------------------------------------------------------------------------
        when SJUMP =>
            jump <= '1';
            pcr_enable <= '1';
        ------------------------------------------------------------------------------------------
        -- STATE SNOP
        ------------------------------------------------------------------------------------------
        when SNOP =>
        ------------------------------------------------------------------------------------------
        -- STATE SADDST1
        ------------------------------------------------------------------------------------------
        when SADDST1 =>
            ula_op <= OADD;
            alur_enable <= '1';
            sel_mux_to_mdr <= '0';
            arm_enable <= '1';
            drm_enable <= '1';
        ------------------------------------------------------------------------------------------
        -- STATE SADDST2
        ------------------------------------------------------------------------------------------
        when SADDST2 =>
            sel_mux_to_mdr <= '1';
            arm_enable <= '0';
            drm_enable <= '0';
            mem_write <= '1'; 
        ------------------------------------------------------------------------------------------
        -- STATE SLDADD1
        ------------------------------------------------------------------------------------------
        when SLDADD1 =>
            arm_enable <= '1';
        ------------------------------------------------------------------------------------------
        -- STATE SLDADD2
        ------------------------------------------------------------------------------------------
        when SLDADD2 =>
            arm_enable <= '0';
            mem_read <= '1';
        ------------------------------------------------------------------------------------------
        -- STATE SLDADD3
        ------------------------------------------------------------------------------------------
        when SLDADD3 =>
            sel_mux_to_alu <= '1';
            mem_read <= '0';
            alur_enable <= '1';
            ula_op <= OADD;
        ------------------------------------------------------------------------------------------
        -- STATE SLDADD4
        ------------------------------------------------------------------------------------------
        when SLDADD4 =>
            alur_enable <= '0';
            sel_mux_data <= '1';
            write_reg <= '1';    
        ------------------------------------------------------------------------------------------
        -- STATE SHALT
        ------------------------------------------------------------------------------------------
        when SHALT =>
            halt <= '1';
        ------------------------------------------------------------------------------------------
        -- STATE BUSCA1
        ------------------------------------------------------------------------------------------
        when others =>
            sel_mux_to_alu <= '0';
            pc_inc <= '1';
            pcr_enable <= '0';
            jump <= '0';
            write_reg <= '0';
            sel_mux_data <= '0';
            mem_write <= '0';
    end case;
end process state_machine;

end Behavioral;