TITLE  Chapter 7 (GCD.asm)

; Program:     Chapter 7
; Description: Get two variables from users to identify the GCD
; Student:     Johnathan Soto
; Date:        03/18/2012
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

.data

Prompt1	 BYTE "Enter a 32 bit number: ", 0
Prompt2  BYTE "Greatest common divisor is: ", 0
BPrompt  BYTE "Invalid input, please enter again",0

.code

main2 proc

    call GetInp
    mov ebx, eax				;ebx houses the first user input

    call GetInp
    call CalcGcd

    mov edx, OFFSET Prompt2
    call WriteString
    call WriteDec

    exit
main2 endp

; =================================================
GetInp PROC
; Input: eax to house the integer the user enters
;
; OutPut: eax with integer user enters input
;
; Description: Just use WriteInt to get user input
;              if bad then just loop till they get
;              it right.
; =================================================

    ; Display Prompt1 and retrive user input
    mov edx, OFFSET Prompt1
    call WriteString

    read:  call ReadInt
    jno  goodInput

    mov  edx,OFFSET BPrompt
    call WriteString
    jmp  read        ;go input again

    goodInput:
        ret

GetInp ENDP


; =======================================================
CalcGcd PROC
; Input: eax and ebx to see what the GCD is
; OutPut: Eax with the GCD
;
; Description: Just compute the GCD from the two registers
; ========================================================

    ; Check to see if it is a negative
    cmp eax, 0
    jnl Con
    neg eax

    Con:
     cmp ebx, 0
     jnl Looper

    neg ebx

   Looper:
     ; WHILE

    L1:
        cmp eax, ebx
        je Zero                 ;break if they are equal

        cmp eax, ebx
        jg Big                  ;Jump if eax is bigger else xchg
        xchg eax, ebx

        Big:					;eax is bigger
            sub eax, ebx

    jmp L1
    ; END OF WHILE

    Zero:
        ret						;return eax
CalcGcd ENDP

end main2
