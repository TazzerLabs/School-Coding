TITLE Worker.asm
; Is Prime assembly file       (C_Assembly_Mixed_Call_ASM.asm)
.model flat, C

intSqrt PROTO C, squareN:DWORD

.data

.code

isPrimeASM PROC C, n:DWORD

    ; TRUE  = 1
    ; FALSE = 0


    ; If (n < 2)
    ;    return false

    mov eax, 0
    xor edx, edx		; clear edx
    CMP n, 2
    JL FuncEnd

    cmp n, 3			; in n == 2 or 3, go to Prime
    JLE PRIME

    mov ebx, 2
    mov eax, n			; reset eax as n
    div ebx
    mov eax, 0
    cmp edx, 0          ; Check if n / 2 == 0
    JE FuncEnd

    INVOKE intSqrt, n   ; eax = sqrt(n)
    mov ecx, eax		; ecx =  sqrt (n)
    mov eax, n          ; User input set to eax
    mov ebx, 3

  FORER:

    ; If (n % divisor == 0)

    xor edx, edx		;clear edx for proper division

    div ebx
    cmp edx, 0
    JNE GOOD			;if a remainder, inc ebx (divisor) and loop

    ; else set the return to false and exit

    mov eax, 0
    JMP FuncEnd

  GOOD:

    mov eax, n
    ADD ebx, 2
    cmp ebx, ecx        ; for (divisor = 2; divisor <= sqrt(n); ++divisor)
    JLE FORER

  PRIME:

    mov eax, 1          ; RETURN TRUE

  FuncEnd:

    ret

isPrimeASM ENDP

END