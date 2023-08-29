/*

5ª questão - Arranjos bidimensionais e funções
3
Uma matriz com nl linhas e nc colunas é dita “esparsa” se o número de zeros
presente na matriz é maior ou igual a (nl*nc)/2. Escreva uma função de nome
esparsa que recebe uma matriz de inteiros, os valores de nl e nc e retorna
verdadeiro se a matriz for esparsa, ou falso em caso contrário. Escreva também
um programa que lê os valores de nl e nc, lê uma matriz qualquer de nl X nc, e
apresenta na tela se a matriz é esparsa ou não. Assuma que a ordem máxima da
matriz é 10 (ou seja, o número de linhas e colunas). Abaixo um exemplo de uma
matriz esparsa 3x3.
1 | 6 | 0
0 | 0 | 0
4 | 0 | 5
*/

#include <stdio.h>

#define ORDEM_MAX 10

int esparsa(int matriz[][ORDEM_MAX], int nl, int nc) {
    int i, j, qtdZeros = 0;

    // Percorre a matriz contando a quantidade de zeros
    for (i = 0; i < nl; i++)
        for (j = 0; j < nc; j++)
            if (matriz[i][j] == 0) qtdZeros++;

    // Retorna verdadeiro se a quantidade de zeros for maior ou igual a
    // (nl*nc)/2
    return qtdZeros >= (nl * nc) / 2;
}

int main() {
    int matriz[3][3] = {{1, 6, 0}, {0, 0, 0}, {4, 0, 5}};

    // Executa um caso de teste
    printf("%d\n", esparsa(matriz, 3, 3));

    return 0;
}
