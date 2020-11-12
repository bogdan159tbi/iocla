%include "../utils/printf32.asm"

%define ARRAY_SIZE    7

section .data
    vector db 1, 2, 3, 127, -1, -2, -127
    negativ db "Number of negative numbers: ",0
    pozitiv db "Number of positive numbers: ",  0

section .text
global main
extern printf
main:
    ;write your code here
    push ebp
    mov ebp, esp
    xor eax, eax
    xor edx, edx
    mov ecx, ARRAY_SIZE
count:
    mov al, byte [vector + ecx - 1]
    test al, al
    js negative
positive:
    inc dl
    loop count
    jmp finish
negative:
    inc dh
    loop count
    jmp finish

finish:
    PRINTF32 `%s\x0`, negativ
    xor ebx, ebx
    mov bl, dh
    PRINTF32 `%d\n\x0`, ebx
    
    xor ebx, ebx
    PRINTF32 `%s\x0`, pozitiv  
    mov bl, dl
    PRINTF32 `%d\n\x0`, ebx

    leave
    ret