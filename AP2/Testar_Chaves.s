	AREA    |.text|, CODE, READONLY, ALIGN=2

    EXPORT Testar_Chaves
        
    IMPORT PortJ_Input
    IMPORT SysTick_Wait1ms
;################################################################################
	
Testar_Chaves
	PUSH 		{LR}
	BL			PortJ_Input
	POP			{LR}
	
	CMP      	R0, #2_00000010                 ;Verifica se a chave SW1 está pressionada
	PUSHEQ   	{LR}
    BLEQ 	 	Verifica_SW1
	POPEQ     	{LR}
	
	CMP     	 R0, #2_00000001               	 ;Verifica se a chave SW2 está pressionada
	PUSHEQ   	{LR}
    BLEQ 	 	Verifica_SW2
	POPEQ    	{LR}
	
Retorna
    PUSH    	 {LR}               
    BL      	 PortJ_Input         
    POP     	 {LR}               
    CMP     	 R0, #2_11          
    BNE     	 Retorna            
    BX      	 LR 
	
Verifica_SW1
    CMPEQ        R5, #0        
    BEQ          SW1_true    
    MOV          R5, #0        
    B            SW1_false    

SW1_true
    MOV          R5, #1        
SW1_false
    BX           LR   

Verifica_SW2
    CMP     	 R6, #0            
    BEQ     	 Espera_1000ms             
    CMP     	 R6, #1             
    BEQ     	 Espera_500ms             
    CMP     	 R6, #2             
    BEQ     	 Espera_200ms                            

Espera_1000ms
    MOV     	 R6, #1
	B			 final	

Espera_500ms
    MOV     	 R6, #2
	B			 final
                
Espera_200ms
    MOV     	 R6, #0             
	B			 final

final
	BX			 LR
	      

	                


	
		
		
;################################################################################
	ALIGN                        ;Garante que o fim da seção está alinhada 
    END                          ;Fim do arquivo

