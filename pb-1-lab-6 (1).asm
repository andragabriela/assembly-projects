bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        
;pentru sirul initial:
;127F5678h, 0ABCDABCDh, ... 
;Se va obtine:
;006800F7h,  0FF56FF9Ah 
; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    s dd 127F5678h, 0ABCDABCDh
    l equ ($-s)/4
    d times l dd 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov esi, s
    mov edi, d 
    mov ecx, l
    mov bx,0
    cld
        repeta:
            ; incarc primul cuvant
            lodsw
            
            ; salvez primul cuvant
            mov bl, al
            mov bh, ah
            
            ; incarc al doilea cuvant
            lodsw
            
            ; salvez al doilea cuvant
            mov dl, al
            mov dh, ah
            
            ; ordin par
            add bl, dl
            mov al, bl
            mov ah,0
            cbw
            stosw
            
            ; ordin impar
            add bh, dh
            mov al, bh
            mov ah,0
            cbw
            stosw
        loop repeta
                
            
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
