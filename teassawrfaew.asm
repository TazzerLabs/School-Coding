INCLUDE Irvine16.inc
.data
prompt	BYTE "What is the plain text file: ", 0ah	;asks for the plain text file
prompt2	BYTE "What is the name of the encrypted text file: ", 0ah	;asks for the encrypted text file
prompt3	BYTE "What is the encryption code (1 to 255): ", 0ah	;asks for the encryption code
output	BYTE "Plaintext: ", 0ah	;outputs the unencryption text
output2	BYTE "Encryption text: ", 0ah	;outputs the encryption text
newline	BYTE 0ah	;next line
input	BYTE 80 DUP(0)	;stores the plain text file name
input2	BYTE 80 DUP(0)	;stores the encryption file name
input3	BYTE 0	;stores the encryption key
bytesRead	WORD ?	;stores number of bytes in the input
inHandle	WORD ?	;stores the file handle input
outHandle	WORD ?	;stores the file handle output
BufferSize = 1000	;determines the max text file size
Buffer	BYTE bufferSize DUP(?)	;stores an array of characters

.code
main PROC
mov ax, @data	;used because of variables
mov ds, ax	;places ax into ds

; ask for the file name
mov ah, 40h	;sets the output array
mov cx, LENGTHOF prompt	;copies LENGTHOF to CX
mov dx, OFFSET	prompt	;moves the OFFSET of the string to dx
int 21h	;call MS-DOS

; reads the user's input
mov ah, 3Fh	;sets the read array
mov bx, 0	;mode = read-only
mov cx, 80	;max character is 80
mov dx, OFFSET input	;saves the input into dx
int 21h	;call MS-DOS

; asks for cypher text file
mov ah, 40h	;sets the output array
mov cx, LENGTHOF prompt2	;copies LENGTHOF to cx
mov dx, OFFSET	prompt2	;moves OFFSET of the string to dx
int 21h	;call MS-DOS

; reads the user's input
mov ah, 3Fh	;sets the read array
mov bx, 0	;mode = read-only
mov cx, 80	;max character is 80
mov dx, OFFSET input2	;saves the input into dx
int 21h	;call MS-DOS

; asks for the encryption key
mov ah, 40h	;sets the output array
mov cx, LENGTHOF prompt3	;copies the LENGTHOF to cx
mov dx, OFFSET prompt3	;moves OFFSET of the string to dx
int 21h	;call MS-DOS

; reads the encryption key
mov al, 0	;al is starts at 0
call ReadInt	;read signed integers
mov input3, al	;copies the input in al to input3

; output "Plaintext text: "
mov ah, 40h	;sets the output array
mov cx, LENGTHOF output	;copies the LENGTHOF to cx
mov dx, OFFSET	output	;moves OFFSET of the string to dx
int 21h	;call MS-DOS

; opens the plain text file
mov ax, 716Ch	;sets to open a file
mov bx, 0	;mode = read-only
mov cx, 0	;normal attribute
mov dx, 1	;action: open mode
mov si, OFFSET input	;Offsets input
int 21h	;call MS-DOS
jc quit	;quit if error, when CF = 1
mov inHandle, ax	;file handle

; reads the plain text file
mov ah, 3Fh	;sets the read array
mov bx, inHandle	;file handle
mov cx, BufferSize	;max bytes to read
mov dx, OFFSET Buffer	;buffer pointer
int 21h	;call MS-DOS
jc quit	;quit if error, when CF = 1
mov bytesRead, ax	;numbers of bytes read

; outputs the plain text from file
mov ah, 40h	;sets the output array
mov bx, 1	;console output handle
mov cx, bytesRead	;number of bytes
mov dx, OFFSET Buffer	;buffer pointer
int 21h	;call MS-DOS
jc quit	;quit if error, when CF = 1

; converts plain text to cypher
mov ecx, BufferSize	;sets the loop
mov esi, 0	;starts the pointer at 0

L1:
xor Buffer[esi], input3	;Translate the bytes (line 104)
inc esi	;go to next byte
loop L1	;repeat the loop

; open cypher text file
mov ax, 716Ch	;sets to open a file
mov bx, 1	;mode = write-only
mov cx, 0	;normal attribute
mov dx, 12h	;action: create/truncate
mov si, OFFSET input2	;Offsets input2
int 21h	;call MS-DOS
jc quit	;quit if error, when CF = 1
mov outHandle, ax	;save handle

; write to cypher text file
mov ah, 40h	;sets the write array
mov bx, outHandle	;output file handle
mov cx, bytesRead	;number of bytes
mov dx, OFFSET Buffer	;buffer pointer
int 21h	;call MS-DOS
jc quit	;quit if error, when CF = 1

; Output "Encryption text: "
mov ah, 40h	;sets the write array
mov bx, 1	;console output handle
mov cx, LENGTHOF output2	;copies LENGTHOF to cx
mov dx, OFFSET	output2	;moves OFFSET of the string to dx
int 21h	;call MS-DOS

; output the cypher text from file
mov ah, 40h	;sets the write array
mov bx, 1	;console output handle
mov cx, bytesRead	;number of bytes
mov dx, OFFSET Buffer	;buffer pointer
int 21h	;call MS-DOS
jc quit	;quit if error, when CF = 1

; New line
mov ah, 40h	;sets the write array
mov cx, LENGTHOF newline	;copies LENGTHOF to cx
mov dx, OFFSET newline	;moves OFFSET of the string to dx
int 21h	;call MS-DOS
quit:
exit

main ENDP

END main