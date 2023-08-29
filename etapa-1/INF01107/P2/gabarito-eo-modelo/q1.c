/*

1ª questão – Programação em geral
Dados um conjunto de retângulos no plano, queremos saber quantos deles se
interseccionam entre si. Na figura ilustrativa abaixo temos 3 retângulos A, B e
C definidos pelas coordenadas dos cantos inferior esquerdo (xl,yl) e canto
superior direito (xr,yr). Nesse exemplo A e B se interseccionam. Você deverá
fazer um programa que armazena dados referentes à retângulos – as coordenadas
dos cantos inferior esquerdo (xl,yl) e superior direito (xr,yr) - num vetor de
estruturas do tipo RECT. typedef struct{ float xl,yl,xr,yr; }RECT; O número
mínimo de retângulos a serem lidos é 2 e o máximo 10. Você deve no início do
programa ler a quantidade de retângulos que o programa irá processar (faça
consistência). Após a leitura das informações dos retângulos, você deverá
imprimir a mensagem de quantos pares desses retângulos lidos se interseccionam
entre si. Para isso você deve implementar uma função que recebe 2 retângulos e
retorna Verdadeiro caso os 2 se interseccionam e Falso caso contrário. DICA:
dois retângulos A e B NÃO se interseccionam se uma das condições abaixo for
verdadeira (ilustradas na figura):
1. Quando a aresta esquerda de A está à direita de B;
2. Quando a aresta superior de A está abaixo de B;
3. Quando a aresta inferior de A está acima de B;
4. Quando a aresta direita de A está à esquerda de B.

*/

#include <stdio.h>
#include <stdlib.h>

#define MAX_RECT 10  // Número máximo de retângulos
#define MIN_RECT 2   // Número mínimo de retângulos

typedef struct {
    float xl, yl, xr, yr;
} RECT;

int lerQtdeRetangulos();
int retangulosInterseccionam(RECT, RECT);

int main() {
    int qtdeRetangulos, i, j, qtdeInterseccoes = 0;
    RECT retangulos[MAX_RECT];

    // Lê a quantidade de retângulos
    qtdeRetangulos = lerQtdeRetangulos();

    // Lê os dados dos retângulos
    for (i = 0; i < qtdeRetangulos; i++) {
        printf("Informe os dados do retângulo %d\n", i + 1);
        printf("\tXL (x do ponto inferior esquerdo): ");
        scanf("%f", &retangulos[i].xl);
        printf("\tYL (x do ponto inferior esquerdo): ");
        scanf("%f", &retangulos[i].yl);
        printf("\tXR (y do ponto superior direito): ");
        scanf("%f", &retangulos[i].xr);
        printf("\tYR (y do ponto superior direito): ");
        scanf("%f", &retangulos[i].yr);
    }

    // Verifica quantos retângulos se interseccionam
    for (i = 0; i < qtdeRetangulos; i++)
        for (j = i; j < qtdeRetangulos; j++)
            if (retangulosInterseccionam(retangulos[i], retangulos[j]))
                qtdeInterseccoes++;

    // Imprime a quantidade de retângulos que se interseccionam

    printf("Quantidade de retângulos que se interseccionam: %d\n",
           qtdeInterseccoes);

    return 0;
}

int lerQtdeRetangulos() {
    int qtdeRetangulos;

    // Lê a quantidade de retângulos e faz consistência
    do {
        printf("Informe a quantidade de retângulos (entre %d e %d): ", MIN_RECT,
               MAX_RECT);
        scanf("%d", &qtdeRetangulos);
    } while (qtdeRetangulos < MIN_RECT || qtdeRetangulos > MAX_RECT);
    
    
    return qtdeRetangulos;
}

int retangulosInterseccionam(RECT r1, RECT r2) {
    int interseccionam = 0;

    //1. Quando a aresta esquerda de A está à direita de B;
    int caso1 = r1.xl > r2.xr;
    //2. Quando a aresta superior de A está abaixo de B;
    int caso2 = r1.yr < r2.yl;
    //3. Quando a aresta inferior de A está acima de B;
    int caso3 = r1.yl > r2.yr;
    //4. Quando a aresta direita de A está à esquerda de B.
    int caso4 = r1.xr < r2.xl;

    // Se algum dos casos for verdadeiro, os retângulos não se interseccionam    
    if (caso1 || caso2 || caso3 || caso4)
        interseccionam = 0;
    else // Caso contrário, os retângulos se interseccionam
        interseccionam = 1;

    return interseccionam;
}