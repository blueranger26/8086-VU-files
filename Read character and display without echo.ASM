.model small
.stack 50
.data
.code
         main proc
         mov ah,08h
         int 21h
         mov dl,al
         mov ah,02h
         int 21h
   main endp
   end main
