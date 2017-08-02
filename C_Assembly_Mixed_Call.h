TITLE Worker.asm
.386
.model flat, C
.stack 2000

.data

intSqrt PROTO C, intVal: DOWORD

.code
isPrimeASM PROC inVal:DWORD

    ; TRUE  = 1
    ; FALSE = 0

    ; if (inVal < 2)

    mov ecx, 0

    mov eax, inVal
    cmp eax, 2
    jl FuncEnd


    ; fill is prime logic here...
    mov ebx, 1
    mov ecx, 1

    ;for (int divisor = 2; divisor <= sqrt(inVal); divisor++)

    INVOKE intSqrt, inVal
    mov  esi, eax                   ; EAX houses the return value of the functon call

    FORER:

    cmp ebx, 2
    jg  ADD2
    inc ebx
    jmp CHECKER

  ADD2:
    add ebx, 2

  CHECKER:
    cmp ebx, esi
    jg FuncEnd

    ;if ( inVal % divisor == 0 )
    xor edx, edx
    mov eax, inVal
    div ebx                        ; Get the remainder from div and store in edx

    cmp edx, 0                      ; edx is the (n % divisor)
    jne FORER
    mov ecx, 0
    jmp FuncEnd

  FuncEnd:

    ; The return is stored in eax
    mov eax, ecx

    ret

    isPrimeASM ENDP
    END isPrimeASM
