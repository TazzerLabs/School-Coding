TITLE Random_Color_Char_Screen_Fill

; Program:     	Initialize_Linked_List (Chapter 10, Supplied)
; Description: 	This program fills each screen cell with a 
;				random character, in a random color.
; Student:		Alyssa Andrade
; Date:        	05/06/2015
; Class:       	CSCI 241
; Instructor:  	Mr. Ding

INCLUDE Irvine32.inc

.data
outHandle    HANDLE ?
cellsWritten DWORD ?
xyPos COORD  <0,0>

; Array of character codes:
BufferChar 	BYTE 50 DUP(?),0dh,0ah
MAXCOL 		DWORD ($-BufferChar)
; Array of color codes:
BufferColor 	WORD 50 DUP(?)

.code
;---------------------------------------------------
ChooseColor PROC
; Selects a color with a 50% probability of red, a 25% of green and 25% of yellow
; Receives: nothing
; Returns:  EAX = randomly selected color
;---------------------------------------------------
.data
randomNumbers DWORD ?

.code
		mov  eax,4     			;get random 0 to 3
		call RandomRange
		mov  randomNumbers,eax  		;save random number

		.IF randomNumbers == 0			; Set text green
			mov  eax,green+(black*16)
		.ELSEIF randomNumbers == 1		; Set text yellow
			mov  eax,yellow+(black*16)
		.ELSE 					; Set text red
			mov  eax,red+(black*16)
		.ENDIF

	ret
ChooseColor ENDP

;---------------------------------------------------
ChooseCharacter PROC
; Randomly selects an ASCII character
; Receives: nothing
; Returns:  AL = randomly selected character, from ASCII code 20h to 07Ah 
;---------------------------------------------------
.data
randomChar DWORD ?

.code
		mov  eax,90     			;get random 0 to 89
		call RandomRange
		add  eax, 33				;new range 32 to 122
		mov  randomChar,eax  ;save

	ret
ChooseCharacter ENDP

;---------------------------------------------------
main PROC
;---------------------------------------------------
mov ecx, 20

; Get the Console standard output handle:
	INVOKE GetStdHandle,STD_OUTPUT_HANDLE
	mov outHandle,eax

OuterL:
; Initialize array of colors and characters
	mov  ebx, ecx
	mov  ecx, 50
	mov  esi, OFFSET BufferColor
	mov  edi, OFFSET BufferChar

	InnerL:

        ; Getting the random Colors and Characters till
        ; there is 50 colors and characters
		call	ChooseColor
			mov  [esi], ax

		call	ChooseCharacter
			mov  [edi], al

		add esi, 2
		inc edi

    loop InnerL         ; Loop till 50 random characters and colors have been achieved

; Set the colors
	INVOKE WriteConsoleOutputAttribute, outHandle, ADDR BufferColor, MAXCOL, xyPos,ADDR cellsWritten
	
; Write character codes	
	INVOKE WriteConsoleOutputCharacter, outHandle, ADDR BufferChar, MAXCOL, xyPos, ADDR cellsWritten
    mov edi, OFFSET xyPos
    inc (COORD PTR [edi]).Y

    ; For outerLoop
	mov ecx, ebx		;re-initialize outer loop

    loop OuterL    ; Loop till 20 lines have been achieved


    ; Setting exit to appear after the block of Random
    mov  dl,0  ;column
    mov  dh,20  ;row
    call Gotoxy

	exit
main ENDP
END main