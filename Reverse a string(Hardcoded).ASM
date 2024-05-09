.model small
.stack 100h
.data
str1 db "hello"     ; Define a string "hello"
str2 db 06 dup("$") ; Define a buffer to store modified string, initialized with '$'

.code
main proc
mov ax,@data  ; Load the address of the data segment into AX
mov ds,ax     ; Initialize the data segment register (DS) with the address in AX
mov es,ax     ; Initialize the extra segment register (ES) with the address in AX

mov cx,05h    ; Initialize CX with the length of the string "hello" (5 characters)
lea si,str1   ; Load the offset address of str1 into SI
lea di,str2   ; Load the offset address of str2 into DI
add di,04     ; Move DI to the end of the buffer (to the last '$')

up:
cld           ; Clear the direction flag (DF) to move forward
lodsb         ; Load the byte at the address in SI into AL, and increment SI
std           ; Set the direction flag (DF) to move backward
stosb         ; Store the byte in AL at the address in DI, and decrement DI
dec cx        ; Decrement the loop counter CX
jnz up        ; Jump back to up if CX is not zero

mov ah,09h    ; DOS function for displaying a string
lea dx,str2   ; Load the offset address of str2 into DX
int 21h       ; Display the modified string
mov ah,4ch    ; DOS function for program termination
int 21h       ; Terminate the program

main endp
end main
