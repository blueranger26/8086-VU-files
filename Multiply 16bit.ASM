model small
.stack 100h
.data
num1 db 10 ; First 8-bit number
num2 db 5 ; Second 8-bit number
result dw ? ; Result stored in a 16-bit variable
.code
main:
 mov al, num1 ; Move the first 8-bit number into AL register
 mov bl, num2 ; Move the second 8-bit number into BL register
 cbw ; Convert AL to AX (sign extend AL into AX)
 cbw ; Convert BL to BX (sign extend BL into BX)
 imul bx ; Multiply AL by BL, result in AX
 mov result, ax ; Store the result in the 16-bit variable 'result'
 ; Print the result
 mov ah, 09h ; DOS function for printing string
 mov dx, offset msg_result ; DX points to the offset of message
 int 21h ; Call DOS
 mov ax, result ; Load result back into AX
 call print_num ; Call print_num subroutine to print AX
 ; Exit program
 mov ax, 4C00h ; DOS function for program termination
 int 21h ; Call DOS
print_num proc near
 push ax ; Save AX register
 mov ah, 0 ; Set AH to 0 for single character print
 ; Convert AX to ASCII
 mov bx, 10 ; BX = 10 for division
 mov cx, 0 ; CX to hold count of digits
 @@loop:
 xor dx, dx ; Clear DX for division
 div bx ; Divide AX by 10, quotient in AX, remainder in DX
 push dx ; Push remainder onto stack
 inc cx ; Increment digit count
 test ax, ax ; Check if quotient is zero
 jnz @@loop ; If not zero, continue division
 @@print_loop:
 pop dx ; Pop digit from stack
 add dl, '0' ; Convert digit to ASCII
 mov ah, 02h ; DOS function to print character
 int 21h ; Call DOS
 loop @@print_loop ; Continue printing until all digits printed
 pop ax ; Restore original AX value
 ret
print_num endp
msg_result db "The result is: $"
end main