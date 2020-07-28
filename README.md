# SYSTICK
This repository gives a few example functions in C and assembly to show how to implement a delay function and configure the System timer(SysTick).

#### Requirements

- Medium knowledge in assembly for arm cortex m4
- Medium knowledge in C language
- Basic knowledge in ARM architecture

#### Introduction

The systick is a very useful peripheral, because it's peripheral inside the microcontroller with low latency, we can perform several things using systick timer but there are two that comes on my mind right now and they are RTOS timer functions and famous delay() in Arduino, in this tutorial, we will focus on how to implement the delay() in ***TM4C1294NCPDT(ARM Cortex M4)*** but we will detail more about the process how to build from the scratch.

#### Let's get start it!

Let's start from the ***EQU*** directives in assembly code, observe that all the assembly files needed are into Assembly folder and all the implementations in C are into C folder, first of all I declared some directives to improve the readability of the code and do some operations too.

![EQU](https://user-images.githubusercontent.com/48101913/88448541-ff842080-ce0c-11ea-8006-16e806b403cc.JPG)

The ARM CORTEX M4 has some interesting features(into the processor), by default these features are mapped at address 0xE000E000 to 0xE000EFFF, this space is commonly called space of ***Core Peripherals Addresses*** or ***System Control Space*** in the following image, we can visualize better how these core peripherals are mapped.

![Memmory-Map](https://user-images.githubusercontent.com/48101913/88449827-2a27a680-ce18-11ea-9aeb-c64620e11a45.JPG)

and to TM4C1294NCPDT we have the following addresses, the unused spaces are reserved by the chip manufacturer.

![Core Peripherals Addresses](https://user-images.githubusercontent.com/48101913/88450511-83de9f80-ce1d-11ea-9343-5ebc643492d4.JPG)

Now that we have an overview how the peripherals are mapped, so let's go to the code and see the implementation and how it works.

![SysTick_Procedure](https://user-images.githubusercontent.com/48101913/88619874-f4322e80-d072-11ea-8de6-b45a2ba42b2e.JPG)

Note that we start charging the base address of SysTick because if we need to improve the readability of the code we can declare masks before start the code and use OR mask, XOR mask, AND mask, etc(we will discuss a little bit more about this later), we also know that each register has a specific address in memory and these registers has 4 bytes of space between them in most of the case they follow this standard, for example, if we see the MPU registers in the image below we can note that the next registers are 4 bytes spaced until finish the set of registers

![MPU](https://user-images.githubusercontent.com/48101913/88466608-13c32e80-ce9c-11ea-9dfc-d5881d833414.JPG)

In the first part of the code we are setting up the base address of ***Core Peripherals***, it is necessary because to access a specific register we just need to do the sum: BASE ADDRESS + OFFSET(wanted register). The ***LDR r0, =SysTick_BASE*** instruction holds the base address, and ***STR r1, [r0, #SysTick_CTRL]*** do the sum BASE ADDRESS + OFFSET and store it with the value into the ***R1*** that is 0x04, initially what we want in the register ***STCTRL*** is filling it with zeros and set the system clock as our clock source exactly such as the image below.

![STCTRL](https://user-images.githubusercontent.com/48101913/88621645-6278f000-d077-11ea-9e24-2ddbc05cec4b.PNG)
