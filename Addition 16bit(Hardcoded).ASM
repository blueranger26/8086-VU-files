.model small     ; Memory model: small
.stack 100h      ; Stack size: 100h bytes

.data             ; Start of data segment

n1 dw 3000h       ; Define a word-sized variable n1 with value 3000h
n2 dw 5000h       ; Define a word-sized variable n2 with value 5000h

.code             ; Start of code segment

main proc         ; Start of main procedure

mov ax, @data     ; Load the address of the data segment into AX
mov ds, ax        ; Set the data segment register (DS) to the loaded address

mov bx, n1        ; Move the value of n1 into BX
add bx, n2        ; Add the value of n2 to BX, result in BX

mov ax, bx        ; Move the result in BX to AX
mov ah, 4Ch       ; Move the exit code into AH
int 21h           ; Call DOS interrupt 21h to terminate the program

main endp         ; End of main procedure

end main          ; End of program
