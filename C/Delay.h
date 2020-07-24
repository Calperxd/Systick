#ifndef DELAY_H
#define DELAY_H
#include <stdint.h>

void Systick_Initialize(uint32_t ticks);
void SysTick_Handler(void);
void setTimeDelay(uint32_t time);
uint32_t getTimeDelay(void);




#endif
