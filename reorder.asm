;// BRIAN SUMNER
;// UCD CSCI2525-001
;// SPRING 2016
;// PA3->reorder.asm


COMMENT @
/*
1. reorder.asm

- rearranges the values of the following array into this order: 43, 2, 21. Use
only MOV and XCHG to accomplish the desired result. DO NOT use any
immediate values. Use only direct offset addressing to accomplish the goal. Be
as efficient as you can.

arrayD DWORD 2,21,43

*/
@


;// START
;// CLEAR REG
;// MOV REG,[ARRAYD + 4*2] --> 43 IN REG
;// XCHG REG,[ARRAYD + 4*0] --> 2 IN REG | ARRAY 43, 21, 43
;// XCHG REG,[ARRAYD + 4*1] --> 21 IN REG | ARRAY 43, 2, 43
;// XCHG REG,[ARRAYD + 4*2] --> 43 IN REG | ARRAY 43, 2, 21
;// END



TITLE reorder.asm

INCLUDE Irvine32.inc

.data
arrayD DWORD 2, 21, 43



.code
main PROC


	;// START
	
	;// CLEAR REG
	MOV EAX,0

	;// MOV REG,[ARRAYD + 4*2] --> 43 IN REG
	MOV EAX,[ARRAYD + 4*2]

	;// XCHG REG,[ARRAYD + 4*0] --> 2 IN REG | ARRAY 43, 21, 43
	XCHG EAX,[ARRAYD + 4*0]

	;// XCHG REG,[ARRAYD + 4*1] --> 21 IN REG | ARRAY 43, 2, 43
	XCHG EAX,[ARRAYD + 4*1]

	;// XCHG REG,[ARRAYD + 4*2] --> 43 IN REG | ARRAY 43, 2, 21
	XCHG EAX,[ARRAYD + 4*2]
	
	;// END


	CALL DUMPREGS

	EXIT

MAIN ENDP
END MAIN
