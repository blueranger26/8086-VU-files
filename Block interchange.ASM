.model small
.stack
.data
 src dw 1234h, 5678h, 9abch     ; Source array containing 3 words
 len dw ($-src)/2               ; Calculate the length of the source array in words
 dst dw 39abh, 5877h, 9988h     ; Destination array containing 3 words
.code
start: 
    mov ax, @data               ; Load address of the data segment into AX
    mov ds, ax                  ; Set up the data segment

    mov cx, len                 ; Load the length of the source array into CX
    mov si, 00h                 ; Initialize source index to 0

l1:                             ; Start of loop label
    mov ax, src[si]             ; Move the word at src[si] into AX
    mov bx, dst[si]             ; Move the word at dst[si] into BX

    mov dst[si], ax             ; Exchange: Move word from src[si] to dst[si]
    mov src[si], bx             ; Exchange: Move word from dst[si] to src[si]

    add si, 02                  ; Move to the next word in the arrays (increment SI by 2 bytes)

    loop l1                     ; Repeat the loop until CX becomes zero

    mov ah, 4ch                 ; Set up for an exit to DOS
    int 21h                     ; Call DOS to terminate the program

end start                       ; End of the program, specifying the entry point
