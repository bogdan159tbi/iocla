%include "io.mac"

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack string
    mov     ebx, [ebp + 16]     ; needle substring
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

    ;; TO DO: Implement my_strstr
   
    mov edi, 38

out:    
    ;PRINTF32 `%s\n\x0`, edi
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

    popa
    leave 
    ret

    mov ecx, 1
loop:
    inc ecx 
    cmp ecx, [ebp+20]
    je out
    mov edx, 1
    ;mov eax, [esi + ecx - 1]
    ;mov edx, [ebp+24]
inner:
    cmp edx, [ebp+24]
    je gasit
    add ecx, edx
    mov eax, [esi + ecx -2]
    sub ecx, edx
    ;PRINTF32 `check %c %c %d %d\n\x0`, eax,[ebx + edx - 1],edx,[ebp+24]
    cmp al, [ebx + edx - 1]
    jne notFound
    ;PRINTF32 `not found trece\n\x0`
    inc edx
    jmp inner
notFound:
    ;PRINTF32 `nu s egale %d %d\n\x0`, eax,[ebx + edx - 1]
    jmp loop

gasit:
    sub ecx, 1;dupa cel crescusem cand cauta iar
    mov edi, ecx
    PRINTF32 `%d %d da\n\x0`, edi, ecx