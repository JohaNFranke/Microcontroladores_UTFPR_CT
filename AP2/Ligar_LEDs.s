	AREA    |.text|, CODE, READONLY, ALIGN=2

    EXPORT Ligar_LEDs
        
    IMPORT PortF_Output
	IMPORT PortN_Output
    IMPORT SysTick_Wait1ms
		
	IMPORT Passeio_0
	IMPORT Passeio_1
	IMPORT Passeio_2
	IMPORT Passeio_3
	IMPORT Passeio_4
	IMPORT Passeio_5
		
	IMPORT Contador_0
    IMPORT Contador_1
	IMPORT Contador_2
	IMPORT Contador_3
	IMPORT Contador_4
	IMPORT Contador_5
	IMPORT Contador_6
	IMPORT Contador_7
	IMPORT Contador_8
	IMPORT Contador_9
	IMPORT Contador_10
	IMPORT Contador_11
	IMPORT Contador_12
	IMPORT Contador_13
	IMPORT Contador_14
	IMPORT Contador_15
	
;################################################################################

Ligar_LEDs                   
    CMP     R5, #0
    BEQ     Modo_Passeio
	CMP		R5, #1
    BEQ     Modo_Contador
	BX		LR
	
Modo_Passeio
	CMP		R7, #0
	BEQ		Passeio_0
	CMP		R7, #1
	BEQ		Passeio_1
	CMP		R7, #2
	BEQ		Passeio_2
	CMP		R7, #3
	BEQ		Passeio_3
	CMP		R7, #4
	BEQ		Passeio_4
	CMP		R7, #5
	BEQ		Passeio_5
	BX		LR
	
Modo_Contador
	CMP		R8, #0
	BEQ		Contador_0
	CMP		R8, #1
	BEQ		Contador_1
	CMP		R8, #2
	BEQ		Contador_2
	CMP		R8, #3
	BEQ		Contador_3
	CMP		R8, #4
	BEQ		Contador_4
	CMP		R8, #5
	BEQ		Contador_5
	CMP		R8, #6
	BEQ		Contador_6
	CMP		R8, #7
	BEQ		Contador_7
	CMP		R8, #8
	BEQ		Contador_8
	CMP		R8, #9
	BEQ		Contador_9
	CMP		R8, #10
	BEQ		Contador_10
	CMP		R8, #11
	BEQ		Contador_11
	CMP		R8, #12
	BEQ		Contador_12
	CMP		R8, #13
	BEQ		Contador_13
	CMP		R8, #14
	BEQ		Contador_14
	CMP		R8, #15
	BEQ		Contador_15
	BX		LR
	
;################################################################################
	ALIGN                        ;Garante que o fim da seção está alinhada 
    END                          ;Fim do arquivo
