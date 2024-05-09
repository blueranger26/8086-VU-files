.model small
.stack 100h

.data
    dividend    dd  12345678h  ; 32-bit dividend
    divisor     dw  5678h      ; 16-bit divisor
    quotient    dd  ?          ; 32-bit quotient
    remainder   dw  ?          ; 16-bit remainder

.code
start:
    mov ax, @data         ; Load the data segment address into AX
    mov ds, ax            ; Initialize the data segment register DS

    ; Load the 32-bit dividend into DX:AX
    mov dx, word ptr dividend+2  ; Load the most significant word of the dividend into DX
    mov ax, word ptr dividend    ; Load the least significant word of the dividend into AX

    ; Load the 16-bit divisor into BX
    mov bx, divisor       ; Load the divisor into BX

    ; Perform the division
    div bx                ; Divide DX:AX by BX. Quotient in AX, remainder in DX

    ; Store the quotient and remainder
    mov word ptr quotient, ax    ; Store the least significant word of the quotient
    mov word ptr quotient+2, dx  ; Store the most significant word of the quotient
    mov word ptr remainder, dx   ; Store the remainder

    ; Exit
    mov ah, 4Ch           ; Set the function code for exit to DOS
    int 21h               ; Trigger the interrupt to exit the program

end start
