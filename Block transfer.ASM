data segment
src db 10h, 20h, 30h, 40h, 50h, 60h, 70h, 0ffh, 90h, 0a0h  ; Source data array
data ends

extra segment
dest db 0ah dup(?)  ; Destination data array, uninitialized
extra ends

code segment
assume cs: code, ds:data, es:extra  ; Assumption of code, data, and extra segments
start:
;initialize data segment

mov ax, data  ; Move data segment address into AX
mov ds, ax    ; Load data segment address into DS

lea si, src   ; Load effective address of source array into SI
lea di, dest  ; Load effective address of destination array into DI
mov cx, 0ah   ; Set CX to the number of elements to transfer (10 in this case)

up:            ; Loop label
movsb          ; Move a byte from DS:SI to ES:DI
loop up       ; Decrement CX and loop until CX is zero

mov ax, 4c00h  ; Set up for an exit to DOS
int 21h        ; Call DOS to terminate the program

code ends
end start
