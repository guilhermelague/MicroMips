# MicroMips
 Descrição em VHDL de um processador baseado no Mips.


## Especificações

* ### Instruções

    |N  |Instruction|Opcode |                       |             |
    |---|-----------|-------|-----------------------|-------------|
    |1	| NOP	    | 0000	| No operation	        |     -       |
    |2	| ADD	    | 0001	| ADD S1, S2	        | S1 = S1 + S2| 
    |3	| SUB	    | 0010	| SUB S1, S2	        | S1 = S1 - S2| 
    |4	| OR	    | 0011	| OR S1, S2	            | S1 = S1 || S2| 
    |5	| AND	    | 0100	| AND S1, S2	        | S1 = S1 && S2              | 
    |6	| NOT	    | 0101	| NOT S1, S2	        | S1 = -S2                   |
    |7	| LOAD	    | 0110	| LW S1, address        | S1 = data in (address)|
    |8	| STORE	    | 0111	| SW S1, address        | (address) = data in S1|
    |9	| JE	    | 1000	| JE address	        | GO TO address if zero = ‘1’|
    |10	| JUMP	    | 1001	| JUMP address	        | GO TO address      |
    |11	| ADDST	    | 1010	| ADDST S1, S2, address	| (address) = S1 + S2|
    |12	|   	    | 1011	| 	                    |                    |
    |13	| LDADD	    | 1100	| LDADD S1, S2, address	| S1 = S2 + (address)|
    |14	|   	    | 1101	|                   	|                            |
    |15	| 	        | 1110	|                    	|                            |
    |16	| HALT	    | 1111	| Stop processor	    | -                          |



* ### Data path
    * Instruções de 32 bits
    * Memórias
        * Memória de instruções
            * 8 bits de endereço
            * 16 bits de palavra de dados
        * Memória de dados
            * 8 bits de endereço
            * 16 bits de palavra de dados
    * Banco de registradores
        * 4 registradores
        * 2 bits para endereçar os registradores
    * Unidade Logica e aritmetica
    * Resgistrador de dados da ula
    * Registrador de instruções
    * Registrador de endereços
    * Registrador de dados

* ### Control unit

    * Maquina de estados
        * 22 estados

    * Estados da maquina:
        * Inicio:
            * START
        * Busca:
            * SBUSCA1, SBUSCA2, SBUSCA3
        * Decodifica:
            * DECOD
        * Load:
            * SLOAD1, SLOAD2, SLOAD3
        * Store:
            * SSTORE1, SSTORE2
        * Add, Sub, And, Or, Not:
            * SULA1, SULA2
        * Addst:
            * SADDST1, SADDST2
        * Ldadd:
            * SLDADD1, SLDADD2, SLDADD3, SLDADD4
        * Jump Equal:
            * SJE
        * Jump:
            * SJUMP
        * Nop:
            * SNOP
        * Halt:
            * SHALT
* ### Pode ser gravado na Nexys 4 DDR

         



 