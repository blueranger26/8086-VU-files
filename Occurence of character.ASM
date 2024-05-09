.model small
.stack 100h
.data
str1 db 100 dup('$')   ; Input buffer
msg1 db 10,'give a string: $'  ; Prompt for input
msg2 db 10,'character: $'  ; Prompt for character to count
msg3 db 10,'count: $'  ; Display count of character
.code
mov ax,@data
mov ds,ax
mov ah,09h   ; DOS service - print string
lea dx,msg1
int 21h
mov ah,0ah   ; DOS service - buffered input
lea dx,str1
int 21h
mov ah,09h   ; DOS service - print string
lea dx,msg2
int 21h
mov ah,01h   ; DOS service - read character
int 21h
mov si,offset str1+2   ; Point SI to start of input buffer
mov cl,00h   ; Initialize count to 0
count:   ; Loop to count characters
mov bl,[si]
cmp al,bl   ; Compare current character with the one to count
je plus   ; Jump if they match
back:   ; Continue searching
inc si
cmp bl,'$'
je printc   ; Jump to print count if end of string reached
jmp count   ; Loop until end of string
plus:   ; Increment count if character matches
inc cl
jmp back   ; Continue searching
printc:   ; Print the count
mov ah,09h   ; DOS service - print string
lea dx,msg3
int 21h
mov al,cl
and al,0f0h
rol al,04h
add al,30h
mov dl,al
mov ah,02h   ; DOS service - print character
int 21h
mov al,cl
and al,0fh
add al,30h
mov dl,al
mov ah,02h   ; DOS service - print character
int 21h
mov ah,4ch   ; DOS service - terminate program
int 21h
end
