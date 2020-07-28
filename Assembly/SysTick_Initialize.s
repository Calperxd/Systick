SysTick_BASE    EQU 0xE000E000
SysTick_CTRL    EQU 0x00000010
SysTick_LOAD    EQU 0x00000014
SysTick_VAL     EQU 0x00000018
SCB_BASE        EQU 0xE000ED00
SCB_SHP         EQU 0x00000D20
;-------------------------------------------------------------------------------------------
		AREA  DATA, ALIGN=2

TimeDelay	SPACE 4

;-------------------------------------------------------------------------------------------
;Enable thumb instructions
	THUMB                                                 		
    AREA  |.text|, CODE, READONLY, ALIGN=2

;|.text| - make assembly code callable in C 
;CODE - Stores the bellow code in ROM
;READONLY - Cannot be modified during the runtime
;ALIGN=2 - skips 0 or 1 byte to make next halfword aligned

;Make the fuction SysTick_Initialize callable from other files
    EXPORT SysTick_Initialize
    EXPORT SysTick_Handler
    EXPORT delay

;The begining of the function
SysTick_Initialize          PROC

;Inform the base address to access each part of register SysTick,
    LDR r0, =SysTick_BASE    
;Disable SysTick IRQ and SysTick counter, select external clock
    MOV r1, #0
    STR r1, [r0, #SysTick_CTRL]
;Specify the number of clock cycles between two interrupts
    LDR r2, =262
    STR r2, [r0, #SysTick_LOAD]
;Clear SysTick current value register (SysTick_VAL)
    MOV r1, #0
    STR r1, [r0, #SysTick_VAL]
;Set interrupt priority for SysTick
    LDR r2, =SCB_BASE
    ADD r2, r2, #SCB_SHP
    MOV r3, #1<<4
    STRB r3, [r2,#11]
;Set SysTick_CTRL to enable SysTick timer and SysTick interrupt
    LDR r1, [r0, #SysTick_CTRL]
    ORR r1, r1, #3
    STR r1, [r0, #SysTick_CTRL]

    BX lr
    ENDP
;-------------------------------------------------------------------------------------------
SysTick_Handler PROC
    SUB r10, r10, #1
    BX  lr
	ENDP
;-------------------------------------------------------------------------------------------
delay PROC
;Make a copy of TimeDelay
    MOV r10, r0
loop
;Wait for TimeDelay = 0
    CMP r10, #0
;r10 is descreased periodically by SysTick_Handler
    BNE loop
    BX lr
    ENDP
;-------------------------------------------------------------------------------------------
    ALIGN
    END
