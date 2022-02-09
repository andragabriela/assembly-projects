bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf,scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll    
import scanf msvcrt.dll    
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
;Sa se citeasca de la tastatura doua numere (in baza 10) si sa se calculeze produsul lor. 
;Rezultatul inmultirii se va salva in memorie in variabila "rezultat" (definita in segmentul de date).

    format_scanf db "%d %d",0
    rezultat db "produsul lor este %lld", 0
    rezultat2 resq 1
    a dd 0
    b dd 0
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
    mul dword [b]
    
    mov [rezultat2],eax
    mov [rezultat2+4], edx
    push rezultat2
    push rezultat2+4
    push rezultat 
    call [printf]
    add esp, 4*2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
