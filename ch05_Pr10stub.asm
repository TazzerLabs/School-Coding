TITLE Chapter 5 Exercise 10              (ch05_Pr10stub.asm)

Comment @
Using Programming Exercise 6 in Chapter 4 as a starting point,
write a program that generates the first 47 values in the Fibonacci
series, stores them in an array of doublewords, and writes the
doubleword array to a disk file.
@

INCLUDE Irvine32.inc

FIB_COUNT = 47	; number of values to generate

.data
fileHandle DWORD ?
filename BYTE "fibonacci.bin",0
array DWORD FIB_COUNT DUP(?)

.code
main2sub PROC

; Generate the array of values

mov esi, OFFSET array
mov ecx, LENGTHOF array
call	generate_fibonacci

; Create the file, call CreateOutputFile
mov  edx,OFFSET filename
call CreateOutputFile
mov  fileHandle, EAX


; Write the array to the file, call WriteToFile
mov  eax,fileHandle
mov  edx,OFFSET array
mov  ecx,FIB_COUNT*4
call WriteToFile

; Close the file, call CloseFile
mov  eax,fileHandle
call CloseFile


exit
main2sub ENDP

;------------------------------------------------------------
generate_fibonacci PROC USES eax ebx ecx edx
;
; Generates fibonacci values and stores in an array.
; Receives: ESI points to the array,
;           ECX = count
; Returns: nothing
;--------------------------------------------------------


mov eax, 1				;Initial values
mov ebx, 0
L1:						;Loop start
add eax, ebx			;add the two reg
mov [esi] , eax			;move the result to the array
call WriteDec
call Crlf
inc esi					;Incrament to next point in array
xchg ebx, eax			;exchange the the two values with each other to continu.

loop L1


ret
generate_fibonacci ENDP

END main2sub