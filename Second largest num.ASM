.model small
.stack 100h
.data
str1 db 'give a array of numbers: $'
str2 db 10,'second largest number: $'
buf db 100 dup('$')
.code
mov ax,@data
mov ds,ax

mov ah,09h
lea dx,str1
int 21h

mov ah,0ah
lea dx,buf
int 21h

mov si,offset buf+2

mov bl,[si]

larr:
mov dl,[si]
cmp dl,'$'
je secon
cmp bl,dl
jl move
back:
inc si
jmp larr

move:
mov bl,dl
jmp back

secon:
mov si,offset buf +2
mov cl,00h


sec:
mov dl,[si]
cmp  dl,'$'
je print
cmp bl,dl
jne rech
back2:
inc si
jmp sec

rech:
cmp cl,dl
jl move2
back3:
jmp back2

move2:
mov cl,dl
jmp back3


print:
mov ah,09h
lea dx,str2
int 21h

mov dl,cl
mov ah,02h
int 21h

mov ah,4ch
int 21h
end
