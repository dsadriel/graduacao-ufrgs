/*

4ª questão - Recursividade
Escreva uma função recursiva que tem como parâmetros apenas um string de
qualquer tamanho e um caractere. A função deve retornar o numero de vezes que o
caractere aparece no string. Abaixo exemplo de execução: Entre com uma string:
aabbccddaa Entre com um caracter: a O caracter a aparece 4 vezes na string
aabbccddaa

*/

#include <stdio.h>
#include <string.h>
#define MAX_STR 100

int contaCaracteresV1(char[], char);
int contaCaracteresRec(char[], char, int, int);
int contaCaracteresV2(char[], char);

int main() {
    // Testes
    printf("V1: %d\n", contaCaracteresV1("aabbccddaa", 'a'));
    printf("V2: %d\n", contaCaracteresV2("aabbccddaa", 'a'));

    return 0;
}

// Versão 1
int contaCaracteresV1(char string[MAX_STR], char c) {
    return contaCaracteresRec(string, c, 0, strlen(string));
}

int contaCaracteresRec(char string[MAX_STR], char c, int inicio, int tamanho) {
    int qtdeCaracteres = 0;

    if (inicio < tamanho) {
        // Se o caractere atual for igual ao caractere procurado
        if (string[inicio] == c) qtdeCaracteres++;

        // Chamada recursiva incrementando o inicio
        qtdeCaracteres += contaCaracteresRec(string, c, inicio + 1, tamanho);
    }

    return qtdeCaracteres;
    // Caso base implicito
}

// Versão 2
int contaCaracteresV2(char string[MAX_STR], char c) {
    int qtdeCaracteres = 0;

    // Se o primeiro caractere da string não for um caractere nulo
    if (string[0] != '\0') {
        // Se o primeiro caractere da string for igual ao caractere procurado
        if (string[0] == c) qtdeCaracteres++;

        // Chamada recursiva incrementando o ponteiro para o próximo caractere
        qtdeCaracteres += contaCaracteresV2(string + 1, c);
    }
    // Caso base implicito

    return qtdeCaracteres;
}