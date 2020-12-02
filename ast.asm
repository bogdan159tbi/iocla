
section .data
    delim db " ", 0
    format db "input string polish notation %s", 0
    digit db "digit %d",10 ,0
section .bss
    root resd 1

section .text

extern check_atoi
extern print_tree_inorder
extern print_tree_preorder
extern evaluate_tree
extern printf

global create_tree
global iocla_atoi

printDigit:
    xor eax, eax
    mov eax, dword[ebp+8]
    
    push eax
    push format
    call printf
    add esp, 8 
    
    ret

print:
    xor eax, eax
    mov eax, dword[ebp+8]
    
    push eax
    push format
    call printf
    add esp, 8 
    
    ret
 ;[0-9] = [48-57]
 ;functia mea atoi ia doar string care contine doar numere fara alte caractere
iocla_atoi: 
    ; TODO
    push ebp
    mov ebp, esp
    pusha
    ;nu stiu daca edx  ecx si alte reg folosite tre puse pe stiva
    ;mov edx, dword[ebp+16]
    xor ecx, ecx
    xor eax, eax
    mov edx, dword[ebp+8];ecx contine stringul din argv
createNr:
    cmp byte[edx], 10;'\n'
    je out
    mov cl, byte[edx]
    cmp cl, '0' ;' 
    jl noDigit
    cmp cl,57
    jg noDigit
convertToDigit:;pun ecx pe stiva pentru a l schimba cu 10 si sa inmultesc, apoi revin
    push edx
    sub cl,48
    push ecx
    mov cl, 10
    mul ecx
    pop ecx
    add eax, ecx
    pop edx
    inc edx
    jmp createNr
noDigit:
    inc edx
    jmp createNr
out:
    leave
    ret

create_tree:
    ; TODO
    enter 0, 0
    push ebp
    mov ecx, [ebp+8]
    push ecx
    call check_atoi
    pop ecx
    pop ebp
    xor eax, eax ;altfel da seg fault mai tarziu in alta func
    
    leave
    ret
