.model small
.stack 100h

.data
    prompt_msg db 0ah, 0dh, 'Enter marks for subject (out of 10): $'
    grade_msg db 0ah, 0dh, 'Your overall percentage: $'
    grade_display_msg db 0ah, 0dh, 'Your grade is: $'
    subjects db 5 dup (?)  ; Array to store marks for 5 subjects

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Take input for 5 subjects
    mov cx, 5       ; Counter for the loop
    mov bx, 0       ; Initialize BX to zero
    mov si, offset subjects  ; SI points to the beginning of the subjects array

input_loop:
    push cx         ; Save CX
    push bx         ; Save BX
    mov ah, 09h     ; DOS function to print string
    lea dx, prompt_msg  ; Load address of prompt message
    int 21h         ; Print the prompt message
    mov ah, 01h     ; DOS function to read character from standard input
    int 21h         ; Read character
    sub al, '0'    ; Convert ASCII character to integer
    mov [si], al   ; Store the entered mark in the subjects array
    inc si         ; Move to the next element in the subjects array
    pop bx          ; Restore BX
    inc bx          ; Increment BX (loop counter)
    pop cx          ; Restore CX
    loop input_loop    ; Repeat until all 5 subjects are entered

    ; Calculate total marks
    mov ax, 0       ; Clear AX (accumulator for total marks)
    mov bx, 0       ; Clear BX (index for subjects array)
    mov cx, 5       ; Set CX to 5 (number of subjects)
    mov si, offset subjects  ; SI points to the beginning of the subjects array

total_loop:
    mov dl, [si]   ; Load mark of current subject into DL
    add ax, dx     ; Add mark to total marks
    inc si         ; Move to the next element in the subjects array
    loop total_loop  ; Repeat for all subjects

    ; Calculate percentage
    mov bx, 50     ; Total possible marks = 5 * 10
    mov dx, 0      ; Clear DX before division
    div bx         ; AX = (total marks / 50)
    mov cx, 100    ; CX = 100
    mul cx         ; DX:AX = (total marks / 50) * 100
    mov bl, al     ; BL = percentage

    ; Display percentage
    mov ah, 09h    ; DOS function to print string
    lea dx, grade_msg  ; Load address of grade message
    int 21h        ; Print the grade message
    cmp bl, 0      ; Check if percentage is 0
    je print_zero  ; If zero, print special message
    mov dl, bl     ; Move percentage to DL (convert to ASCII)
    add dl, '0'    ; Convert to ASCII character
    mov ah, 02h    ; DOS function to print character
    int 21h        ; Print the percentage
    mov dl, '%'    ; Load '%' character
    int 21h        ; Print the '%' character
    jmp display_grade  ; Jump to display_grade

print_zero:
    mov dx, offset zero_percent  ; Load address of zero percent message
    int 21h        ; Print the zero percent message

display_grade:
    ; Display grade based on percentage
    mov ah, 09h    ; DOS function to print string
    lea dx, grade_display_msg  ; Load address of grade display message
    int 21h        ; Print the grade display message

    cmp bl, 90     ; Check if percentage is greater than or equal to 90
    jae print_A    ; If true, print grade A
    cmp bl, 80     ; Check if percentage is greater than or equal to 80
    jae print_B    ; If true, print grade B
    cmp bl, 70     ; Check if percentage is greater than or equal to 70
    jae print_C    ; If true, print grade C
    cmp bl, 60     ; Check if percentage is greater than or equal to 60
    jae print_D    ; If true, print grade D
    jmp print_F    ; If none of the above conditions are true, print grade F

print_A:
    mov dl, 'A'    ; Load grade A
    jmp print_grade  ; Jump to print_grade

print_B:
    mov dl, 'B'    ; Load grade B
    jmp print_grade  ; Jump to print_grade

print_C:
    mov dl, 'C'    ; Load grade C
    jmp print_grade  ; Jump to print_grade

print_D:
    mov dl, 'D'    ; Load grade D
    jmp print_grade  ; Jump to print_grade

print_F:
    mov dl, 'F'    ; Load grade F

print_grade:
    mov ah, 02h    ; DOS function to print character
    int 21h        ; Print the grade

    mov ah, 4ch    ; DOS function to terminate program
    int 21h        ; Terminate program

main endp

.data
    zero_percent db '0%$'  ; Special message for zero percent

end main
