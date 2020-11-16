%include "io.mac"

section .data
    plain db "Ana are mere",0
    key db "bbbbbbbbbbbb",10, 0
    cipher db ""

section .text
    global main ;in loc de main e otp
    extern printf

main: ;in loc de main e otp
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the One Time Pad cipher
    mov ecx, 12
    mov edx, 0 

while:
    xor eax, eax
    xor ebx, ebx

    mov al, byte [plain + ecx -1] 
    mov bl, byte[key + ecx - 1]

    xor al, bl
    
    mov byte[cipher + ecx - 1], al
    inc edx  
    loop while
final:
    mov ecx, 12
    mov edx, cipher
    mov byte[edx+ecx] , '\0'

    PRINTF32 `%s`, edx

    ;; DO NOT MODIFY
stop:
    popa
    leave
    ret
    ;; DO NOT MODIFY