TITLE  Chapter 7 (Time.asm)

; Program:     Chapter 7
; Description: Get the time from a hexadecimal from user
; Student:     Johnathan Soto
; Date:        03/18/2012
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

.data
Prompt1	 BYTE "Please enter 16-bit hexadecimal (4-digit, e.g., 1207): ", 0
Prompt2	 BYTE "Your equivalent binary is ", 0
Prompt3	 BYTE "Your DOS file time is ", 0
Colon	 BYTE ":", 0

Check	BYTE  10
hour	BYTE  2 DUP(0)
minute	BYTE  2 DUP(0)
second	BYTE  2 DUP(0)


.code
    main1 proc

    ; Display Prompt1 and retrive user input
    mov edx, OFFSET Prompt1
    call WriteString
    call ReadHex

    ;eax holds the whole string from user



    ; Display Prompt2
    ;Conversion of the Hex to binary using BinB
    mov	 edx, OFFSET Prompt2
    call WriteString
    mov	 ebx, 2
    Call WriteBinB
    call Crlf

    ; Call Show FILE
    call ShowFileTime

    exit
    main1 endp

; ========================================================
ShowFileTime PROC
; Input: ax holding the
;
; OutPut: To Screen a result of the binary in time format
;
; Description:  Just get binary value of the ax and go
;				through to change it into a DOS TIME
; =========================================================

    ; Display Prompt
    mov edx, OFFSET Prompt3
    call WriteString

    ; Copy of the ax reg and will be used in the
    ; rest of this function
    mov  bx, ax

;---Hours---------------------
    shr ax, 11                  ; Shift to the right 11 times to clear right side
    mov hour, al

    cmp al, 9                   ; Compare al to 9 and if greater goto end
    jng  Zero
    jmp Back
    Zero: mov eax, 0			; jump if lower than 10 else Jump to end
    call WriteDec
    jmp Back

    Back:
    mov eax, DWORD PTR hour
    call WriteDec               ; Display the hours

    mov edx, OFFSET Colon       ; Display a colon
    call WriteString

;---End of Hours section------

;---Minutes-----------------
    mov ax, bx
    shr ax, 5
    and al, 00011111b
    mov minute, al

    cmp al, 9
    jng  Zero2
    jmp Back2
    Zero2: mov eax, 0
    call WriteDec
    jmp Back2

    Back2:
    mov eax, DWORD PTR minute
    call WriteDec

    mov edx, OFFSET Colon
    call WriteString

;---End of Minutes Section---------

;----Seconds-----------------------
    mov ax, bx
    and al, 00011111b
    shl al, 1
    mov second, al

    cmp al, 9
    jng  Zero3
    jmp Back3
    Zero3: mov eax, 0
    call WriteDec
    jmp Back3

    Back3:
    mov eax, DWORD PTR second
    call WriteDec

;---End of Seconds------------------

    call Crlf           ; Enter a newLine

    ret                 ; Return to Caller

    ShowFileTime ENDP
; End Of ShowFileTime

end main1