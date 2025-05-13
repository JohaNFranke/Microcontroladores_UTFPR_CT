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

-Guarda os valores numa lista
Le os valores da lista
Para cada valor lido verifica se o valor é primo, se for guarda na memoria, se n passa para o prox
Apos ler todos os valores, aplica o BubleSort na lista de primos {
    le a lista, comparando 2 valores, e e colocando o menor na frente, apos todos os casos estarem corretos continua verificando....
}




LIST_START       EQU 0x20000400
PRIME_LIST_START EQU 0x20000500
	
numbers_list
    DCD 193, 63, 176, 127, 43, 13, 211, 3, 203, 5, 21, 7, 206, 245, 157, 237, 241, 105, 252, 19

    LDR R0, =LIST_START              ; R0 aponta para a lista de n�meros
    
	BL store_number_list
	
store_number_list
	LDR R1, =numbers_list         ; Endere�o da lista de n�meros
    MOV R2, #20                   ; N�mero total de elementos na lista
    STRB R1, [R0], #4             ; guardar na memoria byte a byte
    ADD R3, R3, #1                ; contador para percorrer a lista
    CMP R3, R2                    ; compara o contador com o tamanho da lista
    BLT store_number_list         ; reinicia a funcao caso o comparador 

read_number_list
    LDR R1, =PRIME_LIST_START
    MOV R9, #0
    LDRB R0, [R1], #4
    BL verifica_primo
    ADD R9, R9, #1
    CMP R3, R9

verifica_primo


	



; Final do c�digo aqui <=========================================================
    NOP
    ALIGN                       	;garante que o fim da se��o est� alinhada 
    END                         	;fim do arquivo