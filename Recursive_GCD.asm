TITLE Chapter 8            (ch08_fact_stub.asm)
; Program:     Chapter 8 factorial
Comment !
Description: Write a recursive version of the GCD procedure.
Write a short program that
interactively tests your GCD procedure. Let the array enter
the value of n1 and n2. Display the calculated GCD.
!
; Student:     Johnathan Sot
; Date:        04/9/2015
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

.data
msgStart BYTE "GCD of ",0
msgMiddle BYTE " and ", 0
msgEnd   BYTE " is ", 0
array SDWORD 5,20, 24,18, 11,7, 438,226, 26,13
CalcGcd PROTO int1:DWORD, int2:DWORD
ShowResult PROTO int1:DWORD, int2:DWORD, gcd:DWORD

.code
    main4stub PROC
    mov ecx, 5
    mov esi, 0

L1:

    invoke CalcGcd, array[esi], array[esi+4]
    invoke ShowResult, array[esi], array[esi+4], eax
    add esi, 8

    loop L1

DONE:

main4stub ENDP

;---------------------------------------------------
CalcGcd PROC int1:DWORD, int2:DWORD
;---------------------------------------------------
; Calculate the greatest common divisor, of
;     two nonnegative integers in recursion.
; Receives: int1, int2
; Returns:  EAX = Greatest common divisor

    mov eax, int1
    cmp eax, int2
    jne  NEQUAL
    jmp Quit

NEQUAL:
    cmp eax, int2
    jg  RecM
    sub int2, eax
    invoke CalcGcd, eax, int2
    jmp Quit

    RecM:
    sub eax, int2
    invoke CalcGcd, eax, int2
    jmp Quit

Quit:
    ret

CalcGcd  ENDP
;---------------------------------------------------
ShowResult PROC int1:DWORD, int2:DWORD, gcd:DWORD
;---------------------------------------------------
; Show calculated GCD result as
;      "GCD of 5 and 20 is 5"
; Receives: int1, int2, gcd
; ---------------------------------------------------

    mov edx, OFFSET msgStart
    call WriteString
    mov eax, int1
    call WriteDec

    mov edx, OFFSET msgMiddle
    call WriteString
    mov eax, int2
    call WriteDec

    mov edx, OFFSET msgEnd
    call WriteString
    mov eax, gcd
    call WriteDec
    call Crlf

    ret

ShowResult ENDP


END main4stub


