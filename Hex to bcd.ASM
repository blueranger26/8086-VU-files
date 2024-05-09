; ALP for conversion of 16-bit HEX number into its equivalent BCD number.

DATA SEGMENT
    HEX DW 0FFFFH       ; Define a 16-bit hexadecimal number
    BCD DW 5 DUP(0)     ; Define an array to store the BCD number
DATA ENDS   

ASSUME CS:CODE,DS:DATA  

CODE SEGMENT 
    
START:
    MOV AX,DATA         ; Initialize the data segment
    MOV DS,AX
       
    LEA SI,BCD          ; Load the offset address of the BCD array into SI
    MOV AX,HEX          ; Load the hexadecimal number into AX
   
    MOV CX,2710H        ; Set CX to 10000 (hexadecimal) or 65536 (decimal)
    CALL SUB1           ; Call subroutine SUB1 to convert the most significant digit
    
    MOV CX,03E8H        ; Set CX to 1000 (hexadecimal) or 4096 (decimal)
    CALL SUB1           ; Call subroutine SUB1 to convert the next significant digit
    
    MOV CX,0064H        ; Set CX to 100 (hexadecimal) or 256 (decimal)
    CALL SUB1           ; Call subroutine SUB1 to convert the next significant digit
    
    MOV CX,000AH        ; Set CX to 10 (hexadecimal) or 16 (decimal)
    CALL SUB1           ; Call subroutine SUB1 to convert the least significant digit
    
    MOV [SI],AL         ; Store the converted BCD number
    
    MOV AH,4CH          ; Exit program
    INT 21H

SUB1 PROC NEAR
    MOV BH,0FFH         ; Initialize BH to 255
    
X1: 
    INC BH              ; Increment BH
    SUB AX,CX           ; Subtract CX from AX
    JNC X1              ; Jump if no carry (AX >= CX)
    ADD AX,CX           ; Restore AX by adding CX
    MOV [SI],BH         ; Store the BCD digit in memory
    INC SI              ; Move to the next digit in the BCD array
    RET                 ; Return from subroutine
SUB1 ENDP

CODE ENDS
END START
