.model small     ; Memory model: small
.stack 100h      ; Stack size: 100h bytes

.data             ; Start of data segment

str1 db 'shlok27$'  ; Source string
str2 db 100 dup('$')  ; Destination string
str3 db 'copied string: $'  ; Message for copied string

.code             ; Start of code segment

mov ax, @data     ; Load the address of the data segment into AX
mov ds, ax        ; Set the data segment register (DS) to the loaded address
mov es, ax        ; Set the extra segment register (ES) to the loaded address

lea si, str1      ; Load the offset address of str1 into SI
lea di, str2      ; Load the offset address of str2 into DI

mov ah, 00h       ; Clear AH register

copy:             ; Copy loop
mov al, [si]      ; Load byte from source string into AL
mov [di], al      ; Store byte into destination string
inc si            ; Increment source index
inc di            ; Increment destination index
cmp al, '$'      ; Compare byte with '$' (end of string)
je end            ; Jump to end if end of string found
jmp copy          ; Continue copying

end:              ; End of copying
lea dx, str3      ; Load offset address of str3 into DX
mov ah, 09h       ; Set AH to print string function
int 21h           ; Print message for copied string
lea dx, str2      ; Load offset address of str2 into DX
mov ah, 09h       ; Set AH to print string function
int 21h           ; Print copied string
mov ah, 4ch       ; Set AH to exit program function
int 21h           ; Terminate program

end               ; End of program
