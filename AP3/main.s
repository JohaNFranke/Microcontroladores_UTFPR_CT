; main.s
; Desenvolvido para a placa EK-TM4C1294XL

;################################################################################
	THUMB											; Instru��es do tipo Thumb-2
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
	IMPORT	GPIOPortJ_Handler
		
;################################################################################
; Fun��o main()
	
Start

    BL      PLL_Init               ; Inicializa o PLL
    BL      SysTick_Init           ; Inicializa o SysTick
    BL      GPIO_Init              ; Inicializa as GPIOs
	
MainLoop
	BL		GPIOPortJ_Handler
	B		MainLoop
	
	
;################################################################################
; Fim do Arquivo
;################################################################################
    ALIGN                        		;Garante que o fim da se��o est� alinhada 
    END                          		;Fim do arquivo