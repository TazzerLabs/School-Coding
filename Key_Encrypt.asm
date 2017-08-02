TITLE  Chapter 6, Problem ? (Multi-Key_Encryption.asm)

; Program:     Multi-Key Encryption
; Description: Gets user key and string and encrypts/decrypts for the user
; Student:     Johnathan Soto
; Date:        03/12/2015
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

BUFMAX = 128     	; maximum buffer size

.data
prompt1  BYTE  "Enter the plain text: ",0
prompt2  BYTE  "Enter the encryption key: ",0
sEncrypt BYTE  "Cipher text:         ",0
sDecrypt BYTE  "Decrypted:           ",0

keyStr   BYTE   BUFMAX+1 DUP(0)
keySize  DWORD  ?
buffer   BYTE   BUFMAX+1 DUP(0)
bufSize  DWORD  ?

.code
main1 PROC
mov edx,OFFSET prompt1  ; display buffer prompt
mov ebx,OFFSET buffer   ; point to the buffer
call InputTheString
mov bufSize,eax         ; save the buffer length

mov edx,OFFSET prompt2  ; display key prompt
mov ebx,OFFSET keyStr   ; point to the key
call InputTheString
mov keySize,eax         ; save the key length

call TranslateBuffer		; encrypt the buffer
mov  edx,OFFSET sEncrypt		; display encrypted message
call DisplayMessage
call TranslateBuffer  		; decrypt the buffer
mov  edx,OFFSET sDecrypt		; display decrypted message
call DisplayMessage


exit
main1 ENDP

;-----------------------------------------------------
InputTheString PROC
;
; Asks the user to enter a string from the
; keyboard. Saves the string and its length
; in variables.
; Receives: nothing. Returns: nothing
;-----------------------------------------------------

call WriteString               ; Gets the edx register and dsplays the above prompt

mov  ecx,BUFMAX         		; maximum character count For the loop inside the ReadString function
mov  esi, OFFSET buffer

cmp  esi, ebx
jne  UKey
mov  edx,offset buffer          ; point to the buffer
jmp quit
UKey:	mov edx, offset keyStr
jmp quit
quit:
call ReadString


call Crlf                       ;Calls the endl function

ret                             ; Return to caller

InputTheString ENDP             ; End the function use and release

;-----------------------------------------------------
DisplayMessage PROC
;
; Display the encrypted or decrypted message.
; Receives: EDX points to the message
; Returns:  nothing
;-----------------------------------------------------
pushad
call WriteString
mov  edx,offset buffer		; display the buffer
call WriteString
call Crlf
call Crlf
popad
ret
DisplayMessage ENDP

;-----------------------------------------------------
TranslateBuffer PROC
;
; Translates the string by exclusive-ORing each byte
; with the same integer.
; Receives: nothing.  Returns: nothing
;-----------------------------------------------------

mov  ecx,bufSize		; loop counter
mov  esi,OFFSET buffer		; index 0 in buffer
mov  eax, DWORD PTR keyStr

L1:
xor  [esi], eax			; translate a byte  KEY

inc  esi		; point to next byte
loop L1


ret

TranslateBuffer ENDP
END main1