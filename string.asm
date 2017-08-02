;TITLE  Chapter 3, Problem 3 (string.asm)
; Program:     Chapter 3, Problem 1
; Description: calculates Res = (A + B) – (C + D), using registers and variables
; Student:     Johnathan Soto
; Date:        02/09/2015
; Class:       CSCI 241
; Instructor:  Mr. Ding

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data

Message1 BYTE 'string1', 0dh,0ah, 0
Message2 BYTE 'string2'
Message3 BYTE 'string3'

.code
main proc
				
mov CL, Message1
mov CH, Message2

	invoke ExitProcess,0
main endp
end main