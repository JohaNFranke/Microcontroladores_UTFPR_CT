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

	MOV R0, #10			;a) Mover o valor 10 para o registrador R0;
	
	MOV R1, #0xCC22		;b) Mover o valor 0xFF11.CC22 para o registrador R1;
	MOVT R1, #0xFF11
	
	MOV R2, #1234		;c) Mover o valor 1234 para o registrador R2;
	
	MOV R3, #0x300		;d) Mover o valor 0x300 para o registrador R3;
	
	PUSH {R0}			;e) Empurrar para a pilha o R0;
	
	PUSH {R1 - R3}		;f) Empurrar para a pilha os R1, R2 e R3;
	
						;g) Visualizar a pilha na mem�ria (o topo da pilha est� em 0x2000.0400);
						
	MOV R1, #60			;h) Mover o valor 60 para o registrador R1;
	
	MOV R2, #0x1234		;i) Mover o valor 0x1234 para o registrador R2;
	
	POP {R0, R1-R3}		;j) Desempilhar corretamente os valores para os registradores R0, R1, R2
						;e R3;

		
							


; Final do c�digo aqui <=========================================================
    NOP
    ALIGN                       	;garante que o fim da se��o est� alinhada 
    END                         	;fim do arquivo