/*
8ª questão – Análise de programas
Indique a saída do programa a seguir caso o usuário informe como entrada o
valor 8.
*/

#include <stdio.h>
void funcB(int n, int *p, char c) {
    *p = *p + n;
    if (n > 0) {
        if (c == 'a') {
            funcB(n - 2, p, 'b');
        } else if (c == 'b') {
            funcB(n + 1, p, 'a');
        }
    }
}
int funcA(int n) {
    int r = n / 2;
    funcB(r, &r, 'a');
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
8

== SAIDA ==
16


** Process exited - Return Code: 0 **
*/