.model small
.stack 100h
.data
str1 db 'give a 8 bit number: $'
str2 db 10,'number of 0s: $'
.code
mov ax,@data
mov ds,ax

mov ah,09h
lea dx,str1
int 21h

mov ah,01h
int 21h
sub al,30h
rol al,04h
mov bl,al
mov ah,01h
int 21h
sub al,30h
add al,bl


mov bl,00h

mov cl,8

ones:
rcl al,1
jnc coun
back:
dec cl
cmp cl,0
jne ones
jmp print

coun:
inc bl
jmp back

print:
mov ah,09h
lea dx,str2
int 21h

mov al,bl
and al,0f0h
rol al,4
add al,30h
mov dl,al
mov ah,02h
int 21h

mov al,bl
and al,0fh
add al,30h
mov dl,al
mov ah,02h
int 21h

mov ah,4ch
int 21h
end
