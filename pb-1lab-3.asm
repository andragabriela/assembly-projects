bits 32 ; assembling for the 32 bits architecture
; c-(a+d)+(b+d) a - byte, b - word, c - double word, d - qword - Interpretare fara semn
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
    b dw 1
    c dd 3
    d dq 3
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;c-(a+d)+(b+d) a - byte, b - word, c - double word, d - qword - Interpretare fara semn
        mov al, [a]
        mov ah, 0
        mov dx, 0
        push dx 
        push ax 
        pop eax 
        add eax, [d]
        adc edx, [d+4]       ; eax= a+d
        mov ebx, [c]
        mov ecx, [c+4]
        sub ebx, eax  ;ecx:ebx= c-(a+d)
        sbb ecx, edx  
        mov ax, [b]
        mov dx, 0
        push dx 
        push ax 
        pop eax
        mov edx, 0
        add eax, [d]
        adc edx, [d+4]
        add ebx, eax 
        adc ecx, edx 
        
       
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
