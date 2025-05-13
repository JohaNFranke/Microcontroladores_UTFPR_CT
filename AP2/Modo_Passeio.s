	AREA    |.text|, CODE, READONLY, ALIGN=2

	EXPORT Passeio_0
	EXPORT Passeio_1
	EXPORT Passeio_2
	EXPORT Passeio_3
	EXPORT Passeio_4
	EXPORT Passeio_5
        
    IMPORT PortF_Output
	IMPORT PortN_Output
    IMPORT SysTick_Wait1ms
;################################################################################

Passeio_0
	MOV		R0, #2_10				;led PN1(1)
	MOV		R7, #1
	PUSH	{LR}
	BL		PortN_Output
	POP		{LR}
	BX		LR
	
Passeio_1
	MOV		R0, #2_01				;led PN0(2)
	MOV		R7, #2
	PUSH	{LR}
	BL		PortN_Output
	POP		{LR}
	BX		LR

Passeio_2
	MOV		R0, #2_00			    ;led PN0(-1)
	MOV		R7, #3
	PUSH	{LR}
	BL		PortN_Output
	POP		{LR}
	MOV		R0, #2_10000			;led PF4(3)
	PUSH	{LR}
	BL		PortF_Output
	POP		{LR}		
	BX		LR
	
Passeio_3
	MOV		R0, #2_00001			;led PF0(4)
	MOV		R7, #4
	PUSH	{LR}
	BL		PortF_Output
	POP		{LR}
	BX		LR
	
Passeio_4
	MOV		R0, #2_10000			;led PF4(3)
	MOV		R7, #5
	PUSH	{LR}
	BL		PortF_Output
	POP		{LR}
	BX		LR
	
Passeio_5
	MOV		R0, #2_00000			;led PF4(-3)
	MOV		R7, #0
	PUSH	{LR}
	BL		PortF_Output
	POP		{LR}
	MOV		R0, #2_01				;led PN0(2)
	PUSH	{LR}
	BL		PortN_Output
	POP		{LR}
	BX		LR

;################################################################################
	ALIGN                        ;Garante que o fim da seção está alinhada 
    END                          ;Fim do arquivo