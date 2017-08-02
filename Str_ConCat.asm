TITLE Chapter 9           (Str_ConCat.asm)
; Program:     Chapter 9 ConCat
Comment !
Description: Write a program that concats two string together
from source to destination.  This program will act
just like strcat function in c++.  if dest= "abcde"
and source = "12345" then strcat = "abcde12345".
Make sure to have enough room in the new
!
; Student:     Johnathan Soto
; Date:        04/14/2015
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

.data

    targetStr   BYTE 80 DUP(?)
    sourceStr   BYTE 80 DUP(?)
    Str_concat  PROTO CString:PTR BYTE, EString:PTR BYTE
    Prompt1		BYTE "Enter a string: ", 0
    Con			BYTE "The string concatenated: ", 0

.code

mainstub PROC

    mov edx, OFFSET Prompt1
    call WriteString

    mov  edx,OFFSET targetStr
    mov  ecx, 80
    call ReadString

    mov edx, OFFSET Prompt1
    call WriteString
    mov  edx,OFFSET sourceStr
    mov  ecx, 80
    call ReadString

    INVOKE Str_concat, ADDR targetStr, ADDR sourceStr

    mov edx, OFFSET Con
    call WriteString
    mov edx, OFFSET targetStr
    mov ecx, edi
    call WriteString
    call Crlf

mainstub ENDP

; ---------------DESTINATION--------SOURCE-----------------------
Str_concat PROC CString:PTR BYTE, EString:PTR BYTE
;
; Description: Just concat the two strings together into CString
;
; Recieves: Ptr to a Bytes: CString & EString
;
; ---------------------------------------------------------------


    cld
    mov edi, CString					;Get the address of dest and source
    mov esi, EString
    xor ecx,ecx							; clear ecx for loop
    invoke Str_length, CString
    add edi,eax                             ;Found the end of Dest and now go to it

    ; While Source does not equal 0 (indicating end of string)

 looper:
    lodsb								; load AL and inc esi
    stosb								; write AL to dest and inc EDI
    cmp al, 0							; Are we done yet? Nope? Continue
    jne looper

    ;END OF WHILE

    ret


Str_concat ENDP


END mainstub