TITLE Chapter 8            (ch08_fact_stub.asm)
; Program:     Chapter 8 factorial
; Description:
Comment !
Description: Write a nonrecursive version of the Factorial procedure
(Section 8.5.2) that uses a loop. Write a short program that
interactively tests your Factorial procedure. Let the user enter
the value of n. Display the calculated factorial.
!
; Student:     Johnathan Sot
; Date:        04/7/2015
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

.data
    msgInput BYTE "Enter the value of n to calculate "
    BYTE "the factorial (-1 to quit): ",0
    msgOutput BYTE "The factorial is: ",0
    factorialError  BYTE "Error: Result does not fit "
                    BYTE "in 32 bits.",0

.code
main3stub PROC

    L1:
        ; message to display
        mov edx, OFFSET msgInput
        call WriteString

        ; get an integer n from the user
        call ReadInt

        ; if n is -1, go quit
        cmp eax, -1
        je quit

        call _FactorialIterative
        ; EAX = n!

        ; if error, show factorialError message
        ; if error is incontered then a -2 will come back
        cmp eax, -2
        jne CORRECT
        mov edx, OFFSET factorialError
        call WriteString
        call crlf
        jmp Done

        ; if OK, display factorial
CORRECT:
        mov edx, OFFSET msgOutput
        call WriteString
        call WriteDec
        call crlf


Done:
        jmp L1

quit:

main3stub ENDP

;---------------------------------------------------
_FactorialIterative PROC USES ecx edx
;
; Calculates a factorial nonrecursively
; Receives: eax = value of n to calculate factorial
; Returns: eax = calculated factorial
;---------------------------------------------------
.code

    ; deal with base case
    mov ecx, 0
    mov ebx, eax
    mov eax, 1
    ; init

    ; For Loop as ecx = 0; ecx < eax; incrament ecx
Factorial_loop:

    inc ecx
    ; n - 1
    ; n * (n - 1)
    ; multiplies ecx and eax     eax = eax * ecx++
    mul ecx

    ; if out of range occurs
    ; go end_factorial
    ; after mult if carry is set
    jc end_factorial

    ; if counter > 1, go Factorial_loop
    cmp ecx, ebx
    jl Factorial_loop
    ret

end_factorial:
    mov eax, -2
    ret

_FactorialIterative ENDP

END main3stub
