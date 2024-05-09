.model small     ; Specifies the memory model for the program as "small"
.stack 100H      ; Defines the stack size as 100 hexadecimal bytes

.data             ; Indicates the start of the data segment

.code             ; Indicates the start of the code segment

main proc         ; Declares the start of the main procedure

MOV AH,01H        ; Moves the hexadecimal value 01H into the AH register. AH is used to store the function number for input/output operations in DOS interrupt calls.
INT 21H           ; Calls interrupt 21H, which is the DOS interrupt for input. This instruction will read a character from standard input and store it in AL register.

main endp         ; Marks the end of the main procedure

MOV AH,4CH        ; Moves the hexadecimal value 4CH into the AH register. AH is used to store the function number for terminating a program in DOS interrupt calls.
INT 21H           ; Calls interrupt 21H, which is the DOS interrupt for system functions. This particular function (4CH) terminates the program.

end main          ; Marks the end of the program
