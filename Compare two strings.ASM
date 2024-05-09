.model small
.stack 100h
.data
string1 db 'hello$'
string2 db 'world$'
msg1 db 'Strings are equal.$'
msg2 db 'Strings are not equal.$'
.code
mov ax, @data
mov ds, ax
mov es, ax
lea si, string1
lea di, string2
cld
mov cx, 5
repe cmpsb
jne not_equal
mov ah, 09h
lea dx, msg1
int 21h
jmp end_prog
not_equal:
mov ah, 09h
lea dx, msg2
int 21h
end_prog:
mov ah, 4Ch
int 21h
end