.model small    ; Define memory model as small
.stack 100      ; Set stack size to 100 bytes

.data
lowercase_to_uppercase equ 'A' - 'a'   ; Constant to convert lowercase to uppercase

.code
main proc       ; Start of the main procedure
    mov ah,01h  ; Set AH to 01h (MS-DOS read character function)
    int 21h     ; Call interrupt 21h to read a character from standard input

    mov bl, al  ; Move the character read into BL register

    ; Check if the character is a lowercase letter
    cmp bl, 'a' ; Compare with lowercase 'a'
    jb not_lowercase ; Jump if below (not a lowercase letter)
    cmp bl, 'z' ; Compare with lowercase 'z'
    ja not_lowercase ; Jump if above (not a lowercase letter)

    ; If the character is a lowercase letter, convert it to uppercase
    add bl, lowercase_to_uppercase ; Convert lowercase to uppercase

display_uppercase:
    ; Display a newline character
    mov ah, 02h ; Set AH to 02h (MS-DOS write character function)
    mov dl, 0ah ; Set DL to 0ah (ASCII newline character)
    int 21h     ; Call interrupt 21h to write newline character to standard output

    ; Display the character
    mov ah, 02h ; Set AH to 02h (MS-DOS write character function)
    mov dl, bl  ; Move the character in BL to DL
    int 21h     ; Call interrupt 21h to write character in DL to standard output

not_lowercase:
    mov ah, 4ch ; Set AH to 4ch (MS-DOS terminate program function)
    int 21h     ; Call interrupt 21h to terminate the program
main endp      ; End of the main procedure
end main       ; End of the program, with "main" as the entry point
