.model small
.stack 100h
.data
str1 db 'give an array: $'       ; Prompt for array input
str2 db 10,'smallest number: $'  ; Prompt for displaying smallest number
str3 db 100 dup('$')             ; Array buffer
.code
mov ax,@data
mov ds,ax
mov ah,09h                       ; DOS service - print string
lea dx,str1
int 21h
mov ah,0ah                       ; DOS service - buffered input
lea dx,str3
int 21h
mov si, offset str3+2            ; Point SI to start of array
mov bl,[si]                      ; Initialize smallest number to first element
smallest:                        ; Loop to find smallest number
mov dl,[si]
cmp dl,'$'
je printno                      ; Exit loop if end of array
cmp bl,dl
jg next                          ; Jump if current number is smaller
back:                            ; Continue comparing
inc si
jmp smallest
next:                            ; Update smallest number
mov bl,dl
jmp back
printno:                         ; Print the smallest number
mov ah,09h                       ; DOS service - print string
lea dx,str2
int 21h
mov dl,bl
mov ah,02h                       ; DOS service - print character
int 21h
mov ah,4ch                       ; DOS service - terminate program
int 21h
end
