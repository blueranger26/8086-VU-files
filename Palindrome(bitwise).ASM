.model small
.stack 100h
.data
input_data db 9Ah ; Example 8-bit data to check for bitwise palindrome
is_palindrome db ? ; Variable to store the result (1 if palindrome, 0 if not)
.code
main:
 mov al, input_data ; Move the input data into AL register
 mov bl, al ; Copy the input data into BL register for comparison
 mov cl, 7 ; Set the loop counter to 7 (total bits - 1)
check_palindrome:
 shr al, 1 ; Shift right AL to get the least significant bit
 rcr bl, 1 ; Rotate right BL through carry to get the most significant bit
 cmp al, bl ; Compare the bits
 jne not_palindrome ; If not equal, jump to not_palindrome
 loop check_palindrome ; Loop until all bits are checked
 ; If control reaches here, the data is a bitwise palindrome
 mov is_palindrome, 1 ; Set is_palindrome to 1 (true)
 jmp end_program ; Jump to the end of the program
not_palindrome:
 mov is_palindrome, 0 ; Set is_palindrome to 0 (false)
end_program:
 ; Print the result
 mov ah, 09h ; DOS function for printing string
 mov dx, offset msg_result ; DX points to the offset of message
 int 21h ; Call DOS
 mov dl, is_palindrome ; Load the result into DL
 add dl, '0' ; Convert the result to ASCII
 mov ah, 02h ; DOS function for printing character
 int 21h ; Call DOS
 ; Exit program
 mov ax, 4C00h ; DOS function for program termination
 int 21h ; Call DOS
msg_result db "Is Bitwise Palindrome? $"
end main