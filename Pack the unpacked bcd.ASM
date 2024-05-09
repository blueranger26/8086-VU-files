.model small
.stack 100h
.data
bcd1 db 12h ; First unpacked BCD number
bcd2 db 34h ; Second unpacked BCD number
packed_bcd db ? ; Variable to store the packed BCD number
.code
main:
 mov al, bcd1 ; Move the first unpacked BCD number into AL register
 shl al, 4 ; Shift AL 4 bits to the left to make room for the second BCD
number
 mov ah, bcd2 ; Move the second unpacked BCD number into AH register
 or al, ah ; Combine AL and AH using bitwise OR operation
 mov packed_bcd, al ; Store the packed BCD number
 ; Print the result
 mov ah, 09h ; DOS function for printing string
 mov dx, offset msg_packed_bcd ; DX points to the offset of message
 int 21h ; Call DOS
 mov dl, packed_bcd ; Load the packed BCD number into DL
 call print_bcd ; Call print_bcd subroutine to print DL
 ; Exit program
 mov ax, 4C00h ; DOS function for program termination
 int 21h ; Call DOS
print_bcd proc near
 push ax ; Save AX register
 push dx ; Save DX register
 ; Extract and print the tens digit
 mov ah, dl ; Move the packed BCD number into AH register
 and ah, 0F0h ; Mask out the lower nibble (ones digit)
 shr ah, 4 ; Shift right to get the tens digit
 add ah, '0' ; Convert to ASCII
 mov dl, ah ; Move the ASCII character to DL
 mov ah, 02h ; DOS function for printing character
 int 21h ; Call DOS
 ; Extract and print the ones digit
 mov ah, dl ; Move the packed BCD number into AH register
 and ah, 0Fh ; Mask out the upper nibble (tens digit)
 add ah, '0' ; Convert to ASCII
 mov dl, ah ; Move the ASCII character to DL
 mov ah, 02h ; DOS function for printing character
 int 21h ; Call DOS
 pop dx ; Restore DX register
 pop ax ; Restore AX register
 ret
print_bcd endp
msg_packed_bcd db "Packed BCD Number: $"
end main
