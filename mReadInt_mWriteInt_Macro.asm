
TITLE  Chapter 10, Problem 5 & 6 (mReadInt_mWriteInt_Macro.asm)

; Program:     Chapter 10, Problem 5 & 6
Comment @
 Description: PR 5: Create a macro named mReadInt that reads a 16- or 32-bit
               signed integer from standard input and returns the value
               in an argument: Use conditional operators to allow the
               macro to adapt to the size of the desired result. Write a
               program that calls the macro, passing it operands of
               various sizes, either signed or unsigned. If the operand
               has an unexpected size, should display an error message during
               assembling.

              PR 6:Create a macro named mWriteInt that writes a signed integer
                   to standard output by calling WriteInt. The argument passed
                   to the macro can be a positive or negative valued operand.
                   Use conditional operators in the macro so it adapts to the
                   size of the argument. Write a program that demonstrates the
                   macro, passing it arguments of different sizes.  Build issues
                   should produce warnings during assembling because the operand
                   qVal has an unexpected size, and then you display a warning
                   message to the builder.
@
;
; Student:     Johnathan Soto
; Date:        04/20/2015
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
INCLUDE macros.inc

; MACROS

    ; READINT
mReadInt MACRO intVal


    IF  (TYPE intVal) EQ 4       ; 32
        call ReadInt
        mov intVal, eax

    ELSEIF TYPE intVal EQ 2      ; 16
        call ReadInt
        mov intVal, ax
    ELSE                               ; NOT in the bounds of 16-32 bit range
        ECHO error : ************************************************************************
        ECHO error : Argument &intVal passed to mReadInt must be either 16 or 32 bits.
        ECHO error : &intVal must be of 16 or 32-bit data type.
        ECHO error : ************************************************************************

    ENDIF


ENDM ; End of mReadInt


    ;WriteInt
mWriteInt MACRO intDVal


    IF TYPE intDVal EQ 4         ; SDWORD
        mShow intDVal, I
        call Crlf
    ELSEIF TYPE intDVal EQ 2     ; SWORD

        mShow intDVal, I
        call Crlf
    ELSEIF TYPE intDVal EQ 1     ; SBYTE
        mShow intDVal, I
        call Crlf
    ELSE
        ECHO warning : ************************************************************************
        ECHO warning : Argument &intDVal passed to mWriteInt must be 8, 16, or 32 bits.
        ECHO warning : ************************************************************************
    ENDIF

ENDM ; End of mWriteInt


.data

    bVal SBYTE -2
    wVal SWORD -122
    dVal DWORD 1234567
    qVal QWORD 11
    dVal2 DWORD ?


.code

main? PROC

    ; PR 5
    mWrite "Enter a 32-bit integer: "
    mReadInt dVal2
    mWriteInt dVal2
    mWrite "Enter a 16-bit integer: "
    mReadInt BX
    mWriteInt BX

    ;PR 6
    mWriteInt bVal
    mWriteInt wVal
    mWriteInt dVal
    mWriteInt AX
    mWriteInt ebx

    ; Test the macro's error message
    mWriteInt qVal


exit
main? ENDP

END main?












