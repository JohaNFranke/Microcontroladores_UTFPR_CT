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

	MOV R1, #0xF0			;a) Realizar a operação lógica AND do valor 0xF0 com o valor binário			
	MOV R2, #2_01010101		;01010101 e salvar o resultado em R0. Utilizar o sufixo ‘S’ para atualizar
	ANDS R0, R1, R2			;os flags;
				
	MOV R2, #2_11001100		;b) Realizar a operação lógica AND do valor 11001100 binário com o valor
	MOV R3, #2_00110011		;binário 00110011 e salvar o resultado em R1. Utilizar o sufixo ‘S’ para
	ANDS R1, R2, R3			;atualizar os flags;
				
	MOV R3, #2_10000000		;c) Realizar a operação lógica OR do valor 10000000 binário com o valor
	MOV R4, #2_00110011		;binário 00110111 e salvar o resultado em R2. Utilizar o sufixo ‘S’ para
	ORRS R2, R3, R4			;atualizar os flags;
	
	MOV R4, #0xABCD			;d) Realizar a operação lógica AND do valor 0xABCDABCD com o valor
	MOVT R4, #0xABCD		;0xFFFF0000 (sem usar LDR-diretiva) e salvar o resultado em R3. Utilizar
	MOV R5, #0x0000			;o sufixo ‘S’ para atualizar os flags. Utilizar a instrução BIC;
	MOVT R5, #0xFFFF
	ANDS R3, R4, R5

; Final do código aqui <=========================================================
    NOP
    ALIGN                       	;garante que o fim da seção está alinhada 
    END                         	;fim do arquivo