%include "../utils/printf32.asm"

%define ARRAY_SIZE    7

section .data
    vector db 1,3,512,2,4,6,8
    odds db "Number of odd numbers: ",0
    evens db "Number of even numbers: ",  0

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
    test al, 1
    jnz odd
even:
    inc dl
    loop count
    jmp finish
odd:
    inc dh
    loop count
    jmp finish

finish:
    PRINTF32 `%s\x0`, odds
    xor ebx, ebx
    mov bl, dh
    PRINTF32 `%d\n\x0`, ebx
    
    xor ebx, ebx
    PRINTF32 `%s\x0`, evens  
    mov bl, dl
    PRINTF32 `%d\n\x0`, ebx

    leave
    ret