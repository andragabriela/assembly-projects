bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, printf, fread               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll
import printf msvcrt.dll
import fread msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    nume_fisier_in db "in.txt",0
    mod_r db "r",0
    id_file_in resd 1
    vocale db 0,0,0
    rezultat db "Rezultatul este %d", 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;deschide fisierul
        push mod_r
        push nume_fisier_in
        call [fopen]
        add esp, 4*2
        
        mov ecx, 0; numar vocalele
        
        test eax, eax 
        jz eroare
        mov [id_file_in], eax 
        
        count:
        push ecx 
        ;citesc datele din fisier
        push dword [id_file_in]
        push dword 1
        push dword 1
        push dword vocale 
        call [fread]
        add esp, 4*4 
        
        pop ecx 
        cmp al, 0;daca nu mai sunt litere iese
        je exit2 
        mov al ,[vocale]
        cmp al, "a"
        je vocala_gasita
        cmp al, "e"
        je vocala_gasita
        cmp al, "i"
        je vocala_gasita
        cmp al, "o"
        je vocala_gasita
        cmp al, "u"
        je vocala_gasita
        cmp al, "A"
        je vocala_gasita
        cmp al, "E"
        je vocala_gasita
        cmp al, "O"
        je vocala_gasita
        cmp al, "U"
        je vocala_gasita
        cmp al, "I"
        je vocala_gasita
        
        jmp count
        
        vocala_gasita:
        inc ecx 
        jmp count 
        
        
        exit2:
        mov eax, ecx
        push eax
        push rezultat
        call [printf]
        add esp, 4*2
    
        
        
        eroare:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
