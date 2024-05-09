.MODEL SMALL     ; Specifies the memory model for the program as "small"
.STACK 100H      ; Defines the stack size as 100 hexadecimal bytes

.DATA             ; Indicates the start of the data segment

N1      DB 0FDH   ; Defines a byte-sized variable named N1 with the hexadecimal value FD (253 in decimal)
N2      DB 0DCH   ; Defines a byte-sized variable named N2 with the hexadecimal value DC (220 in decimal)
SUM_LSB DB 00H    ; Defines a byte-sized variable named SUM_LSB to store the least significant byte of the sum
SUM_MSB DB 00H    ; Defines a byte-sized variable named SUM_MSB to store the most significant byte of the sum

.CODE             ; Indicates the start of the code segment

MAIN PROC         ; Declares the start of the main procedure

MOV AX, @DATA    ; Moves the address of the data segment into the AX register
MOV DS, AX       ; Copies the address in AX to the data segment register (DS)

MOV AL, 00H      ; Clears the AL register (the least significant byte of the sum)
MOV AH, 00H      ; Clears the AH register (the most significant byte of the sum)

MOV AL, N1       ; Moves the value of N1 into the AL register
MOV BL, N2       ; Moves the value of N2 into the BL register
ADD AL, BL       ; Adds the values of N1 and N2, storing the result in AL (the least significant byte of the sum)
MOV SUM_LSB, AL  ; Moves the value in AL (the sum) to the variable SUM_LSB

ADC AH, 00H      ; Adds the carry flag to AH (the most significant byte of the sum)
MOV SUM_MSB, AH  ; Moves the value in AH (the carry or the most significant byte of the sum) to the variable SUM_MSB

MOV AH, 4CH      ; Moves the hexadecimal value 4CH into the AH register. AH is used to store the function number for terminating a program in DOS interrupt calls.
INT 21H          ; Calls interrupt 21H to terminate the program.

MAIN ENDP        ; Marks the end of the main procedure

END MAIN         ; Marks the end of the program
