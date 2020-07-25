# SYSTICK
This repository gives a few example functions in C and assembly to show how to implement a delay function and configure the System time(SysTick)

#### Introduction

The systick is very useful peripheral, because it's peripheral inside the microcontroller with low latency, we can perform several things using systick timer but there are two that comes on my mind right now and they are RTOS timer functions and famous delay() in Arduino, in this tutorial, we will focus on how to implement the delay() in ***TM4C1294NCPDT(ARM Cortex M4)*** but we will detail more about the process how to build from the scratch.

#### Let's get start it!

Let's start from the ***EQU*** directives in assembly code, observe that all the assembly files needed are into Assembly folder and all the implementations in C are into C folder, first of all I declared some directives to improve the readability of the code and do some operations too.

![EQU](https://user-images.githubusercontent.com/48101913/88448541-ff842080-ce0c-11ea-8006-16e806b403cc.JPG)


