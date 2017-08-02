TITLE  Chapter 4, zd supplied (SwapValues.asm)

; Program:     Chapter 4, supplementary exercise
; Description: Swap four DWord values, e.g.: from 1, 2, 3, 4 to 2, 4, 1, 3
; Student:     Johnathan Soto
; Date:        02/09/2012
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
.data
dwArray	DWORD 1000h, 2000h, 3000h, 4000h

.code
; Fill the requirement to swap DWORD elements in dwArray
SwapValues PROC
; Show original data
call Display

; fill here, no more than 5 instructions
mov eax, dwArray			;eax 1 a:? 2 3 4
xchg eax, [dwArray+8]		;eax 3 a:? 2 1 4
xchg eax, [dwArray+12]		;eax 4 a:? 2 1 3
xchg eax, [dwArray+4]		;eax 2 a:? 4 1 3
mov dwArray, eax			;eax ? a:2 4 1 3

; Show swapped data
call Display
exit
SwapValues ENDP

; A procedure to show dwArray memory by calling DumpMem
Display PROC
mov esi, offset dwArray
mov ebx, type dwArray
mov ecx, lengthof dwArray
call DumpMem
ret

Display ENDP
END SwapValues
