TITLE Show_Date_Time_of_File  (Show_Date_Time_of_File.asm)

; Program:     	Show_Date_Time_of_File (Chapter 11, Supplied)
; Description:  Gets the file time for the program
; Student:		Johnathan Soto
; Date:        	05/12/2015
; Class:       	CSCI 241
; Instructor:  	Mr. Ding
; Comment: The extraction of the file time is reading in incorrect as well as
;          getting the specified timezone.  Will work on later but sending in what I have now
;          for partial points

INCLUDE Irvine32.inc



.data


filename BYTE 50 DUP (?)
fileHandle HANDLE ?

sysTimeCreated SYSTEMTIME <>
sysTimeLastWritten SYSTEMTIME <>

Prompt1  BYTE "Input your file name: ", 0
Creation BYTE " was created on: ", 0
Last     BYTE "And it was last written on: ", 0
ERROR    BYTE "Error getting file handle check file!", 0

SystemTimeToTzSpecificLocalTime PROTO,
lpTimeZone:DWORD,
lpUniversalTime:PTR SYSTEMTIME,
lpLocalTime:PTR SYSTEMTIME

WriteDateTime2 PROTO datetimeAddr: SYSTEMTIME

.code
main PROC

mov edx, OFFSET Prompt1
call WriteString

mov	edx, OFFSET filename
mov	ecx, 49
call ReadString

mov	esi, OFFSET sysTimeCreated
mov	edi, OFFSET sysTimeLastWritten
call AccessFileDateTime
jc   DONE

; Show filename then Creation then the date and time it was written
mov edx, OFFSET filename
call WriteString
mov edx, OFFSET Creation
call WriteString
INVOKE WriteDateTime2, sysTimeCreated

; Show Last
mov edx, OFFSET Last
call WriteString

; Show last time it was edited
INVOKE WriteDateTime2, sysTimeLastWritten

Done:
    call Crlf
    exit

main ENDP

; ----------------------------------------------------------------------------------------------
; Receives: EDX offset of filename,
;           ESI points to a SYSTEMTIME structure of sysTimeCreated
;           EDI points to a SYSTEMTIME structure of sysTimeLastWritten
; Returns: If successful, CF=0 and two SYSTEMTIME structures contain the file's date/time data.
;          If it fails, CF=1.
; ----------------------------------------------------------------------------------------------
AccessFileDateTime PROC

; Get the File Handle
call OpenInputFile
mov  fileHandle, EAX
cmp eax, INVALID_HANDLE_VALUE
je FAIL

; Get the File Time for when it was created and last edited
INVOKE GetFileTime, fileHandle, ESI, NULL, EDI


;INVOKE SystemTimeToTzSpecificLocalTime, 0, 0, ESI
;INVOKE SystemTimeToTzSpecificLocalTime, 0, 0, EDI

FAIL:
; If failed then set carry flag
mov edx, OFFSET ERROR
call WriteString
call Crlf
stc

FINISH:
ret

AccessFileDateTime ENDP

; ----------------------------------------------------------------------------------------------
WriteDateTime2 PROC datetimeAddr: SYSTEMTIME
;
; INPUT: A SYSTEMTIME structure that we are going to display the date and time
;
; OUTPUT: NOTHING
;
; DESCRIPTION: Just display to the screen the date and time
;
; ----------------------------------------------------------------------------------------------

mov ax, datetimeAddr.wMonth
call WriteDec

mov al, '/'
call WriteChar

mov ax, datetimeAddr.wDay
call WriteDec

mov al, '/'
call WriteChar

mov ax, datetimeAddr.wYear
call WriteDec

mov al, ' '
call WriteChar

mov ax, datetimeAddr.wHour
call WriteDec

mov edx, ':'
call WriteString

mov ax, datetimeAddr.wMinute
call WriteDec

mov al, ':'
call WriteString

mov ax, datetimeAddr.wSecond
call WriteDec

call Crlf

WriteDateTime2 ENDP

END main