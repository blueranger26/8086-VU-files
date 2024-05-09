.model small
.stack 100h
.data
str1 db 'Give a array of numbers: $'   ; Prompt for array input
str2 db 10,'Average: $'                  ; Prompt for displaying average
buffer db 100 dup('$')                   ; Array buffer
str3 db 10,'Quotient: $'                 ; Prompt for displaying quotient
str4 db 10,'Remainder: $'                ; Prompt for displaying remainder
.code
mov ax,@data
mov ds,ax
mov ah,09                               ; DOS service - print string
lea dx,str1
int 21h
mov ah,0ah                              ; DOS service - buffered input
lea dx,buffer
int 21h
mov si,offset buffer+2                  ; Point SI to start of array
mov ax,0                                ; Initialize sum
mov cx,0                                ; Initialize counter
mov cl,buffer+1                         ; Get count of numbers
sum:
mov bl,[si]                             ; Load current digit
sub bl,30h                              ; Convert ASCII to number
add al,bl                               ; Add to sum
inc si                                  ; Move to next digit
dec cl                                  ; Decrement counter
cmp cl,0                                ; Check if all digits processed
jne sum                                 ; If not, repeat summing
mov cl,buffer+1                        ; Reset counter
mov bx,ax                              ; Copy sum to BX
div cl                                 ; Divide sum by count of numbers
mov bx,ax                              ; Copy quotient to BX
mov ah,09h                             ; DOS service - print string
lea dx,str2
int 21h
mov ah,09h                             ; DOS service - print string
lea dx,str3
int 21h
mov dx,0
mov al,bl
and al,0f0h                            ; Extract tens place of quotient
rol al,4                               ; Rotate left to correct position
add al,30h                             ; Convert to ASCII
mov dl,al
mov ah,02h                             ; DOS service - print character
int 21h
mov al,bl
and al,0fh                             ; Extract ones place of quotient
add al,30h                             ; Convert to ASCII
mov dl,al
mov ah,02h                             ; DOS service - print character
int 21h
mov ah,09h                             ; DOS service - print string
lea dx,str4
int 21h
mov dx,0
mov al,bh
and al,0f0h                            ; Extract tens place of remainder
rol al,4                               ; Rotate left to correct position
add al,30h                             ; Convert to ASCII
mov dl,al
mov ah,02h                             ; DOS service - print character
int 21h
mov al,bh
and al,0fh                             ; Extract ones place of remainder
add al,30h                             ; Convert to ASCII
mov dl,al
mov ah,02h                             ; DOS service - print character
int 21h
mov ah,4ch                             ; DOS service - terminate program
int 21h
end
