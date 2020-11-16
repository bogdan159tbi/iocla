%include "io.mac"

section .data
    s1 db "Ana are mere",10 , 0
    s2 db "mere",10,0
section .text
    global main
    extern printf

main:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    ;mov     esi, [ebp + 12]     ; haystack
    ;mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

    ;; TO DO: Implement my_strstr
    mov ecx, 1
    mov esi, s1
    mov ebx, s2
loop:
    cmp ecx, 12
    je out
    mov edx, 1
    ;mov eax, [esi + ecx - 1]
    ;mov edx, [ebp+24]
inner:
    ;add ecx, edx
    mov eax, [esi + ecx -1]
    sub ecx, edx
    cmp eax, [ebx + edx - 1]
    jne notFound
    cmp edx, 4
    je innerDone
    inc edx
    jmp inner
notFound:
    inc ecx 
    jmp loop
innerDone:
    ;inc ecx
    PRINTF32 `%d este\n\x0`, ecx
    ;jmp  loop

gasit:
    PRINTF32 `dada\n\x0`
    ;; DO NOT MODIFY
out:
    popa
    leave
    ret
    ;; DO NOT MODIFY
