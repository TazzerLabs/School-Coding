TITLE  Chapter 4, zd supplied (Fibonacci_Numbers.asm)

; Program:     Chapter 4, supplementary exercise
; Description: Fibonacci algorithm in Assembly
; Student:     Johnathan Soto
; Date:        02/17/2015
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

.data
array BYTE 12 DUP(?)

.code
main proc

mov ecx, 12				;loop counter
mov esi, OFFSET array	;pointer to incrament through for array
mov ah, 1				;Initial values
mov al, 0
L1:						;Loop start
add ah, al			;add the two reg
mov [esi] , ah			;move the result to the array
inc esi					;Incrament to next point in array
xchg al, ah			;exchange the the two values with each other to continu.
Call DumpRegs			;displaying registers
loop L1

mov esi, OFFSET array		;displaying memory
mov ebx, 1
mov ecx, SIZEOF array
call dumpMem

invoke ExitProcess,0
main endp

end main