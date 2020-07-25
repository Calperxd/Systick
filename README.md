# SYSTICK
This repository gives a few example functions in C and assembly to show how to implement a delay function and configure the System time(SysTick).

#### Requiriments

- Medium knowledge in assembly for arm cortex m4
- Medium knowledge in C language
- Basic knowledge in ARM architecture

#### Introduction

The systick is very useful peripheral, because it's peripheral inside the microcontroller with low latency, we can perform several things using systick timer but there are two that comes on my mind right now and they are RTOS timer functions and famous delay() in Arduino, in this tutorial, we will focus on how to implement the delay() in ***TM4C1294NCPDT(ARM Cortex M4)*** but we will detail more about the process how to build from the scratch.



#### Let's get start it!

Let's start from the ***EQU*** directives in assembly code, observe that all the assembly files needed are into Assembly folder and all the implementations in C are into C folder, first of all I declared some directives to improve the readability of the code and do some operations too.

![EQU](https://user-images.githubusercontent.com/48101913/88448541-ff842080-ce0c-11ea-8006-16e806b403cc.JPG)

The ARM CORTEX M4 has some interesting features(into the processor), by default these features are mapped at address 0xE000E000 to 0xE000EFFF, this space is commonly called space of ***Core Peripherals Addresses*** or ***System Control Space*** in the following image, we can visualize better how these core peripherals are mapped.

![Memmory-Map](https://user-images.githubusercontent.com/48101913/88449827-2a27a680-ce18-11ea-9aeb-c64620e11a45.JPG)

and to TM4C1294NCPDT we have the following addresses, the unused spaces are reserved by the chip manufacturer.

![Core Peripherals Addresses](https://user-images.githubusercontent.com/48101913/88450511-83de9f80-ce1d-11ea-9343-5ebc643492d4.JPG)

Now we have a overview how the peripherals are mapped, so let's go to the code and see the implementation and how it works.
