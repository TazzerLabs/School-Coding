TITLE Creating a Linked List            (List.asm)

; Program:     Chapter 10, supplementary exercise
; Description: This program shows how the STRUC directive
;              and the REPT directive can be combined to
;              create a linked list at assembly time.
; Student:     Johnathan Soto
; Date:        05/05/2015
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

ListNode STRUCT
NodeData DWORD ?
NextPtr  DWORD ?
ListNode ENDS

TotalNodeCount = 15
NULL = 0
Counter = 0
Val1 = 1
Val2 = 1
Val3 = Val1 + Val2

.data
    LinkedList LABEL PTR ListNode
 REPT TotalNodeCount
    Counter = Counter + 1
    IF Counter EQ TotalNodeCount
        ListNode <Val1, $>
    ELSE
        ListNode <Val1, ($ + Counter * SIZEOF ListNode)>
    ENDIF
    Val1 = Val2
    Val2 = Val3
    Val3 = Val1 + Val2

 ENDM
    ListNode <0,0>	; tail node

.code
main PROC
    mov  esi,OFFSET LinkedList

    ; Display the integers in the NodeData members.
 NextNode:

    ; Display the node data.
    mov  eax,(ListNode PTR [esi]).NodeData
    call WriteDec
    mov al, ' '
    call WriteChar

    ; Check for the tail node.
    mov  eax,(ListNode PTR [esi]).NextPtr
    cmp  eax, OFFSET LinkedList
    je   quit


    ; Get pointer to next node.
    mov  esi,(ListNode PTR [esi]).NextPtr
    jmp  NextNode

 quit:
    call Crlf
    exit
main ENDP
END main