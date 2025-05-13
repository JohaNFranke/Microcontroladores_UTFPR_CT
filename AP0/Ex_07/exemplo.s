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



    MOV R0, 10                    	;(a) Mover o valor 10 para R0
    ADD R0, R0, 5                   ;(b) Somar 5 a R0 (R0 = R0 + 5)
    
loop
    CMP R0, 50                     	;(c) Comparar R0 com 50
    BEQ call_function1              ;(c) Se R0 == 50, pular para chamada da função
    ADD R0, R0, 5                 	;(c) Caso contrário, adicionar 5 a R0
    B loop                          ;(c) Voltar ao início do loop

call_function1
    MOV R1, R0                      ;(d.1) Copiar o valor de R0 para R1
    CMP R1, 50                     	;(d.2) Comparar R1 com 50
    BLT increment_r1                ;(d.3) Se R1 < 50, pular para incremento
    MOV R1, -50                    	;(d.3) Se R1 >= 50, carregar R1 com -50
    B done                          ;Pular para finalizar

increment_r1
    ADD R1, R1, 1                  	;(d.3) Incrementar R1

done
    NOP                             ;(e) Nenhuma operação
    B .                             ;(f) Ficar travado na última linha de execução (loop infinito)

		
							


; Final do código aqui <=========================================================
    NOP
    ALIGN                       	;garante que o fim da seção está alinhada 
    END                         	;fim do arquivo