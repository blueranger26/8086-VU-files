.model small 
.stack 100h 
.code  
main proc 
  
mov ah,01h 
int 21h 
mov dl,al 
mov ah,02h 
add dl,20h 
mov al,dl 
int 21h 
mov ah,4ch   
int 21h
main endp 
end  main

