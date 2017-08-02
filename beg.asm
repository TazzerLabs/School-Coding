//
//  beg.asm
//  
//
//  Created by Johnathan Soto on 2/13/15.
//
//

#include "beg.h"

;TITLE  Chapter 3, Problem 1 (Integer_Expression.asm)
; Program:     Chapter 3, Problem 1
; Description: calculates Res = (A + B) – (C + D), using registers and variables
; Student:     James Hope
; Date:        02/09/2015
; Class:       CSCI 241
; Instructor:  Mr. Ding

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
; define variables: varA, varB, varC, varD, and Res
varA DWORD 10
varB DWORD 20
varC DWORD 30
varD DWORD 40
Res	 DWORD ?

.code
main1 proc

; calculate Res = (A + B) – (C + D)
; calculate A + B
mov eax, varA
add eax, varB

; calculate C + D
mov edx, varC
add edx, varD

; calculate (A + B) – (C + D)
sub eax, edx
; save the result in Res
mov Res, eax

;
invoke ExitProcess,0
main1 endp
end main1
