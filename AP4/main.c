//main.c

//################################################################################

#include <stdint.h>

	//extern volatile uint32_t* FLAG;

	int flag = 0;	//0x2000.0004

	//volatile	uint32_t* FLAG =0;

	void  PLL_Init(void);
	void  SysTick_Init(void);
	void SysTick_Wait1ms(uint32_t delay);
	void GPIO_Init(void);
	uint32_t PortJ_Input(void);
	void PortN_Output(uint32_t leds);
	void PortF_Output(uint32_t leds);
	
	void Semaforo(void);
	
	void reset_flag(void);
	void set_flag(void);
	
	void set_flag(void)	{
		if (PortJ_Input() == 0x2)	{
			flag = 1;
		}
	}
	
	void reset_flag(void)	{
		if (PortJ_Input() == 0x3)	{
			flag = 0;
		}
	}
	
		
	
	void Semaforo(void)	{
		
	
		//PortN_Output(0x2);	//LED1
		//PortN_Output(0x1);  //LED2
	  //PortF_Output(0x10);	//LED3
	  //PortF_Output(0x1);	//LED4
		
		//parte0
		
		//set_flag();
		PortN_Output(0x3);
		PortF_Output(0x11);
		
		if(flag == 1){
			SysTick_Wait1ms(4000);
			reset_flag();
			flag =0;
		}			
		else {
			SysTick_Wait1ms(1000);
			reset_flag();
			flag =0;
		}
		
		
		//parte1
		
		set_flag();
		PortF_Output(0x10);
		SysTick_Wait1ms(6000);
		
		//parte2
		
		set_flag();
		PortF_Output(0x1);
		SysTick_Wait1ms(2000);
		
		//parte3
		
		set_flag();
		PortF_Output(0x11);
		SysTick_Wait1ms(1000);
		
		//parte4
		
		set_flag();
		PortN_Output(0x2);
		SysTick_Wait1ms(6000);
		
		//parte5
		
		set_flag();
		PortN_Output(0x1);
		SysTick_Wait1ms(2000);
		
		return;
}

int main(void)	{

	PLL_Init();
	SysTick_Init();
	GPIO_Init();
	//*FLAG = 0;
	
	
while (1)		{
			set_flag();
			Semaforo();
               

	}
}


