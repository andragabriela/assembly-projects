bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
;Se citesc de la tastatura doua numere a si b. Sa se calculeze valoarea expresiei (a+b)*k,
; k fiind o constanta definita in segmentul de date. Afisati valoarea expresiei (in baza 10).
        k db 5
        a dd 0
        b dd 0
        format_scanf db "%d %d", 0
        rezultat db "rezultatul este %d", 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
    push dword b
    push dword a 
    push format_scanf
    call [scanf]
    add esp, 4*3
    
    mov eax, [a]
    add eax, [b]
    mul byte[k]
    
    push eax 
    push rezultat
    call [printf]
    add esp, 4*2
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
