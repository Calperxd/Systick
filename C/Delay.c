#include "Delay.h"
#include <stdint.h>
#include "TM4C129.h" 


static uint32_t TimeDelay = 0;

void Systick_Initialize(uint32_t ticks){
	
	// Disable Systick IRQ and Systick Counter
	SysTick->CTRL = 0;
	
	// Set reload register
	SysTick->LOAD = ticks - 1;
	
	//Set interrupt priority of Systick
	NVIC_SetPriority(SysTick_IRQn, (1 << __NVIC_PRIO_BITS) - 1);
	
	// Reset the Systick counter value
	SysTick->VAL = 0;
	
	// Setting the clock source 
	// Clock source selected was SYSTEM CLOCK
	SysTick->CTRL |= SysTick_CTRL_CLKSOURCE_Msk;
	
	// Enables Systick Exception
	SysTick->CTRL |= SysTick_CTRL_TICKINT_Msk;
	
	// Enable Systick Timer
	SysTick->CTRL |= SysTick_CTRL_ENABLE_Msk;
	
}

void setTimeDelay(uint32_t timeA){
	TimeDelay = timeA;
}

uint32_t getTimeDelay(void){
	return TimeDelay;
}

void SysTick_Handler(void){
	//if you want, you can declare TimeDelay variable as global in .h and put 'extern' to acess it from other files
	//but don't forget that you need change the variable every time, so you need to declare as volatile
	if(getTimeDelay() > 0) 
		setTimeDelay(getTimeDelay() - 1);
}

void Delay(uint32_t timeB){
	setTimeDelay(timeB);
}
