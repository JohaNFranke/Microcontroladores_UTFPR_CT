; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Exemplo de uso de GPIO ...
; Prof. Guilherme de S. Peron	- 12/03/2018
; Prof. Marcos E. P. Monteiro	- 12/03/2018
; Prof. DaLuz           		- 25/02/2022

;################################################################################

; Este programa espera o usu�rio apertar a chave USR_SW1.
; Caso o usu�rio pressione a chave, o LED1 piscar� a cada 0,5 segundo.

;################################################################################
	THUMB											; Instru��es do tipo Thumb-2
;################################################################################
; Defini��es dos Registradores Gerais.  Obs: *(EQU)=(EQUATE)*
;<NOME>	EQU	<VALOR>
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
;################################################################################
; Fun��o main()
Start  		
	BL		PLL_Init                  	;Chama a subrotina para alterar o clock do microcontrolador para 80MHz
	BL		SysTick_Init				;Chama a subrotina para Inicializar o SysTick
	BL		GPIO_Init       	       	;Chama a subrotina que inicializa os GPIO

MainLoop
	BL		PortJ_Input					;Chama a subrotina que l� o estado das chaves e coloca o resultado em R0
Verifica_Nenhuma
	CMP		R0, #2_00000001				;Verifica se nenhuma chave est� pressionada
	BNE		Verifica_SW1				;Se o teste viu que tem pelo menos alguma chave pressionada pula
	MOV		R0, #0						;N�o acender nenhum LED
	BL		PortN_Output				;Chamar a fun��o para n�o acender nenhum LED
	B		MainLoop					;Se o teste viu que nenhuma chave est� pressionada, volta para o la�o principal
Verifica_SW1	
	CMP		R0, #2_00000000				;Verifica se somente a chave SW1 est� pressionada
	BNE		MainLoop					;Se o teste falhou, volta para o in�cio do la�o principal
	BL		Pisca_LED					;Chama a rotina para piscar LED
	B		MainLoop					;Volta para o la�o principal

;################################################################################
; Fun��o Pisca_LED
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
;################################################################################
Pisca_LED
	MOV		R0, #2_10					;Setar o par�metro de entrada da fun��o setando o BIT1
	PUSH	{LR}
	BL		PortN_Output				;Chamar a fun��o para acender o LED1
	MOV		R0, #500					;Carregar o par�metro da chamada da rotina SysTick
	BL		SysTick_Wait1ms				;Chamar a rotina Systick para esperar 500ms
	MOV		R0, #0						;Setar o par�metro de entrada da fun��o apagando o BIT1
	BL		PortN_Output				;Chamar a rotina para apagar o LED
	MOV		R0, #500					;Carregar o par�metro da chamada da rotina SysTick
	BL		SysTick_Wait1ms				;Chamar a rotina Systick para esperar 500ms
	POP		{LR}
	BX		LR						 	;return

;################################################################################
; Fim do Arquivo
;################################################################################
    ALIGN                        		;Garante que o fim da se��o est� alinhada 
    END                          		;Fim do arquivo