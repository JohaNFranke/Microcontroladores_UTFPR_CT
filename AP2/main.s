; main.s
; Desenvolvido para a placa EK-TM4C1294XL

;################################################################################
	THUMB											; Instru��es do tipo Thumb-2
;################################################################################
; Defini��es dos Registradores Gerais.  Obs: *(EQU)=(EQUATE)*
;<NOME>	EQU	<VALOR>
MODO_OPERACAO 		EQU R5	;Modo de operacao 0 e 1 (Passeio e contador)
VELOCIDADE			EQU R6	;Velocidade 0 a 2 (1000, 500, 200)
ESTADO_PASSEIO		EQU	R7	;Estado algoritmo do passeio 0 a 5
ESTADO_CONTADOR		EQU	R8	;Estado algoritmo do contador 0 a 15

;################################################################################
; �rea de Dados - Declara��es de vari�veis
	AREA  DATA, ALIGN=2
	; Se alguma vari�vel for chamada em outro arquivo
	;EXPORT  <var> [DATA,SIZE=<tam>]	; Permite chamar a vari�vel <var> a 
		                                ; partir de outro arquivo
;<var>	SPACE <tam>                     ; Declara uma vari�vel de nome <var>
                                        ; de <tam> bytes a partir da primeira 
                                        ; posi��o da RAM		
;################################################################################
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de 
;                  c�digo
	AREA    |.text|, CODE, READONLY, ALIGN=2
	; Se alguma fun��o do arquivo for chamada em outro arquivo	
    EXPORT Start                		; Permite chamar a fun��o Start a partir de 
										; outro arquivo. No caso startup.s
	; Se chamar alguma fun��o externa	
	;IMPORT <func>              		; Permite chamar dentro deste arquivo uma 
										; fun��o <func>
	IMPORT  PLL_Init
	IMPORT  SysTick_Init
	IMPORT  SysTick_Wait1ms			
	IMPORT  GPIO_Init
	IMPORT  PortN_Output
	IMPORT  PortJ_Input	
	IMPORT  PortF_Output
	IMPORT	Ligar_LEDs
	IMPORT	Testar_Chaves
	IMPORT	Esperar_Tempo
	
;################################################################################
; Fun��o main()
	
Start

    BL      PLL_Init               ; Inicializa o PLL
    BL      SysTick_Init           ; Inicializa o SysTick
    BL      GPIO_Init              ; Inicializa as GPIOs

							; Inicializa��o das vari�veis globais
    MOV     R4, #0      		   ; Inicia em Passeio do Cavaleiro
    MOV     R5, #0          	   ; Inicia com 1000ms
    MOV     R6, #0     			   ; Estado inicial do passeio
    MOV     R7, #0    			   ; Estado inicial do contador

mainloop
    BL      Ligar_LEDs             ; Acende os LEDs conforme o estado atual
	BL      Testar_Chaves          ; Verifica o estado das chaves
    BL      Esperar_Tempo          ; Espera o tempo configurado
    B       mainloop               ; Loop infinito


;################################################################################
; Fim do Arquivo
;################################################################################
    ALIGN                        		;Garante que o fim da se��o est� alinhada 
    END                          		;Fim do arquivo