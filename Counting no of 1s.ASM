.model small
.stack 100h

.data
    reg_val dw 0A0F0h   ; Register value to count 1's
    count   dw ?        ; Variable to store the count of 1's
    newline db 0Ah, 0Dh, '$'  ; Carriage return and line feed

.code
start:
    mov ax, @data
    mov ds, ax

    mov ax, reg_val     ; Load the register value into ax
    mov bx, 0           ; Initialize the count to 0
    mov cx, 16          ; Loop counter for 16 bits

count_loop:
    shl ax, 1           ; Shift the bits left to bring the next bit into the carry flag
    jnc skip_increment  ; If the carry flag is not set (bit is 0), skip incrementing
    inc bx              ; Increment the count if the bit is 1

skip_increment:
    loop count_loop     ; Repeat for all 16 bits

    mov word ptr count, bx  ; Store the count in the 'count' variable

    ; Print the count in hexadecimal format
    mov dx, offset newline
    mov ah, 09h
    int 21h             ; Print a newline

    mov ax, count       ; Load the count value into ax
    mov bx, ax          ; Copy the count value to bx
    call print_hex      ; Call the print_hex procedure

    mov ah, 4ch
    int 21h             ; Exit the program

; Procedure to print a 16-bit value in hexadecimal
print_hex proc
    push ax
    push bx
    push cx
    push dx

    mov cx, 4           ; Loop counter for 4 hexadecimal digits
    mov dx, 0           ; Initialize dx to 0

print_loop:
    rol bx, 4           ; Rotate the bits in bx left by 4 positions
    mov dl, bl          ; Move the lowest 4 bits of bx to dl
    and dl, 0Fh         ; Mask the lowest 4 bits
    add dl, 30h         ; Convert the value to ASCII
    cmp dl, 39h         ; Check if the value is greater than '9'
    jle print_digit     ; If not, print the digit
    add dl, 07h         ; Otherwise, add 'A' - '9' - 1

print_digit:
    mov ah, 02h         ; DOS interrupt for printing a character
    int 21h             ; Print the character
    loop print_loop     ; Repeat for all 4 digits

    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_hex endp

end start