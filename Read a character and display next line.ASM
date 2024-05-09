;accept character from user and display it
.model small    ; Define memory model as small
.stack 100      ; Set stack size to 100 bytes

.code
main proc       ; Start of the main procedure
    mov ah,01h  ; Set AH to 01h (MS-DOS read character function)
    int 21h     ; Call interrupt 21h to read a character from standard input

    mov bl,al   ; Move the character read into BL register
    mov ah,02   ; Set AH to 02h (MS-DOS write character function)
    mov dl,0ah  ; Set DL to 0ah (ASCII newline character)
    int 21h     ; Call interrupt 21h to write newline character to standard output

    mov ah,02   ; Set AH to 02h (MS-DOS write character function)
    mov dl,bl   ; Move the character in BL to DL
    int 21h     ; Call interrupt 21h to write character in DL to standard output

    mov ah,4ch  ; Set AH to 4ch (MS-DOS terminate program function)
    int 21h     ; Call interrupt 21h to terminate the program
main endp      ; End of the main procedure
end main       ; End of the program, with "main" as the entry point
