bits 32 ; assembling for the 32 bits architecture
; declare the EntryPoint (a label defining the very first instruction of the program)
global start        
;Se dau cuvintele A si B. Sa se obtina dublucuvantul C:
;bitii 0-4 ai lui C coincid cu bitii 11-15 ai lui A
;bitii 5-11 ai lui C au valoarea 1
;bitii 12-15 ai lui C coincid cu bitii 8-11 ai lui B
;bitii 16-31 ai lui C coincid cu bitii lui A
; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dw 0111011101010111b
    b dw 1001101110111110b
    c resd 1 ; c=01110111010101111011111111101110b
; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov ebx, 0
    mov ax, [a] 
    and ax, 1111100000000000b
    mov cl, 11
    ror ax, cl 
    mov dx, 0
    push dx 
    push ax
    pop eax 
    or ebx, eax 
    
    or ebx, 0000111111100000b
    
    mov  ax, [b]
    and  ax, 0000111100000000b
    mov  cl, 4
    rol  ax, cl ; rotim 4 pozitii spre stanga
    mov dx, 0
    push dx 
    push ax
    pop eax 
    or ebx, eax ; punem bitii in rezultat
    
    mov [c], ebx
    mov ax, [a]
    or [c+2], ax
    
    mov ebx, [c]
      
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
