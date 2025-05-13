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

	MOV R0, #10				;a) Mova o valor 10 para o registrador R0;
	
	TSTS R0, #9				;b) Teste se o registrador é maior ou igual que 9;
	ITTE EQ 				;c) Crie um bloco com If-Then com 3 execuções condicionais
	MOVEQ R1, #50			;- Se sim, salve o número 50 no R1
	ADDEQ R2, R1, #32		;- Se sim, adicione 32 com o R1 e salve o resultado em R2
	MOVNE R3, #75			;- Se não, salve o número 75 no R3
							
	TSTS R0, #11			;d) Agora verifique se o registrador é maior ou igual a 11 e execute
	ITTE NE 				;novamente o passo (c);
	MOVEQ R1, #50			
	ADDEQ R2, R1, #32		
	MOVNE R3, #75			
							


; Final do código aqui <=========================================================
    NOP
    ALIGN                       	;garante que o fim da seção está alinhada 
    END                         	;fim do arquivo