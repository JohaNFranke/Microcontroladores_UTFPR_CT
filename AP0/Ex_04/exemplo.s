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

	MOV R0, #101			;a) Adicionar os n�meros 101 e 253 atualizando os flags;
	MOV R1, #253
	ADDS R2, R0, R1
	
	MOV R0, #1500			;b) Adicionar os n�meros 1500 e 40543 sem atualizar os flags;
	MOV R1, #40543
	ADD R2, R0, R1
							
	MOV R0, #340			;c) Subtrair o n�mero 340 pelo n�mero 123 atualizando os flags;
	MOV R1, #123
	SUBS R2, R0, R1
	
	MOV R0, #1000			;d) Subtrair o n�mero 1000 pelo n�mero 2000 atualizando os flags;
	MOV R1, #2000
	SUBS R2, R0, R1
	
	MOV R0, #54378			;e) Multiplicar o n�mero 54378 por 4; (Essa opera��o � semelhante a
	MOV R1, #4				;qual?)
	MUL R2, R0, R1
	
	MOV R0, #0x3344			;f) Multiplicar com o resultado em 64 bits os n�meros 0x1122.3344 e
	MOVT R0, #0x1122		;0x4433.2211;
	MOV R1, #0x2211
	MOVT R1, #0x4433
	UMULL R2, R3, R0, R1

	MOV R0, #0x7560			;g) Dividir o n�mero 0xFFFF.7560 por 1000 com sinal;
	MOVT R0, #0xFFFF
	MOV R1, #1000
	SDIV R2, R0, R1
	
	UDIV R2, R0, R1			;h) Dividir o n�mero 0xFFFF.7560 por 1000 sem sinal;


; Final do c�digo aqui <=========================================================
    NOP
    ALIGN                       	;garante que o fim da se��o est� alinhada 
    END                         	;fim do arquivo