.model small     ; Specifies the memory model for the program as "small"
.stack 100H      ; Defines the stack size as 100 hexadecimal bytes

.code             ; Indicates the start of the code segment

main proc         ; Declares the start of the main procedure

MOV AH,02H        ; Moves the hexadecimal value 02H into the AH register. AH is used to store the function number for output operations in DOS interrupt calls.
MOV DL,53H        ; Moves the hexadecimal value 53H ('S' in ASCII) into the DL register. DL is used to store the character to be displayed.
INT 21H           ; Calls interrupt 21H, which is the DOS interrupt for output. This instruction will display the character 'S'.

MOV AH,02H        ; Moves the hexadecimal value 02H into the AH register.
MOV DL,68H        ; Moves the hexadecimal value 68H ('h' in ASCII) into the DL register.
INT 21H           ; Calls interrupt 21H to display the character 'h'.

MOV AH,02H        ; Moves the hexadecimal value 02H into the AH register.
MOV DL,4CH        ; Moves the hexadecimal value 4CH ('L' in ASCII) into the DL register.
INT 21H           ; Calls interrupt 21H to display the character 'L'.

MOV AH,02H        ; Moves the hexadecimal value 02H into the AH register.
MOV DL,6FH        ; Moves the hexadecimal value 6FH ('o' in ASCII) into the DL register.
INT 21H           ; Calls interrupt 21H to display the character 'o'.

MOV AH,02H        ; Moves the hexadecimal value 02H into the AH register.
MOV DL,4BH        ; Moves the hexadecimal value 4BH ('K' in ASCII) into the DL register.
INT 21H           ; Calls interrupt 21H to display the character 'K'.

main endp         ; Marks the end of the main procedure

MOV AH,4CH        ; Moves the hexadecimal value 4CH into the AH register. AH is used to store the function number for terminating a program in DOS interrupt calls.
INT 21H           ; Calls interrupt 21H, which is the DOS interrupt for system functions. This particular function (4CH) terminates the program.

end main          ; Marks the end of the program
