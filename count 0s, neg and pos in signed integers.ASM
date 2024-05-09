.model small
.stack 100h

.data
    array dd -5, 10, -3, 8, 0, -2, 6          ; Sample array of signed integers
    len equ ($ - array) / 4                   ; Length of the array in terms of double words (4 bytes each)
    pos_count db 0                             ; Counter for positive numbers
    neg_count db 0                             ; Counter for negative numbers
    zero_count db 0                            ; Counter for zero numbers

.code
start:
    mov ax, @data                              ; Load the address of the data segment into AX
    mov ds, ax                                 ; Initialize DS (Data Segment) register

    mov si, offset array                       ; Load the offset address of the array into SI
    mov cx, len                                ; Load the length of the array into CX
    xor bx, bx                                 ; Initialize BX register to 0 (for storing counts)

loop_count:
    mov ax, [si]                               ; Load the current element of the array into AX
    cmp ax, 0                                  ; Compare the element with 0 to check if it's zero
    jz zero                                    ; Jump if the element is zero
    jg positive                                ; Jump if the element is greater than 0 (positive)
    jl negative                                ; Jump if the element is less than 0 (negative)
    jmp next_elem                              ; Jump to next element if the element is not positive or negative

positive:
    inc byte ptr pos_count                    ; Increment positive count
    jmp next_elem                              ; Jump to next element

negative:
    inc byte ptr neg_count                    ; Increment negative count
    jmp next_elem                              ; Jump to next element

zero:
    inc byte ptr zero_count                   ; Increment zero count

next_elem:
    add si, 4                                  ; Move to the next element in the array (4 bytes per element)
    loop loop_count                            ; Decrement loop counter and repeat until CX is zero

    ; Print the results
    mov ah, 9                                  ; DOS function for displaying a string
    lea dx, msg_pos                            ; Load the offset address of the message for positive count
    int 21h                                    ; Invoke DOS interrupt
    mov ah, 2                                  ; DOS function for displaying a character
    mov dl, pos_count                          ; Load positive count into DL (ASCII)
    add dl, '0'                                ; Convert count to ASCII character
    int 21h                                    ; Invoke DOS interrupt

    mov ah, 9                                  ; DOS function for displaying a string
    lea dx, msg_neg                            ; Load the offset address of the message for negative count
    int 21h                                    ; Invoke DOS interrupt
    mov ah, 2                                  ; DOS function for displaying a character
    mov dl, neg_count                          ; Load negative count into DL (ASCII)
    add dl, '0'                                ; Convert count to ASCII character
    int 21h                                    ; Invoke DOS interrupt
    
    mov ah, 9                                  ; DOS function for displaying a string
    lea dx, msg_zero                           ; Load the offset address of the message for zero count
    int 21h                                    ; Invoke DOS interrupt
    mov ah, 2                                  ; DOS function for displaying a character
    mov dl, zero_count                         ; Load zero count into DL (ASCII)
    add dl, '0'                                ; Convert count to ASCII character
    int 21h                                    ; Invoke DOS interrupt

    mov ah, 4ch                                ; DOS function for program termination
    int 21h                                    ; Invoke DOS interrupt

.data
    msg_pos db 10, 'Number of positive numbers: $'    ; Message for displaying positive count
    msg_neg db 10, 'Number of negative numbers: $'    ; Message for displaying negative count
    msg_zero db 10, 'Number of zeros: $'              ; Message for displaying zero count

end start
