	AREA    |.text|, CODE, READONLY, ALIGN=2

    EXPORT Esperar_Tempo
        
    IMPORT SysTick_Wait1ms
;################################################################################

Esperar_Tempo
    CMP     R6, #0             
    BEQ     Espera_1000ms       
    CMP     R6, #1             
    BEQ     Espera_500ms        
    CMP     R6, #2             
    BEQ     Espera_200ms        
    B       final                

Espera_1000ms
    MOV     R0, #1000          
    B       SysTick_Wait1ms     

Espera_500ms
    MOV     R0, #500           
    B       SysTick_Wait1ms     

Espera_200ms
    MOV     R0, #200           
    B       SysTick_Wait1ms     

final
    BX      LR                 




;################################################################################
	ALIGN                        ;Garante que o fim da seção está alinhada 
    END                          ;Fim do arquivo
