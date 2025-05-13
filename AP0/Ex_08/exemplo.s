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

	LDR R1, =0x20000000             ;Carrega o endere�o da posi��o de mem�ria em R1
	
	MOV R0, 5						;Valor a ser carregado na memoria
	STR R0, [R1]					;Guarda o valor do fatorial na memoria
	
    LDR R2, [R1]                    ;Le o valor da mem�ria (n�mero para o fatorial) para R2

    MOV R0, R2                      ;Move o n�mero para R0 (R0 agora cont�m o n�mero n)
    MOV R3, 1                       ;Inicializa R3 como 1 (acumulador para o fatorial)

factorial_loop
    CMP R0, 1                       ;Compara o valor de R0 com 1
    BLE end_factorial               ;Se R0 <= 1, saia do loop
    MUL R3, R3, R0                  ;Multiplica R3 (acumulador) por R0
    SUB R0, R0, 1                   ;Decrementa R0 (R0 = R0 - 1)
    B factorial_loop                ;Repete o loop

end_factorial
    MOV R0, R3                      ;Move o resultado (fatorial) para R0

     B .							;Adicionar um loop infinito para evitar que o c�digo continue

   

		
							


; Final do c�digo aqui <=========================================================
    NOP
    ALIGN                       	;garante que o fim da se��o est� alinhada 
    END                         	;fim do arquivo