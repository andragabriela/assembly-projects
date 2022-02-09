bits 32 ; assembling for the 32 bits architecture
;c+(a*a-b+7)/(2+a), a-byte; b-doubleword; c-qword
; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 2
    b dd 3
    c dq 4
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;c+(a*a-b+7)/(2+a), a-byte; b-doubleword; c-qword
    mov al, [a]
    imul al 
    cbw 
    cwde;eax=a*a
    sub eax, [b]
    add eax, 7 ;eax=(a*a-b+7) 
    mov ebx, eax 
    mov al, [a]
    add al, 2
    cbw
    cwde
    mov ecx, eax ; ecx=(2+a)
    mov eax, ebx 
    cdq
    idiv ecx
    add eax, [c]
    adc edx, [c+4]   
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
