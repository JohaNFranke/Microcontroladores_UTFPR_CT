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

;-Guarda os valores numa lista
;Le os valores da lista
;Para cada valor lido verifica se o valor é primo, se for guarda na memoria, se n passa para o prox
;Apos ler todos os valores, aplica o BubleSort na lista de primos {
    ;le a lista, comparando 2 valores, e e colocando o menor na frente, apos todos os casos estarem corretos termina





ADRESS_LIST_START       		EQU 0x20000400
ADRESS_PRIME_LIST_START 		EQU 0x20000500
	
numbers_list
    DCD 193, 63, 176, 127, 43, 13, 211, 3, 203, 5, 21, 7, 206, 245, 157, 237, 241, 105, 252, 19

    LDR R1, =ADRESS_LIST_START             
	LDR R0, =numbers_list

	MOV R2, #20              ;numero total de elementos na lista
	
store_number_list
	LDRB R3, [R0], #4		  ;le da memoria a lista
    STRB R3, [R1], #4         ;guardar na memoria byte a byte
    SUBS R2, R2, #1           ;contador para percorrer a lista
    BNE store_number_list     ;compara o contador com o tamanho da lista
	
	
	MOV R7, #20				  ;numero total de elementos
	
	LDR R1, =ADRESS_LIST_START
	LDR R6, =ADRESS_PRIME_LIST_START
	
read_number_list
    CMP R7, #0				  ;compara numero de elementos com 0
    BEQ buble_sort			
    LDRB R9, [R1], #4		  ;le da memoria e armazena em R9
    MOV R8, #2                ;inicializa R8 com 2 (início do iterador)
    MOV R2, R9                ;copia o número para R2
    LSR R2, #1                ;divide R2 por 2
    ADD R2, R2, #1            ;adiciona 1 a R2 (número atual / 2 + 1)
    SUBS R7, R7, #1			  ;diminui em 1 o contador

   
   
check_loop
    CMP R8, R2                ;compara o iterador com o limite (número atual / 2 + 1)
	BEQ prime				  ;se R8 = R2 é primo
    BGE not_prime             ;se R8 > R2 nao é primo

    
    MOV R3, R9                ;carrega o numero em R3
    UDIV R4, R3, R8           ;divide R3 por R1 e armazena o resultado em R4
    MLS R5, R4, R8, R3        ;calcula o resto: R5 = R3 - (R4 * R8)

    CMP R5, #0                ;verifica se o resto é 0
    BEQ not_prime             ;se resto for 0 o número não é primo

    ADD R8, R8, #1            ;incrementa o iterador
    B check_loop              ;volta ao início do loop

prime
	BL store_prime			  ;se e primo vai pra funcao store_prime

store_prime
	
	STRB R9, [R6], #4		  ;guarda os numeros primos
	ADD R10, R10, #1		  ;calcula o tamanho do array de primos
	
	BL read_number_list
	

not_prime
    
	BL read_number_list       ;volta para a leitura

buble_sort
	LDR R9, =ADRESS_PRIME_LIST_START
	MOV R2, #0				  ;i contador para comparar com o tamanho do vetor
	
outer_loop
    CMP R2, R10               ;compara i com o comprimento do vetor
    BGE end_sort              ;se i >= tamanho termina a ordenação

    MOV R3, #0                ;inicializa o índice j como 0

inner_loop
	MOV R4, R3
	ADD R5, R4, #1
	CMP R5, R10
	BGE compare_outer_loop
    LDR R6, [R9, R4, LSL #2]  ;carrega o valor de vetor[j] em R4
    LDR R7, [R9, R5, LSL #2]  ;carrega o valor de vetor[j+1] em R5
    CMP R6, R7                ;compara array[j] com array[j+1]
    BLE no_swap               ;se vetor[j] <= vetor[j+1] n troca

							  ;troca vetor[j] e vetor[j+1]
    STR R7, [R9, R4, LSL #2]  ;armazena vetor[j+1] em vetor[j]
    STR R6, [R9, R5, LSL #2]  ;armazena vetor[j] em vetor[j+1]

no_swap
    ADD R3, R3, #1            ;incrementa j
    CMP R3, R10               ;compara j com o comprimento do array
    BLT inner_loop            ;se j < tamanho, continua no inner_loop

    ADD R2, R2, #1            ;incrementa i
    B   outer_loop            ;continua no outer_loop

compare_outer_loop
	ADD R2, R2, #1			  ;adiciona 1 ao i
	B   outer_loop			  ;volta pro outer_loop

end_sort
    B   .             		  ;encerra o loop	


	



; Final do c�digo aqui <=========================================================
    NOP
    ALIGN                       	;garante que o fim da se��o est� alinhada 
    END                         	;fim do arquivo