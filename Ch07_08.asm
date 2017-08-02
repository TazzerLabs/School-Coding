TITLE Chapter 7 Exercise 3              (ch07_03stub.asm)

; Program:     Chapter 7
Comment !
Description: Write a procedure named PackedToAsc that converts a
4-byte packed decimal number to a string of ASCII decimal digits.
Pass the packed number to the procedure in EAX, and pass a pointer
to a buffer that will hold the ASCII digits. Write a short test
program that demonstrates several conversions and displays the
converted numbers on the screen.
!
; Student:     Johnathan Soto
; Date:        03/18/2012
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

.data
numbers DWORD 87654321h, 45346894h, 193492h, 123h, 3h
buffer BYTE 8 DUP(1), 0   ; 8 digits plus null character

.code
main8stub PROC


; Prepare for LOOP
mov ecx, SIZEOF numbers
mov esi, OFFSET numbers
L1:
; Prepare pointer to buffer and packed decimal number
; Call _PackedToAsC to convert to ASCII digits
; Display string of digits
; ...
mov edx. buffer

mov eax, [esi]
DAA

call _PackedToAsC
call WriteString
call Crlf


; Get next number
add  esi, 4
loop L1

main8stub ENDP

;----------------------------------------------------------------
_PackedToAsc PROC
;
; procedure that converts a 4-byte packed decimal number
; to a string of ASCII decimal digits
; Receives: EAX, packed decimal number
;           EDX, pointer to a buffer with ASCII returned
; Returns: String of ASCII digits in buffer pointed by EDX
;------------------------------------------------------------------

rol eax, 8
mov [esi], eax

mov al, BYTE PTR [esi]  ; al = 12h  0001 0010
mov bl, BYTE PTR [esi]  ; bl = 12h  0001 0010
shr al, 4               ; al = 0000 0001
and bl, 00001111b;      ; bl = 0000 0010
add al, 48              ; convert to ascii
call WriteChar
mov al, bl
add al, 48              ; convert to ascii
call WriteChar



ret


_PackedToAsc ENDP


END main8stub