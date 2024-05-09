.model small     ; Specifies the memory model for the program as "small"
.stack 100h      ; Defines the stack size as 100 hexadecimal bytes

.data             ; Indicates the start of the data segment

str1 db 'enter a string : $'  ; Defines a string "enter a string : " terminated by '$' for display
str2 db 10,'entered string: $' ; Defines a string "entered string: " terminated by '$' for display, with a newline character (10) before it
buffer db 100 dup('$')         ; Defines a buffer to store user input, capable of holding up to 100 characters, terminated by '$'

.code             ; Indicates the start of the code segment

mov ax,@data     ; Moves the address of the data segment into the AX register
mov ds,ax        ; Copies the address in AX to the data segment register (DS)
mov es,ax        ; Copies the address in AX to the extra segment register (ES)

mov ah,09h       ; Moves the hexadecimal value 09h into the AH register. AH is used to store the function number for displaying strings in DOS interrupt calls.
lea dx,str1      ; Loads the effective address of the string str1 into the DX register.
int 21h          ; Calls interrupt 21h, which is the DOS interrupt for displaying strings. This instruction will display the string "enter a string : ".

mov ah,0ah       ; Moves the hexadecimal value 0ah into the AH register. AH is used to store the function number for buffered input in DOS interrupt calls.
lea dx,buffer    ; Loads the effective address of the buffer into the DX register. This is where the input string will be stored.
int 21h          ; Calls interrupt 21h to get a buffered input string from the user.

mov ah,09h       ; Moves the hexadecimal value 09h into the AH register.
lea dx,str2      ; Loads the effective address of the string str2 into the DX register.
int 21h          ; Calls interrupt 21h to display the string "entered string: ".

lea dx,buffer+2  ; Loads the effective address of buffer+2 into the DX register. This skips the first two bytes of the buffer, which contain the length of the input string.
int 21h          ; Calls interrupt 21h to display the user-entered string.

mov ah,4ch       ; Moves the hexadecimal value 4Ch into the AH register. AH is used to store the function number for terminating a program in DOS interrupt calls.
int 21h          ; Calls interrupt 21h to terminate the program.

end              ; Marks the end of the program
