%include "io.mac"

section .data
   ;upper db  'A', 'B', 'C'
    plain db "We are watching", 10 , 0
    key db 5
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
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the caesar cipher
    mov ecx, 15
    mov edx, plain
    ;get modulo of a no > 26 in order to get rid of unncecessarry cicles

    xor eax, eax
    mov al, 100
    mov bl, 26
    div bl
    xor ebx, ebx
    mov bl, ah
    xor eax, eax
    mov al, bl
    
    PRINTF32 `%d\n\x0`, byte[key]
    jmp out
caesar:
    cmp ecx, 0
    jz out
    mov al, byte[plain + ecx - 1]
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
    add al, 5
    cmp al, 90
    jle go
    sub al, 91
    mov bl, 'A'
    add bl, al
    mov al, bl
    mov byte[edx + ecx -1], al
    dec ecx
    jmp caesar
lower:
    add al, 5
    cmp al, 122
    jle go 
    sub al, 123
    mov bl, 'a'
    add bl, al
    mov al, bl
    mov byte[edx + ecx -1], al
    dec ecx 
    jmp caesar
go:
    mov byte[edx + ecx - 1 ], al
    dec ecx
    jmp caesar


words:
    mov al, byte[plain + ecx - 1]
    ;func to modify upper letter  
    cmp al, 0x20 ;spatiu
    jle space

    ;cmp al, 0x2E ;punct
    ;je dot

    cmp al, 0x41
    jl  words ;jump to next charact if < A
    cmp al, 0x5a ;compare with Z
    jl upper
    cmp al, 0x61
    jl  words ;jump to next charact if < a
    cmp al, 0x7A
    loop  words ;jump to next character if > z
    ;jmp lower ;found carac >a <z
    ; func to modify lower letter
    add al, 5
    cmp al, 122
    jne increase 
    sub al, 122
    mov bl, 'a'
    add bl, al
    mov al, bl
    mov byte[edx + ecx -1], al
    loop words
increase:
    mov byte[edx + ecx -1], al
    loop words
upper:
    add al, 5
    cmp al, 90
    jne increaseUpper
    sub al, 90
    mov bl, 'A'
    add bl, al
    mov al, bl
    mov byte[edx + ecx -1], al
increaseUpper:
    mov byte[edx + ecx -1], al
    loop words   
space:
    loop words



    
out:
    PRINTF32 `%s\x0` ,edx


    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY