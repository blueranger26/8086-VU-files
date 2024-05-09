.model small
.stack 100h

.data
arr db '1234567$'
num db '5'
str1 db 10,'Number found is: $'

.code
mov ax,@data
mov ds,ax
mov es,ax

lea di,arr
mov al,num
mov cx,07h
cld
repne scasb

mov ah,09h
lea dx,str1
int 21h

mov ah,02h
mov dl,al
int 21h

mov ah,4ch
int 21h
end
