
; Chapter 6 example.

INCLUDE Irvine32.inc

KEY = 239     	; any value between 1-255
BUFMAX = 128     	; maximum buffer size

.data
sPrompt  BYTE  "Enter the plain text: ",0
sEncrypt BYTE  "Cipher text:          ",0
sDecrypt BYTE  "Decrypted:            ",0

buffer   BYTE   BUFMAX dup(0)
bufSize  DWORD  ?

.code
main PROC

call InputTheString		; input the plain text
call TranslateBuffer		; encrypt the buffer
mov  edx,OFFSET sEncrypt		; display encrypted message
call DisplayMessage
call TranslateBuffer  		; decrypt the buffer
mov  edx,OFFSET sDecrypt		; display decrypted message
call DisplayMessage

exit
main ENDP

;-----------------------------------------------------
InputTheString PROC
;
; Asks the user to enter a string from the
; keyboard. Saves the string and its length
; in variables.
; Receives: nothing. Returns: nothing
;-----------------------------------------------------
pushad                      ; PUSHES ALL 32 Bit Registers

mov  edx,offset sPrompt		; display a prompt   "Enter the plain text",0 NO ENDl

call WriteString               ; Gets the edx register and dsplays the above prompt

mov  ecx,BUFMAX         		; maximum character count For the loop inside the ReadString function

mov  edx,offset buffer   	; point to the buffer

call ReadString         		; input the string into buffer from edx

mov  bufSize,eax        		; save the length eax will house how many characters entered in from READSTRING

call Crlf                       ;Calls the endl function

popad                           ; Pop the registers back into the original postions of last push

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
pushad
mov  ecx,bufSize		; loop counter
mov  esi,0		; index 0 in buffer
L1:
xor  buffer[esi],KEY		; translate a byte  KEY 239
                        ;       1000 0000b       128d 80h
                         ;XOR   1110 1111b      :KEY 239d
                            ;   ---------
                            ;   0110 1111b     :RES: 111d 6Fh

inc  esi		; point to next byte
loop L1

popad
ret
TranslateBuffer ENDP
END main