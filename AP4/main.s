; main.c

;################################################################################
	
FLAG				EQU R6	;Flag para pedestres (Verificar no estado 1)
ESTADO_SEMAFORO		EQU	R7	;Estado algoritmo do semaforo 0 a 5


; Área de Código - Tudo abaixo da diretiva a seguir será armazenado na memória de 
;                  código
	AREA    |.text|, CODE, READONLY, ALIGN=2
	; Se alguma função do arquivo for chamada em outro arquivo	
    EXPORT Start                		; Permite chamar a função Start a partir de 
										; outro arquivo. No caso startup.s
	; Se chamar alguma função externa	
	;IMPORT <func>              		; Permite chamar dentro deste arquivo uma 
										; função <func>
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
; Função main()
	
Start

    BL      PLL_Init               ; Inicializa o PLL
    BL      SysTick_Init           ; Inicializa o SysTick
    BL      GPIO_Init              ; Inicializa as GPIOs

							; Inicialização das variáveis globais
    
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
    ALIGN                        		;Garante que o fim da seção está alinhada 
    END                          		;Fim do arquivo