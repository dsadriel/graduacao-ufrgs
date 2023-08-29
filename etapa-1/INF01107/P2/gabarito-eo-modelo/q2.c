/*
2ª questão – Funções, Ponteiros e Passagem de Parâmetros
Considere o programa abaixo escrito em Linguagem C:

Qual a saída em tela desse programa?
*/

#include <stdio.h>
void funA(int x, int y) {
    x = 78;
    y = 15;
    x = y;
}
void funB(int *x, int y) {
    *x = 123;
    y = 415;
    *x = y;
}
void funC(int x, int *y) { x = *y; }
void funD(int *x, int *y) {
    *x = 10;
    *y = 17;
    x = y;
}
int main() {
    int a = 112, b = 13;
    int *ptra = &a, *ptrb = &b;
    funA(a, b);
    printf("%d %d\n", a, b);
    funB(ptra, b);
    printf("%d %d\n", a, b);
    funC(a, ptrb);
    printf("%d %d\n", a, b);
    funD(ptra, ptrb);
    printf("%d %d\n", a, b);
    return 0;
}

/*
== SAIDA ==
112 13
415 13
415 13
10 17


** Process exited - Return Code: 0 **

*/