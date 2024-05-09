.model small     ; Memory model: small
.stack 100h      ; Stack size: 100h bytes

.data             ; Start of data segment

buffer db 100 dup('$')   ; Input buffer
str1 db 'enter a string : $'  ; Prompt for input
str2 db 10,13,'reversed string is : $'  ; Message for reversed string

.code             ; Start of code segment

mov ax, @data     ; Load data segment address
mov ds, ax        ; Set data segment register
mov es, ax        ; Set extra segment register

mov ah, 09h       ; Print prompt for input
lea dx, str1      ; Load prompt address
int 21h           ; Call DOS interrupt

mov ah, 0ah       ; Buffered input function
lea dx, buffer    ; Load buffer address
int 21h           ; Get input string

lea si, buffer + 2  ; SI points to start of input string
lea di, buffer + 2  ; DI points to end of input string
mov bl, [buffer + 1]  ; Load string length
add di, bx        ; Move DI to end of string
dec di            ; Adjust DI to last character

reverse_loop:    ; Reverse loop
cmp di, si        ; Compare DI with SI
jle print_reversed  ; Jump if DI is less than or equal to SI
mov al, [si]      ; Load byte from start of string into AL
xchg al, [di]     ; Swap bytes at start and end of string
mov [si], al      ; Store byte at start of string
inc si            ; Move SI to next character
dec di            ; Move DI to previous character
jmp reverse_loop  ; Repeat until entire string is reversed

print_reversed:   ; Print reversed string
mov ah, 09h       ; Print message for reversed string
lea dx, str2      ; Load message address
int 21h           ; Call DOS interrupt
mov ah, 09h       ; Print reversed string
lea dx, buffer + 2  ; Load reversed string address
int 21h           ; Call DOS interrupt

mov ah, 4ch       ; Terminate program
int 21h           ; Call DOS interrupt

end               ; End of program
