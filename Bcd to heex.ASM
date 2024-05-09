; ALP for conversion of 16-bit BCD number into its equivalent HEX number.

DATA SEGMENT
    BCD DB 06H,05H,05H,03H,05H  ; Define a 5-byte BCD number
    HEX DW ?                     ; Define a 16-bit variable to store the hexadecimal number
DATA ENDS

ASSUME CS:CODE,DS:DATA

CODE SEGMENT

START:
    MOV AX,DATA     ; Initialize the data segment
    MOV DS,AX

    MOV CL,05H      ; Set loop counter to 5 (number of BCD digits)
    MOV BP,000AH    ; Set BP to 10 for BCD to HEX conversion
    MOV AX,2710H    ; Initialize AX to 10000 (for multiplication)
    PUSH AX         ; Save AX on stack for later use
    MOV DI,0000H    ; Initialize DI to 0 (to store result)
    MOV SI, OFFSET BCD  ; Load the offset address of the BCD array into SI

X:
    MOV BL,[SI]     ; Move BCD digit into BL
    MUL BX          ; Multiply AX by BL
    ADD DI,AX       ; Add the result to DI
    POP AX          ; Restore original AX value
    DIV BP          ; Divide DX:AX by 10
    PUSH AX         ; Save the remainder (DX) on stack for next iteration
    INC SI          ; Move to the next BCD digit
    LOOP X          ; Repeat loop for all BCD digits
    MOV HEX,DI     ; Store the hexadecimal result in HEX

    MOV AH,4CH      ; Terminate program
    INT 21H         ; Invoke DOS interrupt

CODE ENDS
END START
