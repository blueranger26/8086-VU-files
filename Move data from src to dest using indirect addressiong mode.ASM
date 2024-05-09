.model small
.stack 100h
.data
str1 db 'a','$'
str2 db 100 dup('$')
.code
mov ax,@data
mov ds,ax
mov es,ax

mov si,offset str1
mov di,offset str2

mov al,[si]    ;indirect addressing mode
mov [di],al

mov ah,09h
lea dx,str2
int 21h

mov ah,4ch
int 21h
end
