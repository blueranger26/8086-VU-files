.model small
.stack 100h
.data
str1 db 'give an array of numbers: $'    ; Prompt for array input
str2 db 10,'sorted array: $'              ; Prompt for displaying sorted array
buffer db 100 dup('$')                    ; Array buffer
sizea db 00h                              ; Variable to store array size
.code
mov ax,@data
mov ds,ax
mov ah,09h                               ; DOS service - print string
lea dx,str1
int 21h
mov ah,0ah                               ; DOS service - buffered input
lea dx,buffer
int 21h
mov cl,buffer+1                          ; Load array size into CL
mov sizea,cl                             ; Store array size
mov ax,0                                 ; Initialize loop counter
mov bx,0                                 ; Initialize loop counter
loop1:
mov dl,sizea                            ; Load array size - 1 into DL
dec dl
mov si,offset buffer+2                  ; Point SI to start of array
loop2:
mov al,[si]                             ; Load current element into AL
mov bl,[si+1]                           ; Load next element into BL
cmp bl,al                               ; Compare current and next elements
jg repl                                  ; Jump if next element is greater
back:                                   ; Continue loop
inc si                                  ; Move to next element
dec dl                                  ; Decrement loop counter
cmp dl,0                                ; Check if end of array reached
jne loop2                               ; If not, repeat inner loop
dec cl                                  ; Decrement array size
cmp cl,0                                ; Check if all elements compared
jne loop1                               ; If not, repeat outer loop
jmp printno                             ; Jump to print sorted array
repl:                                   ; Swap elements if necessary
mov [si],bl                             ; Move next element to current position
mov [si+1],al                           ; Move current element to next position
jmp back                                ; Continue loop
printno:                                ; Print the sorted array
mov dx,0000h                            ; Clear DX
mov ah,09h                              ; DOS service - print string
lea dx,str2
int 21h
mov ah,09h                              ; DOS service - print string
lea dx,buffer+2
int 21h
mov ah,4ch                              ; DOS service - terminate program
int 21h
end
