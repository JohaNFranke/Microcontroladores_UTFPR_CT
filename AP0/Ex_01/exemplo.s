; Exemplo.s
; Desenvolvido para a placa EK-TM4C1294XL
; Esquele de um novo Projeto para Keil
; Prof. Guilherme de S. Peron	- 12/03/2018
; Prof. Marcos E. P. Monteiro	- 12/03/2018
; Prof. DaLuz           		- 25/02/2022

;################################################################################
; Declara��es EQU
; <NOME>	EQU <VALOR>
;################################################################################
	AREA    |.text|, CODE, READONLY, ALIGN=2
	THUMB
; Se alguma fun��o do arquivo for chamada em outro arquivo	
    EXPORT Start					; Permite chamar a fun��o Start a partir de 
									; outro arquivo. No caso startup.s
								
; Se chamar alguma fun��o externa	
;	IMPORT <func>          			; Permite chamar dentro deste arquivo uma 
									; fun��o <func>

;################################################################################
; Fun��o main()
Start								;Label Start ... void main(void)
; Comece o c�digo aqui <=========================================================

	MOV R0, #65				;Salvar no registrador R0 o valor 65 decimal
	
	MOV R1, #0x1B00			;Salvar no registrador R1 o valor 0x1B00.1B00
	MOVT R1, #0x1B00		
	
	MOV R2, #0x5678			;Salvar no registrador R2 o valor 0x1234.5678
	MOVT R2, #0x1234
	
	MOV R3, #0x0040			;Guardar na posi��o de mem�ria 0x2000.0040 o valor de R0
	MOVT R3, #0x2000		
	STR R0, [R3]
	
	MOV R4, #0x0044			;Guardar na posi��o de mem�ria 0x2000.0044 o valor de R1
	MOVT R4, #0x2000		
	STR R1, [R4]
	
	MOV R5, #0x0048			;Guardar na posi��o de mem�ria 0x2000.0048 o valor de R2
	MOVT R5, #0x2000		
	STR R2, [R5]					
	
	MOV R6, #0x004C			;Guardar na posi��o de mem�ria 0x2000.004C o n�mero 0xF0001
	MOVT R6, #0x2000
	MOV R7, #0x0001
	MOVT R7, #0xF
	STR R7, [R6]
	
	MOV R8, #0x0046			;Guardar na posi��o de mem�ria 0x2000.0046 o byte 0xCD, sem sobrescrever os outros bytes da WORD
	MOVT R8, #0x2000
	MOV R9, #0xCD
	STRB R9, [R8]
	
	MOV R10, #0x0040		;Ler o conte�do da mem�ria cuja posi��o 0x2000.0040 e guardar no R7
	MOVT R10, #0x2000
	LDR R7, [R10]

	MOV R11, #0x0048		;Ler o conte�do da mem�ria cuja posi��o 0x2000.0048 o guardar R8
	MOVT R11, #0x2000
	LDR R8, [R11]
	
	MOV R9, R7				;Copiar para o R9 o conte�do de R7

; Final do c�digo aqui <=========================================================
    NOP
    ALIGN                       	;garante que o fim da se��o est� alinhada 
    END                         	;fim do arquivo