.model small     ; Memory model: small
.stack 100h      ; Stack size: 100h bytes

.code             ; Start of code segment

main proc         ; Start of main procedure

mov ah,01h        ; Read character from standard input
int 21h

sub al,30h        ; Convert ASCII character to numeric value
rol al,04h        ; Shift to left to make room for next digit
mov bl,al         ; Store first digit

mov ah,01h        ; Read next character
int 21h

sub al,30h        ; Convert ASCII character to numeric value
add bl,al         ; Add with previous digit

mov ah,02h        ; Set output function
mov dl,0ah        ; Set DL to ASCII for newline character
int 21h           ; Print newline character

mov ah,02h        ; Set output function
mov dl,2ah        ; Set DL to ASCII for '*'
int 21h           ; Print '*'

mov ah,01h        ; Read next character
int 21h

sub al,30h        ; Convert ASCII character to numeric value
rol al,04h        ; Shift to left to make room for next digit
mov dl,al         ; Store first digit

mov ah,01h        ; Read next character
int 21h

sub al,30h        ; Convert ASCII character to numeric value
add al,dl         ; Add with previous digit

mul bl            ; Multiply BL by AL, result in AX
mov bx,ax         ; Move result to BX

mov ah,02h        ; Set output function
mov dl,0ah        ; Set DL to ASCII for newline character
int 21h           ; Print newline character

mov al,02h        ; Set AH to output character
mov dl,bh         ; Move higher nibble of result to DL
add dl,30h        ; Convert to ASCII
int 21h           ; Print higher nibble

mov dl,bl         ; Move BL to DL
and dl,0f0h       ; Mask lower nibble
rol dl,04h        ; Shift left to make it higher nibble
add dl,30h        ; Convert to ASCII
mov al,02h        ; Set AH to output character
int 21h           ; Print higher nibble

mov dl,bl         ; Move BL to DL
and dl,0fh        ; Mask higher nibble
add dl,30h        ; Convert to ASCII
mov al,02h        ; Set AH to output character
int 21h           ; Print lower nibble

main endp         ; End of main procedure

mov ah,4ch        ; Terminate program
int 21h           ; Call interrupt 21h

end main          ; End of program
