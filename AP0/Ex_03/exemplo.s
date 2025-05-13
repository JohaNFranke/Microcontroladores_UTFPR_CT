; Exemplo.s
; Desenvolvido para a placa EK-TM4C1294XL
; Esquele de um novo Projeto para Keil
; Prof. Guilherme de S. Peron	- 12/03/2018
; Prof. Marcos E. P. Monteiro	- 12/03/2018
; Prof. DaLuz           		- 25/02/2022

;################################################################################
; Declarações EQU
; <NOME>	EQU <VALOR>
;################################################################################
	AREA    |.text|, CODE, READONLY, ALIGN=2
	THUMB
; Se alguma função do arquivo for chamada em outro arquivo	
    EXPORT Start					; Permite chamar a função Start a partir de 
									; outro arquivo. No caso startup.s
								
; Se chamar alguma função externa	
;	IMPORT <func>          			; Permite chamar dentro deste arquivo uma 
									; função <func>

;################################################################################
; Função main()
Start								;Label Start ... void main(void)
; Comece o código aqui <=========================================================

	MOV R0, #701		;a) Realizar o deslocamento lógico em 5 bits do número 701 para a direita com
	LSRS R0, #5			;o flag ‘S’;
	
	MOV R1, #32067		;b) Realizar o deslocamento lógico em 4 bits do número -32067 para a direita
	NEG	R1, R1			;com o flag ‘S’; (Usar o MOV para o número positivo e depois NEG para
	ASRS R1, #4 		;negativar)

	MOV R2, #701		;c) Realizar o deslocamento aritmético em 3 bits do número 701 para a direita
	ASRS R2, #3			;com o flag ‘S’;

	MOV R3, #32067		;d) Realizar o deslocamento aritmético em 5 bits do número -32067 para a
	NEG R3, R3			;direita com o flag ‘S’;
	ASRS R3, #5
	
	MOV R4, #255		;e) Realizar o deslocamento lógico em 8 bits do número 255 para a esquerda
	LSL R4, #8 			;com o flag ‘S’;

	MOV R5, #58982		;f) Realizar o deslocamento lógico em 18 bits do número -58982 para a
	NEG R5, R5			;esquerda com o flag ‘S’;
	LSLS R5, #18

	MOV R6, #0x1234		;g) Rotacionar em 10 bits o número 0xFABC.1234;
	MOVT R6, #0xFABC
	ROR	R6, #10	

	MOV R7, #0x4321		;h) Rotacionar em 2 bits com o carry o número 0x0000.4321; (Realizar duas
	ROR R7, #1			;vezes)
	ROR R7, #1




; Final do código aqui <=========================================================
    NOP
    ALIGN                       	;garante que o fim da seção está alinhada 
    END                         	;fim do arquivo