.model small     ; Specifies the memory model for the program as "small"
.stack 100h      ; Defines the stack size as 100 hexadecimal bytes

.data             ; Indicates the start of the data segment

msg db 'Shlok Devi', '$' ; Defines a string "Shlok Devi" terminated by '$'

.code             ; Indicates the start of the code segment

mov ax, @data    ; Moves the address of the data segment into the AX register
mov ds, ax       ; Copies the address in AX to the data segment register (DS)

mov ah, 06h      ; Moves the hexadecimal value 06h into the AH register. AH is used to store the function number for scrolling up a window in BIOS video services.
mov al, 00h      ; Moves the hexadecimal value 00h into the AL register, indicating the number of lines to scroll up.
mov bh, 07h      ; Moves the hexadecimal value 07h into the BH register, which is the display page number.
mov cx, 0        ; Clears the CX register. CX is not used in this instruction.
mov dx, 184fh    ; Moves the hexadecimal value 184Fh into the DX register, representing the top-left corner of the scroll window.
int 10h          ; Calls interrupt 10h, which is the BIOS video interrupt, to perform scrolling.

mov ah, 02h      ; Moves the hexadecimal value 02h into the AH register. AH is used to store the function number for setting cursor position.
mov bh, 0        ; Moves the hexadecimal value 0 into the BH register, representing the display page number.
mov dh, 12       ; Moves the decimal value 12 into the DH register, representing the row position of the cursor.
mov dl, 35       ; Moves the decimal value 35 into the DL register, representing the column position of the cursor.
int 10h          ; Calls interrupt 10h to set the cursor position.

mov ah, 09h      ; Moves the hexadecimal value 09h into the AH register. AH is used to store the function number for displaying strings in DOS interrupt calls.
lea dx, msg      ; Loads the effective address of the string msg into the DX register.
int 21h          ; Calls interrupt 21h to display the string "Shlok Devi".

mov ah, 4ch      ; Moves the hexadecimal value 4Ch into the AH register. AH is used to store the function number for terminating a program in DOS interrupt calls.
int 21h          ; Calls interrupt 21h to terminate the program.

end              ; Marks the end of the program
