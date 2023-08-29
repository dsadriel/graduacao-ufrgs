/*
7ª questão – Análise de programas
Indique a saída do programa a seguir caso o usuário informe o valor 4 como
entrada.
*/

#include <stdio.h>

int funcB(int n) {
    int r;
    printf("%d\n", n);
    if (n > 0) {
        if (n % 2 == 0) {
            r = n + funcB(n - 3);
        } else {
            r = n + funcB(n + 1);
        }
    } else {
        r = 0;
    }
    return r;
}

int funcA(int n) {
    int r;
    if (n % 2 == 0) {
        r = funcB(n);
    } else {
        r = funcB(n - 1);
    }
    return r;
}

int main() {
    int n;
    printf("Informe um valor:\n");
    scanf("%d", &n);
    printf("%d\n", funcA(n));
    return 0;
}

/*
== ENTRADA ==
Informe um valor:
4

== SAIDA ==
4
1
2
-1
7


** Process exited - Return Code: 0 **
*/