%include "io.mac"

section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    ;; TODO: Implement the Vigenere cipher
    mov ecx, 0
    mov ebx, 0 
modifica:
    cmp ecx, [ebp + 16]
    jg out
    mov edi, [ebp + 20]
    cmp ebx, [ebp + 24]
    je incr
    movzx edi, byte[edi + ebx]
    sub edi , 'A'
    inc ebx
    mov al, byte[esi + ecx ]
    ;PRINTF32 `%d %d da1\n\x0`, edi, eax
    cmp al, 0x20
    jne not_space
    jmp go
not_space:
    cmp al, 0x2E
    jne not_dot
    jmp go
not_dot:
    cmp al, 0x41 ;>A
    jl go
    cmp al,0x5a ; <Z
    jg lower
    add eax, edi
    cmp eax, 90
    jle go
    sub al, 90
    add al, 'A'
    mov byte[edx + ecx], al
    inc ecx
    jmp modifica
lower:
    cmp al, 0x60
    jle go
    cmp al, 0x7A
    jg go
    add eax, edi
    ;PRINTF32 `%c\n\x0`, eax
    cmp eax, 122
    jle go
    sub eax, 122
    ;PRINTF32 `dupa scadere %c\n\x0`, eax
    mov byte[edx + ecx], al
    inc ecx
    jmp modifica
go:
    ;PRINTF32 `asta %d cu %d da2\n\x0`, eax,edi
    mov byte[edx + ecx ], al
    inc ecx
    jmp modifica
incr:
    mov ebx, 0
    jmp modifica

out:
    PRINTF32 `%s\n\x0`, edx
    ;PRINTF32 `\n\x0`
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY