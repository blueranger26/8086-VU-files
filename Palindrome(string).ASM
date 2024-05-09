.model small
.stack

.data
 msg db 10, 13, "Palindrome$"
 not_msg db 10, 13, "Not a Palindrome$"
 input db 6 dup('$')
 len equ $ - input
 start_idx equ len - 2
 mid_idx equ len / 2

.code
main proc
  mov ax, @data
  mov ds, ax

  ;input the number
  mov ah, 0ah
  lea dx, input
  int 21h

  ;input the number
  mov ah, 0ah
  lea dx, input
  int 21h

  ;check for palindrome
  mov si, start_idx
  mov di, mid_idx
 check_palindrome:
  cmp si, mid_idx
  jge is_palindrome
  mov al, [input + si]
  mov bl, [input + di]
  cmp al, bl
  jne not_palindrome
  inc si
  dec di
  jmp check_palindrome

is_palindrome:
 mov ah, 09h
 lea dx, msg
 int 21h
 jmp end_program

not_palindrome:
 mov ah, 09h
 lea dx, not_msg
 int 21h

end_program:
 mov ah, 4ch
 int 21h
main endp
end main
