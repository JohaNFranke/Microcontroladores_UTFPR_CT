; main.c

;################################################################################
	
FLAG				EQU R6	;Flag para pedestres (Verificar no estado 1)
ESTADO_SEMAFORO		EQU	R7	;Estado algoritmo do semaforo 0 a 5


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
    
    MOV     R6, #0     			   ; Estado flag
    MOV     R7, #0    			   ; Estado Semaforo

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