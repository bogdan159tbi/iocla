section .data
    delim db " ", 0
    delim2 db "\n", 0  ; nu stiu sigur daca se pune asa .Trebuie adaugat si delim asta??
    format db "string total %s", 0
    onebyte db "elem %c", 0
    digit db "digit %d",10 ,0
section .bss
    root resd 1 ;root va referi 1 element de 2 octeti ax?

section .text

extern check_atoi
extern print_tree_inorder
extern print_tree_preorder
extern evaluate_tree
extern printf
extern calloc
extern strtok

global create_tree
global iocla_atoi

;int iocla_atoi(char *token) => in eax tre sa fie val int ?
 ;[0-9] = [48-57]
 ;functia mea atoi ia doar string care contine doar numere fara alte caractere
iocla_atoi: 
    push ebp
    mov ebp, esp
    xor ecx, ecx ; ecx to store which character i convert
    xor eax, eax; register to get int
    push edi
    mov edi, [ebp+8] ;get string value
    mov ebx, 10
    cmp byte[edi], '-' ; verify if i have to convert to a negative value after getting the characters
    jne getPositiveValue
    inc ecx ;get over the sign
    
getPositiveValue:
    movzx edx, byte [edi+ecx]
    sub edx, '0'
    add eax, edx
    mul ebx
    xor edx, edx
    inc ecx
    cmp byte[edi+ecx], 0
    jne getPositiveValue
    ;now i have the value*10 without sign
    div ebx
    cmp byte[edi], '-'
    jne foundValue
    mov ebx, -1
    mul ebx
foundValue:
    pop edi
    leave
    ret

;getNodeData(char *input,char *dataToStore)
getNodeData:
    push ebp
    mov ebp, esp
    ;folosim ecx si edx
    mov esi, [ebp+8] ; address of string to add value (eax)
    mov edi, [ebp+12];input string

    xor ecx, ecx
    xor eax, eax

strtok:
    mov al, byte[edi + ecx]
    cmp al, byte[delim]
    jle gotValue
    mov byte [esi+ecx], al
    inc ecx
    jmp strtok
gotValue:
    mov byte[esi + ecx + 1], 0 ;add terminator to string s end
    test eax, eax ;check if our string is done 
    jz stringEnd
    mov eax, [ebp+ 12]
    inc ecx
    add eax, ecx
stringEnd:
    leave
    ret

;createNode(char *polishNotation)
createNode:
    push ebp
    mov ebp, esp

    push 1
    push 12 ; 12 = 12 octeti pt toate campurile structurii
    call calloc
    add esp, 8 

    mov ebx, eax ;eax stores the result 
    ;allocate space for char*data
    push 1
    push 50 ;nr max de elemente
    call calloc
    add esp,8

    mov dword[ebx], eax ;add value to pointer of string   

    push dword[ebp+8] ; pointer la elementul de adaugat in data operator/operand
    push eax
    call getNodeData
    add esp, 8
    mov [ebp + 8] , eax ;modify input string after getting one more element    
    
    xchg eax, ebx ; eax turns into pointer to string

    leave
    ret


checkOperator:
    push ebp
    mov ebp, esp
    
    leave
    ret
    
;preorderTraversal(Node *root,char *polishNotation)
;cum creez arborele??
preorderTraversal:
    push ebp
    mov ebp, esp

    mov esi, [ebp + 8];input string
    cmp byte[esi], 0
    je leaf
    mov edx, [ebp+12];current node
    push edx

    push dword[ebp+8]
    call createNode
    pop dword[ebp+8]

    pop edx
    mov [edx+4], eax
    mov eax, [eax] ; ????
    cmp byte[eax], '-'
    jne notNegLeft
    cmp byte[eax+1], 0
    jne rightPath
notNegLeft:
    cmp byte[eax], '0'
    jge rightPath ; daca nu e operator

    push edx
    push dword[edx+4];left son
    push dword[ebp+8]; input string
    call preorderTraversal
    pop dword[ebp+8]
    add esp,4 
    pop edx
rightPath:
    push edx
    push dword[ebp+8]
    call createNode
    pop dword[ebp+8]
    pop edx
    mov [edx+8], eax
    ;am adaug si fiu drept

    mov eax, [eax] ; ????
    cmp byte[eax], '-'
    jne notNegRight
    cmp byte[eax+1], 0;daca e numar si nu mai are fii
    jne leaf
notNegRight:
    cmp byte[eax], '0'
    jge leaf

    push edx
    push dword[edx+8]
    push dword[ebp+8]
    call preorderTraversal
    pop dword[ebp+8]
    add esp, 4

leaf:
    leave
    ret

;create_tree(char *token) => rezultatul = eax un pointer la nodul 0 al arborelui
create_tree:
    ; TODO
    enter 0, 0
    xor eax, eax ;altfel da seg fault mai tarziu in alta func
    push ebx ;gdb=> ebx are deja o instructiune pe care tre s o salvez
    mov esi, [ebp+8] ;polish notation

    push esi
    call createNode
    pop esi
    
    mov [root], eax
    push dword[root]
    push esi
    call preorderTraversal
    pop esi
    add esp, 4
    
    mov eax, [root]
    pop ebx ; restore ebx which was used in my code 
    leave
    ret
