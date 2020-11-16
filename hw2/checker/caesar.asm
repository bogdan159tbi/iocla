%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the caesar cipher
    ;get modulo of a no > 26 in order to get rid of unncecessarry cicles
    xor eax, eax
    mov eax, edi
    mov bl, 26
    div bl
    xor ebx, ebx
    mov bl, ah
    xor eax, eax
    mov al, bl
    
    ;xor eax, eax
    mov edi, eax
    ;edi = edi % 26
func:
    cmp ecx, 0
    jz out
    mov al, byte[esi + ecx - 1]
    cmp al, 0x20
    jne not_space
    jmp go
not_space:
    cmp al, 0x2E
    jne not_dot
    jmp go
not_dot:
    cmp al, 0x41
    jl go
    cmp al,0x5a
    jg lower
    add eax, edi
    cmp al, 90
    jle go
    sub al, 91
    mov bl, 'A'
    add bl, al
    mov al, bl
    mov byte[edx + ecx -1], al
    dec ecx
    jmp func
lower:
    cmp al, 0x60
    jle go
    cmp al, 0x7A
    jg go
    add eax, edi
    cmp eax, 122
    jle go 
    sub eax, 123
    mov bl, 'a'
    add bl, al
    mov al, bl
    mov byte[edx + ecx -1], al
    dec ecx 
    jmp func
go:
    mov byte[edx + ecx - 1 ], al
    dec ecx
    jmp func
out:
    ;inc ecx
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY