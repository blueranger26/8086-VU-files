;ALP to copy the string of successive memory locations from one memory to
;other
;Without using string instructions

DATA SEGMENT
    SOURCE DB "BIOMEDICAL" ; Source string to be copied
DATA ENDS

EXTRA SEGMENT
    DEST DB ? ; Destination buffer
EXTRA ENDS

CODE SEGMENT
    ASSUME CS:CODE , DS:DATA, ES:EXTRA ; Set up the segment registers
    START : MOV AX,DATA      ; Load the address of the DATA segment into AX
            MOV DS,AX        ; Initialize the DS (Data Segment) register
            MOV AX,EXTRA     ; Load the address of the EXTRA segment into AX
            MOV ES,AX        ; Initialize the ES (Extra Segment) register
            
            MOV SI,00H       ; Initialize SI (Source Index) to 0
            MOV DI,00H       ; Initialize DI (Destination Index) to 0
            MOV SI,OFFSET SOURCE ; Load the offset address of SOURCE into SI
            MOV DI,OFFSET DEST   ; Load the offset address of DEST into DI
            MOV CX,000AH     ; Set the loop counter CX to the length of the string (10 characters)
         
         X: MOV AL,SOURCE [SI]  ; Move byte from source string to AL
            MOV DEST [DI],AL    ; Move byte from AL to destination buffer
            INC SI              ; Increment SI to point to the next byte in source string
            INC DI              ; Increment DI to point to the next byte in destination buffer
            LOOP X              ; Repeat until CX is zero (10 iterations)
            
            MOV AH,4CH          ; DOS function for program termination
            INT 21H             ; Invoke DOS interrupt
CODE ENDS
END START
