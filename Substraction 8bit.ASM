.model small     ; Memory model: small
.stack 100h      ; Stack size: 100h bytes

.code             ; Start of code segment

mov ah,01h        ; Read character from standard input
int 21h

sub al,30h        ; Convert ASCII character to numeric value
rol al,04h        ; Shift to left to make room for next digit
mov bl,al         ; Store first digit

mov ah,01h        ; Read next character
int 21h

sub al,30h        ; Convert ASCII character to numeric value
add al,bl         ; Add with previous digit
mov bl,al         ; Store sum

mov dl,2DH        ; Display '-'
mov ah,02h        ; Display character
int 21h

mov ah,01h        ; Read next character
int 21h

sub al,30h        ; Convert ASCII character to numeric value
rol al,04h        ; Shift to left to make room for next digit
mov dl,al         ; Store first digit

mov ah,01h        ; Read next character
int 21h

sub al,30h        ; Convert ASCII character to numeric value
add al,dl         ; Add with previous digit
mov dl,al         ; Store sum

sub bl,dl         ; Subtract the two sums

mov dl,3DH        ; Display '='
mov ah,02h        ; Display character
int 21h

mov al,bl         ; Get higher nibble of result
and al,0f0h       ; Mask lower nibble
rol al,04h        ; Shift to right
add al,30h        ; Convert to ASCII
mov dl,al         ; Display higher nibble
mov ah,02h        ; Display character
int 21h

mov al,bl         ; Get lower nibble of result
and al,0fh        ; Mask higher nibble
add al,30h        ; Convert to ASCII
mov dl,al         ; Display lower nibble
mov ah,02h        ; Display character
int 21h

mov ah,4ch        ; Terminate program
int 21h

end               ; End of program
