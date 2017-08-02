TITLE  BubbleSort Procedure                  (BSort2.asm)

; This program sorts an array of signed integers, using
; the Bubble sort algorithm. The main program is in B_main.asm.

INCLUDE Irvine32.inc

.code
;----------------------------------------------------------
BubbleSort PROC USES eax ecx esi ebx,
pArray:PTR DWORD,		; pointer to array
Count:DWORD			; array size
;
; Sort an array of 32-bit signed integers in ascending order
; using the bubble sort algorithm.  In addition to this ebx
; is now used as a flag in order to see if a bubble sort has
; occurred, if so then continue, else break out of the bsort
; Receives: pointer to array, array size
; Returns: nothing
;-----------------------------------------------------------

    mov ecx,Count
    dec ecx                     ; decrement count by 1
    mov ebx, 0                  ; 0 indicates a false flag

 L1:	push ecx                ; save outer loop count
    mov esi,pArray              ; point to first value


 L2:	mov eax,[esi]           ; get array value
    cmp [esi+4],eax             ; compare a pair of values
    jge L3                      ; if [esi] <= [edi], don't exch
    xchg eax,[esi+4]            ; exchange the pair
    mov [esi],eax
    mov ebx, 1                  ; A true flag that a sort has occurred

 L3:    add esi,4               ; move both pointers forward
    loop L2                     ; inner loop

    cmp ebx, 0                  ; Check to see if flagg is set if not then break
    je L4
    pop ecx                     ; retrieve outer loop count
    loop L1                     ; else repeat outer loop

 L4:
    mov eax, -1
    ret
BubbleSort ENDP

END