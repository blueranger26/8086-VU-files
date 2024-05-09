.model small     ; Memory model: small
.stack 100H      ; Stack size: 100H bytes

.code             ; Start of code segment

main proc         ; Start of main procedure

mov ah,01h        ; Read character from standard input
int 21h           ; DOS interrupt

sub al,30h        ; Convert ASCII character to numeric value
rol al,04h        ; Shift left to prepare for next digit
mov bh,al         ; Store first digit in BH

mov ah,01h        ; Read next character
int 21h           ; DOS interrupt

sub al,30h        ; Convert ASCII character to numeric value
add bh,al         ; Add with previous digit

mov ah,01h        ; Read next character
int 21h           ; DOS interrupt

sub al,37h        ; Convert ASCII character to numeric value
rol al,04h        ; Shift left to prepare for next digit
mov bl,al         ; Store first digit in BL

mov al,01h        ; Set AL to 1
int 21h           ; DOS interrupt

sub al,37h        ; Convert ASCII character to numeric value
add bl,al         ; Add with previous digit

mov ah,02h        ; Set output function
mov dl,2fh        ; Set DL to ASCII for '/'
int 21h           ; DOS interrupt

mov ah,01h        ; Read next character
int 21h           ; DOS interrupt

sub al,37h        ; Convert ASCII character to numeric value
rol al,04h        ; Shift left to prepare for next digit
mov dl,al         ; Store first digit in DL

mov ah,01h        ; Read next character
int 21h           ; DOS interrupt

sub al,37h        ; Convert ASCII character to numeric value
add dl,al         ; Add with previous digit

mov ax,bx         ; Move contents of BX to AX
div dl            ; Divide AX by DL, result in AX
mov bx,ax         ; Move result to BX

mov ah,02h        ; Set output function
mov dl,0ah        ; Set DL to ASCII for newline character
int 21h           ; DOS interrupt

mov ah,02h        ; Set output function
mov dl,52h        ; Set DL to ASCII for 'R'
int 21h           ; DOS interrupt

mov ah,02h        ; Set output function
mov dl,3dh        ; Set DL to ASCII for '='
int 21h           ; DOS interrupt

mov dl,bh         ; Get higher nibble of result in BH
and dl,0f0h       ; Mask lower nibble
rol dl,04h        ; Shift right to get higher nibble
add dl,30h        ; Convert to ASCII
mov al,02h        ; Set AH to output character
int 21h           ; DOS interrupt

mov dl,bh         ; Get lower nibble of result in BH
and dl,0fh        ; Mask higher nibble
add dl,37h        ; Adjust to ASCII range
mov al,02h        ; Set AH to output character
int 21h           ; DOS interrupt

mov ah,02h        ; Set output function
mov dl,0ah        ; Set DL to ASCII for newline character
int 21h           ; DOS interrupt

mov ah,02h        ; Set output function
mov dl,51h        ; Set DL to ASCII for 'Q'
int 21h           ; DOS interrupt

mov ah,02h        ; Set output function
mov dl,3dh        ; Set DL to ASCII for '='
int 21h           ; DOS interrupt

mov dl,bl         ; Get higher nibble of result in BL
and dl,0f0h       ; Mask lower nibble
rol dl,04h        ; Shift right to get higher nibble
add dl,30h        ; Convert to ASCII
mov al,02h        ; Set AH to output character
int 21h           ; DOS interrupt

mov dl,bl         ; Get lower nibble of result in BL
and dl,0fh        ; Mask higher nibble
add dl,30h        ; Convert to ASCII
mov al,02h        ; Set AH to output character
int 21h           ; DOS interrupt

main endp         ; End of main procedure

mov ah,4ch        ; Terminate program
int 21h           ; DOS interrupt

end main          ; End of program
