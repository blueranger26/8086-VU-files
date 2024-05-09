.model small
.stack 100h

.data
    string db "Hello, World!", '$'   ; Example string
    search_char db 'i'                ; Character to search for
    found_msg db "Character found.$"
    not_found_msg db "Character not found.$"

.code
main:
    mov ax, @data       ; Initialize data segment
    mov ds, ax

    mov si, offset string   ; Load address of the string into SI
    mov al, search_char     ; Load the character to search for into AL

search_loop:
    mov bl, [si]        ; Load the current character from the string into BL
    cmp bl, al          ; Compare BL (current character) with AL (search character)
    je character_found  ; If they are equal, jump to character_found

    inc si              ; Move to the next character in the string
    cmp byte ptr [si], '$'  ; Check if we have reached the end of the string
    jne search_loop    ; If not end of string, continue searching

    ; If end of string reached and character not found, display message
    lea dx, not_found_msg
    jmp display_message

character_found:
    ; Display message if character is found
    lea dx, found_msg

display_message:
    mov ah, 09h         ; DOS display string function
    int 21h             ; Call DOS

exit:
    mov ah, 4Ch         ; DOS exit function
    int 21h             ; Call DOS

end main
s