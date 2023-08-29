/*
3ª questão – Structs, funções e parâmetros por referência

Faça um programa que armazene dados de N pessoas. Considere N como 10. Cada
pessoa possui um nome, sexo (H ou M), peso, altura e peso ideal. O programa deve
calcular o peso ideal de cada pessoa e, por fim, dizer se a pessoa está abaixo,
acima ou exatamente com o peso ideal. O programa deve ler o nome, sexo, peso e
altura de cada pessoa. O programa deve utilizar structs para representar os
dados de cada pessoa. O programa deve utilizar uma função para calcular o peso
ideal. Esta função deve receber um ponteiro para uma struct pessoa e deve
calcular o seu peso ideal, alterando o campo peso ideal da pessoa passada por
referência. O peso ideal é calculado de forma dependente do sexo, da seguinte
forma: Homens: 72.7*altura-58 Mulheres: 62.1*altura-44.7

*/

#include <stdio.h>
#include <string.h>

#define N 10
#define MAX_NOME 100

typedef struct {
    char nome[MAX_NOME];
    char sexo;
    float peso;
    float altura;
    float pesoIdeal;
} PESSOA;

void calculaPesoIdeal(PESSOA *);

int main() {
    int i;
    PESSOA pesosas[N];
    
    // Leitura dos dados
    for (i = 0; i < N; i++) {
        // Limpa o buffer do teclado
        fflush(stdin);

        printf("Informe os dados da pessoa %d\n", i + 1);
        
        printf("\tNome: ");
        fgets(pesosas[i].nome, MAX_NOME, stdin);
        
        // Remove o \n do final da string
        pesosas[i].nome[strlen(pesosas[i].nome) - 1] = '\0';

        printf("\tSexo: ");
        scanf(" %c", &pesosas[i].sexo);

        printf("\tPeso: ");
        scanf("%f", &pesosas[i].peso);

        printf("\tAltura: ");
        scanf("%f", &pesosas[i].altura);

        calculaPesoIdeal(&pesosas[i]);
    }

    // Impressão dos dados
    for(i = 0; i < N; i++) {
        printf("%s: ", pesosas[i].nome);

        if (pesosas[i].peso < pesosas[i].pesoIdeal) {
            printf("Abaixo do peso ideal\n");
        } else if (pesosas[i].peso > pesosas[i].pesoIdeal) {
            printf("Acima do peso ideal\n");
        } else {
            printf("Peso ideal\n");
        }

    }

    return 0;
}

void calculaPesoIdeal(PESSOA *pessoa) {
    switch (pessoa->sexo) {
        case 'H':
            pessoa->pesoIdeal = 72.7 * pessoa->altura - 58;
            break;
        case 'M':
            pessoa->pesoIdeal = 62.1 * pessoa->altura - 44.7;
            break;
    }
}