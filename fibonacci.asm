;// BRIAN SUMNER
;// UCD CSCI2525-001
;// SPRING 2016
;// PA3->fibonacci.asm



COMMENT @
/*
2. fibonacci.asm - computes the following.

a. Compute fib(n) for n = 2, 3, …, 6 using an array.

b. Store each computed value in an array of the appropriate size and type.

c. Store fib(3) through fib(6) in consecutive bytes of the ebx register
starting from the lowest byte; that is, fib(3) is stored in the low byte
(bl) of ebx, fib(4) is stored in the next byte (bh), fib(5) is stored in the
next byte of ebx and fib(6) is stored in the highest byte.

d. If you don’t know what the Fibonacci sequence is, there is a lot of
information online that you can find.

Notes

1. Assume fib(0)=0, fib(1)=1.

2. You may use any instruction/directive/operator through chapter 4 pg 128,
including any of the arithmetic operators +, *, /, -.

3. Your program must use indirect operands in some way as discussed in chapter 4.

4. Your program must make one call to DumpRegs before quitting to display the
ebx register.

5. Part of the program will be graded on the basis of program style. I reserve the
right to judge style as I deem fit for the assignment.
*/
@



;// FIB0 = 0, FIB1 = 1, FIB2 = 1, FIB3 = 2, FIB4 = 3, FIB5 = 5, FIB6 = 8


;// c.Store fib(3) through fib(6) in consecutive bytes of the ebx register
;// starting from the lowest byte; that is, fib(3) is stored in the low byte
;// (bl)of ebx, fib(4) is stored in the next byte(bh), fib(5) is stored in the
;// next byte of ebx and fib(6) is stored in the highest byte.


;// EBX LOOKS LIKE THIS:

;// EBH EBL  BH  BL
;//  08  05  03  02

;// RESULT EBX = 08050302




;// HERE'S HOW IT'S GOING DOWN
;//	PROBABLY



;// DATA/INIT: 


;// FIB0 = 0
;// FIB1 = 1
;// RESULT DWORD 0
;// FIBARRAY DWORD 5 DUP (0)
;// PRELOAD ECX, 3

;// MAIN
;// ADD [FIBARRAY], FIB0 + FIB1
;// MOV EBX, [FIBARRAY]
;// MOV [FIBARRAY + EBX], [FIBARRAY] + EBX
;// STOR RESULT, [FIBARRAY + EBX]
;// MOV ECX, 2
;// LOOPLABEL:
;// ADD EAX, EBX
;// INC EBX
;// MOV [FIBARRAY + EBX], EAX
;// MUL MULT, 100H
;// ADD RESULT, EAX * MULT
;// LOOP LOOPLABEL
;// XCHG EBX, RESULT




TITLE fibonacci.asm

INCLUDE Irvine32.inc


.DATA
FIBARRAY DWORD 5 DUP(0)
FIB0 = 0
FIB1 = 1
RESULT DWORD 0
MULT DWORD 1H
MULTCONST DWORD 100H
SWAP DWORD 0
PREV DWORD 0
PREVPREV DWORD 0


.CODE
MAIN PROC



;// CLEAR EBX JUST FOR FUN
MOV EBX, 0



;// ADD [FIBARRAY], FIB0 + FIB1
ADD[FIBARRAY], FIB0 + FIB1



;// SHOW F(2) IS IN [FIBARRAY] THROUGH EAX
MOV EAX, [FIBARRAY]
CALL DUMPREGS



;// MOV EBX, [FIBARRAY]
MOV EBX, [FIBARRAY]
MOV PREVPREV, EBX



;// MOV [FIBARRAY + EBX], [FIBARRAY] + EBX
MOV EAX, [FIBARRAY]
ADD EAX, PREVPREV
MOV [FIBARRAY + EBX], EAX
MOV PREV, EAX



;// SHOW F(3) IS IN [FIBARRAY + EBX] THROUGH EDX
MOV EDX, [FIBARRAY + EBX]
CALL DUMPREGS



;// STOR RESULT
MOV RESULT, EAX



;// MOV ECX, 3
MOV ECX, 3



;// LOOPLABEL:
LOOPLABEL:



;// ADD NEXT F(N+3)
MOV EAX, PREV
ADD EAX, PREVPREV
MOV EDX, PREV
MOV PREVPREV, EDX
MOV PREV, EAX



;// INC EBX
INC EBX



;// MOV [FIBARRAY + EBX], EAX
MOV [FIBARRAY + EBX], EAX



;// SHOW F(N+3) IS IN [FIBARRAY + EBX] THROUGH EDX
MOV EDX, [FIBARRAY + EBX]
CALL DUMPREGS



;// MUL MULT, 100H
MOV SWAP, EAX
MOV EAX, MULT
MUL MULTCONST
MOV MULT, EAX
MUL SWAP



;// ADD RESULT, EAX
ADD EAX, RESULT
XCHG RESULT, EAX



;// LOOP LOOPLABEL
LOOP LOOPLABEL



;// PUT FINAL RESULT IN EBX
XCHG EBX, RESULT



;// SHOW FINAL RESULT IS IN EBX
CALL DUMPREGS



EXIT



MAIN ENDP



END MAIN
