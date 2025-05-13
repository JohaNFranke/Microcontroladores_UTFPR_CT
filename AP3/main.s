; main.s
; Desenvolvido para a placa EK-TM4C1294XL

;################################################################################
	THUMB											; Instruções do tipo Thumb-2
;################################################################################

; Área de Dados - Declarações de variáveis
	AREA  DATA, ALIGN=2
	; Se alguma variável for chamada em outro arquivo
	;EXPORT  <var> [DATA,SIZE=<tam>]	; Permite chamar a variável <var> a 
		                                ; partir de outro arquivo
;<var>	SPACE <tam>                     ; Declara uma variável de nome <var>
                                        ; de <tam> bytes a partir da primeira 
                                        ; posição da RAM		
;################################################################################
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
	IMPORT	GPIOPortJ_Handler
		
;################################################################################
; Função main()
	
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
    ALIGN                        		;Garante que o fim da seção está alinhada 
    END                          		;Fim do arquivo