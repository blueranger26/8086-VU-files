.model small     ; Memory model: small
.stack 100h      ; Stack size: 100h bytes

.data             ; Start of data segment

num1   dw 1234h   ; Variable num1 with value 1234h
num2   dw 4567h   ; Variable num2 with value 4567h
res_LB db 00h     ; Result least significant byte
res_MB db 00h     ; Result middle significant byte
res_HB db 00h     ; Result most significant byte

.code             ; Start of code segment

proc main         ; Start of main procedure

mov ax, @data     ; Load data segment address
mov ds, ax        ; Set data segment register

mov ax, num1      ; Load num1 into AX
mov bx, num2      ; Load num2 into BX
add ax, bx        ; Add num1 and num2, result in AX

mov res_LB, al    ; Store least significant byte of result
mov res_MB, ah    ; Store middle significant byte of result

mov cl, 00h       ; Clear carry flag
adc cl, 00h       ; Check if there's carry, store in res_HB

mov ah, 4Ch       ; Set exit code
int 21h           ; Terminate program

main endp         ; End of main procedure

end main          ; End of program
