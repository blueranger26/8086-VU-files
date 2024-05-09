.model small
.stack 100h
.data
packed_bcd db 46h ; Packed BCD number
unpacked_bcd1 db ? ; Variable to store the first unpacked BCD digit
unpacked_bcd2 db ? ; Variable to store the second unpacked BCD digit
.code
main:
 mov al, packed_bcd ; Move the packed BCD number into AL register
 mov ah, al ; Copy the packed BCD number to AH register
 and al, 0Fh ; Mask the lower nibble to extract the first BCD digit
 and ah, 0F0h ; Mask the upper nibble to extract the second BCD digit
 shr ah, 4 ; Shift the second BCD digit to the right
 mov unpacked_bcd1, al ; Store the first unpacked BCD digit
 mov unpacked_bcd2, ah ; Store the second unpacked BCD digit
 ; Print the result
 mov ah, 09h ; DOS function for printing string
 mov dx, offset msg_unpacked_bcd ; DX points to the offset of message
 int 21h ; Call DOS
 mov dl, unpacked_bcd1 ; Load the first unpacked BCD digit into DL
 call print_bcd ; Call print_bcd subroutine to print DL
 mov dl, unpacked_bcd2 ; Load the second unpacked BCD digit into DL
 call print_bcd ; Call print_bcd subroutine to print DL
 ; Exit program
 mov ax, 4C00h ; DOS function for program termination
 int 21h ; Call DOS
print_bcd proc near
 add dl, '0' ; Convert the BCD digit to ASCII
 mov ah, 02h ; DOS function for printing character
 int 21h ; Call DOS
 ret
print_bcd endp
msg_unpacked_bcd db "Unpacked BCD Numbers: $"
end main
OUT