.model small     ; Specifies the memory model for the program as "small"
.stack 100h      ; Defines the stack size as 100 hexadecimal bytes

.data             ; Indicates the start of the data segment

.code             ; Indicates the start of the code segment

main proc         ; Declares the start of the main procedure

mov ah,02h        ; Moves the hexadecimal value 02h into the AH register. AH is used to store the function number for output operations in DOS interrupt calls.
mov dl,53h        ; Moves the hexadecimal value 53h ('S' in ASCII) into the DL register. DL is used to store the character to be displayed.
int 21h           ; Calls interrupt 21h, which is the DOS interrupt for output. This instruction will display the character 'S' to the standard output.

main endp         ; Marks the end of the main procedure

mov ah,4ch        ; Moves the hexadecimal value 4Ch into the AH register. AH is used to store the function number for terminating a program in DOS interrupt calls.
int 21h           ; Calls interrupt 21h, which is the DOS interrupt for system functions. This particular function (4Ch) terminates the program.

end main          ; Marks the end of the program
