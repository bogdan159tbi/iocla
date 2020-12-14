#include<stdio.h>
#include<string.h>
#include <stdlib.h>

typedef struct Node {
    char *data;
    struct Node* left;
    struct Node* right;
}tNode;

struct Node* createNode(char *data){
    tNode *node = calloc(1,sizeof(tNode));
    if(!node)
        return NULL;
    node->data = calloc(1,32);
    strcpy(node->data, data);
    return node;
}

char** elements(char *data, int *elements){
    int i = 0;
    char **op = calloc(20,sizeof(char*));
    char *tok = strtok(data," ");
    while(tok){
        op[i] = calloc(1,1);
        strcpy(op[i], tok);
        i++;        
        tok = strtok(NULL, " ");
    }
    *elements = i;
    return op;
}
void printNode(tNode *node){
    if(node)
        printf("%s \n",node->data);
    else
    {
        printf("nod null\n");
    }
    
}
//create recursive tree
int isNr(char *element){
    if(!strstr("+-/*",element))
        return 1;
    return 0 ;
}
int reachedEnd(int index, int end){
    if(index < end)
        return 0;
    return 1;
}
void createTree(tNode *root, char **elements, int *currentElem,int maxElem){
    if(reachedEnd(*currentElem, maxElem))
        return;

    tNode *son = createNode(elements[(*currentElem)++]);
    root->left = son;

    if(isNr(root->left->data)){
        if(!reachedEnd(*currentElem,maxElem)){
            son = createNode(elements[(*currentElem)++]);
            root->right = son;
            if(!isNr(son->data)){
                createTree(root->right,elements,currentElem,maxElem);
            }    
            }
    }else{
        createTree(root->left,elements,currentElem,maxElem);
        if(!reachedEnd(*currentElem ,maxElem)){
            son = createNode(elements[(*currentElem)++]);
            root->right = son;
            if(!isNr(son->data)){
                createTree(root->right,elements,currentElem,maxElem);
            }  
            }
    }


}
void printElem(char **data, int size){
    for(int i = 0 ;i < size; i++)
        printf("%s\n", data[i]);
}
void printTree(tNode *root){
    if(!root)
        return;
    printNode(root);
    printTree(root->left);
    printTree(root->right);
}
int main(int argc, char const *argv[])
{
    char *data = calloc(1,30);
    strcpy(data,"+ - 1 2 * 3 4");
    int oper = 0,curentOp = 1;

    char **elem = elements(data,&oper);
    tNode *root = createNode(elem[0]);
    createTree(root,elem, &curentOp, oper);
    printTree(root);
    //printf("%s\n",root->right->right->data);
    return 0;
}
