TITLE Drunkard's Walk 					(Walk2.asm)

; Program:     Chapter 10, Drunkard
; Description: ; Drunkard's walk program. The professors starts at
; coordinates 25,25 and wanders around the immediate area.
; EDIT: CREATE A ShowPath PROC THAT WILL PUT 'O' AT INITIAL TOUCH DOWN
;       AND '*' AT EACH STEP AFTERWARDS
; Student:     Johnathan Soto
; Date:        04/23/2015
; Class:       CSCI 241
; Instructor:  Mr. Ding



INCLUDE Irvine32.inc
WalkMax = 23
StartX = 39
StartY = 10

DrunkardWalk STRUCT
    path COORD WalkMax DUP(<0,0>)
    pathsUsed WORD 0
DrunkardWalk ENDS

DisplayPosition PROTO currX:WORD, currY:WORD

.data
    aWalk DrunkardWalk <>
    UPrompt		BYTE "How many steps the Drunkard to move: ", 0
    Starter		BYTE "O", 0
    Movers		BYTE "*", 0

.code
main PROC

    mov	esi,OFFSET aWalk

    ;ask for user input for # of steps to take call ReadDec  Save in obj aWalk pathsUsed
    ; so save result in aWalk.pathsUsed   mov aWalk.pathsUsed, eax
    mov		edx, OFFSET UPrompt
    call	WriteString
    call	ReadDec
    mov		aWalk.pathsUsed, ax

    call	TakeDrunkenWalk
    call	crlf
    call	WaitMsg
    mov     ax, aWalk.pathsUsed
    mov     ecx, eax
    call    ShowPath                            ;Have delay in ShowPath 1 second delay
    call    crlf
    exit
main ENDP

;-------------------------------------------------------
TakeDrunkenWalk PROC
LOCAL currX:WORD, currY:WORD
;
; Take a walk in random directions (north, south, east,
; west).
; Receives: ESI points to a DrunkardWalk structure
; Returns:  the structure is initialized with random values
;
; EDIT: DO NOT ALLOW FOR (39,10) TO BE STEPPED ON AFTER
;       INITIAL TOUCH DOWN.  DIAGNOAL MOVES SHOULD NOT OCCUR
;
;-------------------------------------------------------
pushad

    ; Use the OFFSET operator to obtain the address of
    ; path, the array of COORD objects, and copy it to EDI.
    mov	edi,esi
    add	edi,OFFSET DrunkardWalk.path
    mov ecx, eax

    mov	currX,StartX		; current X-location
    mov	currY,StartY		; current Y-location

 Again:

    ; Insert current location in array.
    mov	ax,currX

    mov	(COORD PTR [edi]).X,ax
    mov	ax,currY
    cmp ax, 10
    mov	(COORD PTR [edi]).Y,ax

    INVOKE DisplayPosition, currX, currY

 TryHard:
    mov	eax,4		; choose a direction (0-3)
    call	RandomRange

    .IF eax == 0		; North
    dec currY
    .ELSEIF eax == 1	; South
    inc currY
    .ELSEIF eax == 2	; West
    dec currX
    .ELSE			; East (EAX = 3)
    inc currX
    .ENDIF

    cmp currY, 10
    jne Good
    cmp currX, 39
    jne Good

    ; Only executes if (39,10)
    .IF eax == 0		; North
    inc currY
    .ELSEIF eax == 1	; South
    dec currY
    .ELSEIF eax == 2	; West
    inc currX
    .ELSE			; East (EAX = 3)
    dec currX
    .ENDIF
    jmp TryHard

    Good:

    add	edi,TYPE COORD		; point to next COORD

    dec ecx
    cmp ecx, 0
    je Finish
    jmp Again

 Finish:
    popad
    ret
TakeDrunkenWalk ENDP

;-------------------------------------------------------
DisplayPosition PROC currX:WORD, currY:WORD
; Display the current X and Y positions.
; EDIT TO HAVE STEPS (X,Y) DISPLAYED HORIZONTALLY LIKE:
; (23,50) (24,50) ...
;
;-------------------------------------------------------
.data
    commaStr BYTE ",",0
    RParent	 BYTE " (", 0
    LParent	 BYTE ") ", 0
.code
    pushad
    mov	 edx, OFFSET RParent
    call	 WriteString
    movzx eax,currX			; current X position
    call	 WriteDec
    mov	 edx,OFFSET commaStr	; "," string
    call	 WriteString
    movzx eax,currY			; current Y position
    call	 WriteDec
    mov	 edx, OFFSET LParent
    call	 WriteString
    popad
    ret
DisplayPosition ENDP


; -----------------------------------------------------------
ShowPath PROC
;
; Recieves: array and also the pathUsed
; Returns: Nothing
; Descrip: Just display the the drunk person's movement
;
; -----------------------------------------------------------

    pushad
    ;Set ecx same as the one in calc but -1

    mov	edi,esi
    add	edi,OFFSET DrunkardWalk.path

    ;Display initial start "O"

    mov  dl,39  ;column x

    mov  dh,10  ;row y
    call Gotoxy

    mov al, 'O'
    call	WriteChar

    mov  eax,500	;delay 1 sec
    call Delay

    dec ecx

 Looper:

    add edi, TYPE COORD
    mov  dl,DrunkardWalk.path[edi]  ;column x
    mov  dh,DrunkardWalk.path[edi+2]

    call Gotoxy

    ;Display "*"
    mov al, '*'
    call	WriteChar

    mov  eax,500	;delay 1 sec
    call Delay

    loop looper

    popad

    ret

ShowPath ENDP

END main