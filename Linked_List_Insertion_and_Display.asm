TITLE		Linked List      (Linked_List_Insertion_and_Displa.asm)

; Program:    Chapter 11, Pr 11
;
; Implement a singly linked list, using the dynamic memory allocation functions presented in this chapter
;
; Student:     Johnathan Soto
; Date:        05/14/2015
; Class:       CSCI 241
; Instructor:  Mr. Ding
; Updated		...

INCLUDE Irvine32.inc
INCLUDE	Macros.inc

;PROTOS,STRUCTS
NODE STRUCT
    intVal	SDWORD	?
    pNext	DWORD	?
NODE ENDS
PNODE TYPEDEF PTR NODE

.data
hHeap		HANDLE	?
head		NODE <0,0> ; Dummy head

.code
listMain PROC

	INVOKE GetProcessHeap						;get handle to existing heap area
	.IF eax == NULL
		call WriteWindowsMsg					;exit if failed
		JMP QUIT
	.ELSE
		MOV hHeap, eax
	.ENDIF
 STARTER:

    call createNode                             ; Create a new node for the head
    cmp eax, 0
    JE QUIT

  JNC	NodeSuccess

  JMP QUIT                                    ; The carry flag was set so the heapAllocation was a failure

 NodeSuccess:

	MOV head.pNext, eax							;head points at first node
	MOV edi, eax								;tailPtr
	MOV esi, eax								;currptr

 Whiler:
		call createNode
		MOV edi, eax							;tailPtr = newest Node
		MOV (NODE PTR [esi]).pNext, edi			;CurrNode.pNext = tailNode
		MOV esi, edi							;currPtr = tailPtr

        cmp eax, 0
        jne Whiler

    call Crlf
    mWriteLn "Contents of linked List:"
    mWrite "Dummy Head "

    ; Display the nodes

    MOV esi, head.pNext                         ; Set up the first node &
    MOV edi, (NODE PTR [esi]).pNext             ; the second node for prev & Curr nodes

 Displayer:

    mWrite " -> "
    MOV edi, (NODE PTR [esi]).pNext
    MOV eax, (NODE PTR [esi]).intVal
    call WriteInt
    INVOKE HeapFree, hHeap, NULL, esi
    MOV esi, edi
    CMP esi, NULL
    jne Displayer

 QUIT:
	call Crlf
	call WaitMsg
exit
listMain ENDP

;---------------------------------------------------------------------------------------------
createNode PROC USES ebx
;
; Input:                -eax
;
; Output:               -eax = the return address of the heap block
;                               or a 0 that will be helping get out of a loop
;
;---------------------------------------------------------------------------------------------
STARTN:
	mWrite "Enter a signed integer node value (zero to end): "
	call ReadInt
    JNC	VALIDN

	mWriteLn "Invalid Input, Please Enter Again.. "
	JMP STARTN

 VALIDN:

    CMP eax, NULL
    je BACKER

	MOV ebx, eax
	INVOKE HeapAlloc, hHeap, HEAP_ZERO_MEMORY, SIZEOF NODE
	.IF eax == NULL
		mWriteLn "Error occured allocating space for a Node.. "
		STC
	.ELSE
		MOV (NODE PTR [eax]).intVal, ebx
		CLC
	.ENDIF

 BACKER:

ret
createNode ENDP

END listMain