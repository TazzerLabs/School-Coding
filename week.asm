;TITLE  Chapter 3, Problem 2 (a.asm)
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
monday DWORD 0
tuesday DWORD 1
wednesday DWORD 2
thursday DWORD 3
friday DWORD 4
saturday DWORD 5
sunday DWORD 6
week DWORD monday, tuesday, wednesday, thursday, friday, saturday, sunday
ListSize = ($ - week)
.code
main1 proc

mov eax, week

invoke ExitProcess,0
main endp
end ;main1