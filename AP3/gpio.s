; gpio.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme de S. Peron	- 12/03/2018
; Prof. Marcos E. P. Monteiro	- 12/03/2018
; Prof. DaLuz           		- 25/02/2022

;################################################################################
        THUMB                        ; Instru��es do tipo Thumb-2
;################################################################################
; Defini��es dos Registradores Gerais.  Obs: *(EQU)=(EQUATE)*
BIT0						EQU		2_0001				;sch evaluation kit
BIT1						EQU		2_0010				;sch evaluation kit
SYSCTL_RCGCGPIO_R	 		EQU		0x400FE608
SYSCTL_PRGPIO_R		 		EQU		0x400FEA08
; Defini��es dos Registradores especiais do PORT J
GPIO_PORTJ_AHB_LOCK_R    	EQU		0x40060520
GPIO_PORTJ_AHB_CR_R      	EQU		0x40060524
GPIO_PORTJ_AHB_AMSEL_R   	EQU		0x40060528
GPIO_PORTJ_AHB_PCTL_R    	EQU		0x4006052C
GPIO_PORTJ_AHB_DIR_R     	EQU		0x40060400
GPIO_PORTJ_AHB_AFSEL_R   	EQU		0x40060420
GPIO_PORTJ_AHB_DEN_R     	EQU		0x4006051C
GPIO_PORTJ_AHB_PUR_R     	EQU		0x40060510	
GPIO_PORTJ_AHB_DATA_R    	EQU		0x400603FC
GPIO_PORTJ_AHB_DATA_BITS_R  EQU		0x40060000
GPIO_PORTJ               	EQU		2_000000100000000	;datasheet pg 382 ...
; Defini��es dos registradores para ativa��o de interrup��o
GPIO_PORTJ_AHB_IS_R			EQU		0x40060404
GPIO_PORTJ_AHB_IM_R			EQU		0x40060410
GPIO_PORTJ_AHB_IBE_R		EQU		0x40060408
GPIO_PORTJ_AHB_IEV_R		EQU		0x4006040C
GPIO_PORTJ_AHB_ICR_R		EQU		0x4006041C
NVIC_EN1_R					EQU		0X40060104
NVIC_PRI12_R				EQU		0X40060430
GPIO_PORTJ_ICR_R			EQU		0x40060414
GPIO_RIS					EQU		0x40060414
; Defini��es dos Registradores especiais do PORT N
GPIO_PORTN_LOCK_R    		EQU		0x40064520
GPIO_PORTN_CR_R      		EQU		0x40064524
GPIO_PORTN_AMSEL_R   		EQU		0x40064528
GPIO_PORTN_PCTL_R    		EQU		0x4006452C
GPIO_PORTN_DIR_R     		EQU		0x40064400
GPIO_PORTN_AFSEL_R   		EQU		0x40064420
GPIO_PORTN_DEN_R     		EQU		0x4006451C
GPIO_PORTN_PUR_R     		EQU		0x40064510	
GPIO_PORTN_DATA_R    		EQU		0x400643FC
GPIO_PORTN_DATA_BITS_R  	EQU		0x40064000
GPIO_PORTN               	EQU		2_001000000000000	;datasheet pg 382 ...	

;################################################################################
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de 
;                  c�digo
	AREA    |.text|, CODE, READONLY, ALIGN=2

	; Se alguma fun��o do arquivo for chamada em outro arquivo	
    EXPORT GPIO_Init            ; Permite chamar GPIO_Init de outro arquivo
	EXPORT PortN_Output			; Permite chamar PortN_Output de outro arquivo
	EXPORT PortJ_Input          ; Permite chamar PortJ_Input de outro arquivo
	EXPORT GPIOPortJ_Handler
	
;################################################################################
; Fun��o GPIO_Init
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
;################################################################################
GPIO_Init
; 1. Ativar o clock para a porta setando o bit correspondente no registrador RCGCGPIO,
; ap�s isso verificar no PRGPIO se a porta est� pronta para uso.
; enable clock to GPIOF at clock gating register
	LDR     R0, =SYSCTL_RCGCGPIO_R  			;Carrega o endere�o do registrador RCGCGPIO
	MOV		R1, #GPIO_PORTN                 	;Seta o bit da porta N
	ORR     R1, #GPIO_PORTJ						;Seta o bit da porta J, fazendo com OR
    STR     R1, [R0]							;Move para a mem�ria os bits das portas no endere�o do RCGCGPIO
    LDR     R0, =SYSCTL_PRGPIO_R				;Carrega o endere�o do PRGPIO para esperar os GPIO ficarem prontos
EsperaGPIO
	LDR     R1, [R0]							;L� da mem�ria o conte�do do endere�o do registrador
	MOV     R2, #GPIO_PORTN                 	;Seta os bits correspondentes �s portas para fazer a compara��o
	ORR     R2, #GPIO_PORTJ                 	;Seta o bit da porta J, fazendo com OR
    TST     R1, R2								;Testa o R1 com R2 fazendo R1 & R2
    BEQ     EsperaGPIO					    	;Se o flag Z=1, volta para o la�o. Sen�o continua executando
; 2. Limpar o AMSEL para desabilitar a anal�gica
    MOV     R1, #0x00							;Colocar 0 no registrador para desabilitar a fun��o anal�gica
    LDR     R0, =GPIO_PORTJ_AHB_AMSEL_R     	;Carrega o R0 com o endere�o do AMSEL para a porta J
    STR     R1, [R0]							;Guarda no registrador AMSEL da porta J da mem�ria
    LDR     R0, =GPIO_PORTN_AMSEL_R				;Carrega o R0 com o endere�o do AMSEL para a porta N			
    STR     R1, [R0]
; 3. Limpar PCTL para selecionar o GPIO
    MOV     R1, #0x00					    	;Colocar 0 no registrador para selecionar o modo GPIO
    LDR     R0, =GPIO_PORTJ_AHB_PCTL_R			;Carrega o R0 com o endere�o do PCTL para a porta J
    STR     R1, [R0]                        	;Guarda no registrador PCTL da porta J da mem�ria
    LDR     R0, =GPIO_PORTN_PCTL_R      		;Carrega o R0 com o endere�o do PCTL para a porta N   		
    STR     R1, [R0]
; 4. DIR para 0 se for entrada, 1 se for sa�da
    LDR     R0, =GPIO_PORTN_DIR_R				;Carrega o R0 com o endere�o do DIR para a porta N
	MOV     R1, #2_0010							;PN1
	ORR		R1, #2_0001							;PN0
    STR     R1, [R0]							;Guarda no registrador
; O certo era verificar os outros bits da PJ para n�o transformar entradas em sa�das desnecess�rias
    LDR     R0, =GPIO_PORTJ_AHB_DIR_R			;Carrega o R0 com o endere�o do DIR para a porta J
    MOV     R1, #0x00               			;Colocar 0 no registrador DIR para funcionar com sa�da
    STR     R1, [R0]							;Guarda no registrador PCTL da porta J da mem�ria
; 5. Limpar os bits AFSEL para 0 para selecionar GPIO 
;    Sem fun��o alternativa
    MOV     R1, #0x00							;Colocar o valor 0 para n�o setar fun��o alternativa
    LDR     R0, =GPIO_PORTN_AFSEL_R				;Carrega o endere�o do AFSEL da porta N
    STR     R1, [R0]							;Escreve na porta
    LDR     R0, =GPIO_PORTJ_AHB_AFSEL_R     	;Carrega o endere�o do AFSEL da porta J
    STR     R1, [R0]                        	;Escreve na porta
; 6. Setar os bits de DEN para habilitar I/O digital
    LDR     R0, =GPIO_PORTN_DEN_R		    	;Carrega o endere�o do DEN
    MOV     R1, #2_0010                 		;PN1 
	ORR		R1, #2_0001							;PN0 
    STR     R1, [R0]							;Escreve no registrador da mem�ria funcionalidade digital 
 
    LDR     R0, =GPIO_PORTJ_AHB_DEN_R			;Carrega o endere�o do DEN
	MOV     R1, #2_00000011             		;J0     
    STR     R1, [R0]                    		;Escreve no registrador da mem�ria funcionalidade digital
	
; 7. Para habilitar resistor de pull-up 		interno, setar PUR para 1
	LDR     R0, =GPIO_PORTJ_AHB_PUR_R			;Carrega o endere�o do PUR para a porta J
	MOV     R1, #2_00000011						;Habilitar funcionalidade digital de resistor de pull-up 
    STR     R1, [R0]							;Escreve no registrador da mem�ria do resistor de pull-up
			

; HABILITANDO INTERRUP��ES
; Passo 1: Desabilitar GPIOIM de J0 e J1 (2 �ltimos bits)
	LDR 	R0, =GPIO_PORTJ_AHB_IM_R
	MOV 	R1, #2_00
	STR 	R1, [R0]
	; Passo 2: Configura��o borda no registrador GPIOIS
	LDR 	R0, =GPIO_PORTJ_AHB_IS_R
	MOV 	R1, #2_00
	STR 	R1, [R0]
	; Passo 3a: Configura��o borda �nica para os pinos J0 e J1 no registrador GPIOIBE
	LDR 	R0, =GPIO_PORTJ_AHB_IBE_R
	MOV 	R1, #2_00
	STR 	R1, [R0]
	; Passo 3b: Configura��o borda de descida para J0 e subida para J1 no registrador GPIOIEV
	LDR 	R0, =GPIO_PORTJ_AHB_IEV_R
	MOV 	R1, #2_10
	STR 	R1, [R0]
	; Passo 4: ACK no registrador GPIOICR para os pinos J0 e J1
	LDR 	R0, =GPIO_PORTJ_AHB_ICR_R
	MOV 	R1, #2_11
	STR 	R1, [R0]
	; Passo 5: Ativar interrup��o nos pinos J0 e J1 em GPIOIM (desabilitada no passo 1)
	LDR 	R0, =GPIO_PORTJ_AHB_IM_R
	MOV 	R1, #2_11
	STR 	R1, [R0]
	; Passo 6: Ativar a fonte de interrup��o no NVIC
	LDR 	R0, =NVIC_EN1_R
	MOV 	R1, #1
	LSL		R1, #19
	STR 	R1, [R0]
	; Passo 7: Configurar a prioridade da fonte de interrup��o no NVIC (prioridade = 5)
	LDR 	R0, =NVIC_PRI12_R
	MOV 	R1, #5
	LSL 	R1, R1, #29
	STR 	R1, [R0]

	BX		LR

; Passo 8: Criar a rotina de ISR
GPIOPortJ_Handler
	LDR 	R5, =GPIO_RIS
	LDR		R5, [R5]
	CMP		R5, #2_01				;Verifica J0	(SW1)
	PUSHEQ	{LR}
	BEQ		Controla_LED1
	POPEQ	{LR}
	BXEQ	LR
	
	CMP		R5, #2_10				;Verifica J1	(SW2)
	PUSHEQ	{LR}
	BEQ 	Controla_LED2	
	POPEQ	{LR}
	BX		LR

Controla_LED1
	LDR 	R0, =GPIO_PORTJ_AHB_ICR_R
	MOV		R1, #2_01					;ACK bit 0 do PortJ
	STR 	R1, [R0]					
	
	MOV 	R0, #2_10
	PUSH	{LR}
	BL 		PortN_Output
	POP		{LR}
	
	BX 		LR
	
Controla_LED2
	LDR 	R0, =GPIO_PORTJ_AHB_ICR_R
	MOV		R1, #2_10					;ACK bit 1 do PortJ
	STR 	R1, [R0]					
		
	MOV 	R0, #2_01
	PUSH	{LR}
	BL 		PortN_Output
	POP		{LR}
	
	BX 		LR
;################################################################################
; Fun��o PortN_Output
; Par�metro de entrada: R0 --> se o BIT1 est� ligado ou desligado
; Par�metro de sa�da: N�o tem
;################################################################################
PortN_Output
	LDR	R1, =GPIO_PORTN_DATA_R		    		;Carrega o valor do offset do data register
												;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_00000011                   	;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 11111101
	ORR R0, R0, R2                          	;Fazer o OR do lido pela porta com o par�metro de entrada
	STR R0, [R1]                            	;Escreve na porta N o barramento de dados do pino N1
	BX LR										;Retorno

;################################################################################
; Fun��o PortJ_Input
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: R0 --> o valor da leitura
;################################################################################
PortJ_Input
	LDR	R1, =GPIO_PORTJ_AHB_DATA_R		    ;Carrega o valor do offset do data register
	LDR R0, [R1]                            ;L� no barramento de dados dos pinos [J0]
	BX LR									;Retorno


    ALIGN                           ; garante que o fim da se��o est� alinhada 
    END                             ; fim do arquivo