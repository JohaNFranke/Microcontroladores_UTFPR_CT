	AREA    |.text|, CODE, READONLY, ALIGN=2

    EXPORT Contador_0
    EXPORT Contador_1
	EXPORT Contador_2
	EXPORT Contador_3
	EXPORT Contador_4
	EXPORT Contador_5
	EXPORT Contador_6
	EXPORT Contador_7
	EXPORT Contador_8
	EXPORT Contador_9
	EXPORT Contador_10
	EXPORT Contador_11
	EXPORT Contador_12
	EXPORT Contador_13
	EXPORT Contador_14
	EXPORT Contador_15
	 
    IMPORT PortF_Output
	IMPORT PortN_Output
    IMPORT SysTick_Wait1ms
;################################################################################

Contador_0						;0000
	MOV		R8, #1
	MOV 	R0, #2_0					
	PUSH	{LR}
	BL		PortF_Output
	POP		{LR}
	PUSH	{LR}
	BL		PortN_Output
	POP		{LR}
	BX		LR
	
Contador_1						;0001
	MOV		R8, #2
	MOV 	R0, #2_1					
	PUSH	{LR}
	BL		PortF_Output
	POP		{LR}
	BX		LR
	
Contador_2						;0010
	MOV		R8, #3
	MOV 	R0, #2_10000					
	PUSH	{LR}
	BL		PortF_Output
	POP		{LR}
	BX		LR
	
Contador_3						;0011
	MOV		R8, #4
	MOV 	R0, #2_10001					
	PUSH	{LR}
	BL		PortF_Output
	POP		{LR}
	BX		LR
	
Contador_4						;0100
	MOV		R8, #5
	MOV 	R0, #2_0					
	PUSH	{LR}
	BL		PortF_Output
	POP		{LR}
	MOV		R0, #2_1
	PUSH	{LR}
	BL		PortN_Output
	POP		{LR}
	BX		LR
	
Contador_5						;0101
	MOV		R8, #6
	MOV 	R0, #2_1					
	PUSH	{LR}
	BL		PortF_Output
	POP		{LR}
	BX		LR
	
Contador_6						;0110
	MOV		R8, #7
	MOV 	R0, #2_10000					
	PUSH	{LR}
	BL		PortF_Output
	POP		{LR}
	BX		LR
	
Contador_7						;0111
	MOV		R8, #8
	MOV 	R0, #2_10001					
	PUSH	{LR}
	BL		PortF_Output
	POP		{LR}
	BX		LR
	
Contador_8						;1000
	MOV		R8, #9
	MOV 	R0, #2_0					
	PUSH	{LR}
	BL		PortF_Output
	POP		{LR}
	MOV		R0, #2_10
	PUSH	{LR}
	BL		PortN_Output
	POP		{LR}
	BX		LR
		
Contador_9						;1001
	MOV		R8, #10
	MOV 	R0, #2_1					
	PUSH	{LR}
	BL		PortF_Output
	POP		{LR}
	BX		LR
	
Contador_10						;1010
	MOV		R8, #11
	MOV 	R0, #2_10000					
	PUSH	{LR}
	BL		PortF_Output
	POP		{LR}
	BX		LR
	
Contador_11						;1011
	MOV		R8, #12
	MOV 	R0, #2_10001					
	PUSH	{LR}
	BL		PortF_Output
	POP		{LR}
	BX		LR
	
Contador_12						;1100
	MOV		R8, #13
	MOV 	R0, #2_0					
	PUSH	{LR}
	BL		PortF_Output
	POP		{LR}
	MOV		R0, #2_11
	PUSH	{LR}
	BL		PortN_Output
	POP		{LR}
	BX		LR
	
Contador_13						;1101
	MOV		R8, #14
	MOV 	R0, #2_1					
	PUSH	{LR}
	BL		PortF_Output
	POP		{LR}
	BX		LR
	
Contador_14						;1110
	MOV		R8, #15
	MOV 	R0, #2_10000					
	PUSH	{LR}
	BL		PortF_Output
	POP		{LR}
	BX		LR
	
Contador_15						;1111
	MOV		R8, #0
	MOV 	R0, #2_10001					
	PUSH	{LR}
	BL		PortF_Output
	POP		{LR}
	BX		LR

;################################################################################
	ALIGN                        ;Garante que o fim da seção está alinhada 
    END                          ;Fim do arquivo