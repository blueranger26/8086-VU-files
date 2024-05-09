;***************************************************
;
; Concatenation of strings in 8086 ALP

;macro for printing a string
print macro m
mov ah,09h       ; DOS function for displaying a string
mov dx,offset m  ; Load the offset address of the string into DX
int 21h          ; Invoke DOS interrupt to print the string
endm

.model small


;******  Data Segment ******
.data

empty db 10,13, "   $"    ; Empty line for formatting
str1 db 25,?,25 dup('$')   ; First string buffer
str2 db 25,?,25 dup('$')   ; Second string buffer

mstring db 10,13, "Enter the string: $"        ; Prompt for the first string
mstring2 db 10,13, "Enter second string: $"    ; Prompt for the second string
mconcat db 10,13, "Concatenated string: $"     ; Message for the concatenated string

;********** Code Segment ************

.code

start:
mov ax,@data   ; Load the address of the data segment into AX
mov ds,ax     ; Initialize the data segment register (DS) with the address in AX

	   print mstring   ; Display prompt for the first string
	   call accept_string     ; Call the procedure to accept the first string   
	   
	   ;storing string in str2
	   print mstring2   ; Display prompt for the second string
	   mov ah,0ah      ; DOS function for reading a string from input with buffer
	   lea dx,str2     ; Load the offset address of str2 into DX
	   int 21h         ; Invoke DOS interrupt to read the string
	   
 	   
	   mov cl,str1+1         ; Length of string1 in cl (excluding length byte)
	   mov si,offset str1    ; Load the offset address of str1 into SI
next:  inc si                ; Move to the next byte
	   dec cl                ; Decrement the loop counter
	   jnz next              ; Jump if counter is not zero
	   inc si                ; Move to the next byte
	   
	   inc si                  ; Move to the first character of str1
	   mov di,offset str2     ; Load the offset address of str2 into DI
	   inc di                  ; Move to the first character of str2
	   inc di                  ; Skip the length byte of str2
	   
	   mov cl,str2+1          ; Length of string2 in cl (excluding length byte)
move_next:
     	   
	       mov al,[di]        ; Move byte from str2 to AL
	       mov [si],al        ; Move byte from AL to str1
		   inc si             ; Move to the next byte in str1
		   inc di             ; Move to the next byte in str2
		   dec cl             ; Decrement the loop counter
		   jnz move_next      ; Jump if counter is not zero
		   
		   print mconcat       ; Display message for concatenated string
		   print str1+2       ; Display the concatenated string

		   
exit:
mov ah,4ch       ; Exit the program
int 21h          ; Invoke DOS interrupt

;accept procedure

accept proc near

mov ah,01        ; DOS function for reading a character from input
int 21h          ; Invoke DOS interrupt
ret              ; Return from procedure
accept endp

; Procedure to display a byte in hexadecimal
display1 proc near

   mov al,bl       ; Move the byte to AL
   mov bl,al       ; Move AL to BL
   and al,0f0h     ; Mask the upper nibble
   mov cl,04       ; Shift bits to the right by 4 positions
   rol al,cl       ; Rotate AL left by CL positions

   cmp al,09       ; Compare AL with 9
   jbe number      ; Jump if below or equal to 9
   add al,07       ; Add 7 to convert to ASCII for letters
number:  
   add al,30h      ; Convert AL to ASCII
   mov dl,al       ; Move AL to DL (for displaying)
   mov ah,02       ; DOS function for displaying a character
   int 21h         ; Invoke DOS interrupt

   mov al,bl       ; Move the byte to AL
   and al,00fh     ; Mask the lower nibble
   cmp al,09       ; Compare AL with 9
   jbe number2     ; Jump if below or equal to 9
   add al,07       ; Add 7 to convert to ASCII for letters
number2:  
   add al,30h      ; Convert AL to ASCII
   mov dl,al       ; Move AL to DL (for displaying)
   mov ah,02       ; DOS function for displaying a character
   int 21h         ; Invoke DOS interrupt
ret               ; Return from procedure
display1 endp

; Procedure to accept a string from input
accept_string proc near

mov ah,0ah          ; DOS function for reading a string from input
mov dx,offset str1  ; Store the string in memory pointed by "DX"
int 21h             ; Invoke DOS interrupt
ret                 ; Return from procedure
accept_string endp

end start
end
