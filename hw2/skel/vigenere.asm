%include "io.mac"

section .data
    plain db "Donald Trump",10, 0
    key db "BIDEN",10 , 0
section .text
    global main
    extern printf

main:
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
    mov edi, [key]
modifica:
    cmp ebx, 0
    jz out
    sub byte[edi + ebx - 1] , 0x41
    dec ebx
    jmp modifica

out:
    PRINTF32 `%s\n\x0`, key

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY