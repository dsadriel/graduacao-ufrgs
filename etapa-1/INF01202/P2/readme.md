# Prova 2 - Algoritmos e Programação 2023/1

## Questão 1
_0,60pts - Alternativa correta: 5_

**Considere o programa abaixo, cujo objetivo é identificar o menor elemento do vetor v e exibir este valor na tela. O programa possui uma lacuna.**

```c
#include <stdio.h>
#define N 5

int menor(int vet[], int n)
{
    int i, val = vet[0];
    for (i = 0; i < n; i++) {
       if (vet[i] < val) {
         val = vet[i];
       }
    }
    return val;
}

int main()
{
    int val;
    int v[5] = { 12, 24, 6, 18, 36 };
    //<lacuna>
    printf("%d\n", val);
    return 0;
}
```
1. val = menor(v[N],N);
1. val = menor(v[],N);
1. val = menor(v[i],N);
1. menor(v[],N);
1. val = menor(v,N);


## Questão 2
_0,60pts - Alternativa correta: 5_

**Em C, qual das seguintes opções descreve corretamente a diferença entre parâmetros por valor (passagem por valor) e parâmetros por referência (passagem por referência) em uma função?**

1. Parâmetros por valor recebem o endereço de memória da variável original, permitindo alterações diretas, enquanto parâmetros por referência recebem uma cópia do valor.
1. Parâmetros por referência não permitem que uma função possa utilizar o comando return, enquanto passagem de parâmetros por valor permitem que o comando return seja utilizado.
1. Parâmetros por valor só aceitam tipos de dados primitivos como parâmetros, enquanto parâmetros por referência só aceitam tipos de dados estruturados.
1. Ambos os métodos permitem que a função altere diretamente o valor da variável original.
1. Parâmetros por referência recebem o endereço de memória da variável original, permitindo alterações diretas, enquanto parâmetros por valor recebem uma cópia do valor.


## Questão 3
_0,60pts - Alternativa correta: 3_

**Qual é a diferença entre uma estrutura e um arranjo (array) em C?**

1. Structs armazenam apenas valores de tipo homogêneos, enquanto arrays armazenam qualquer tipo de dado.
1. Structs são usados para operações matemáticas, enquanto arrays são usados para armazenamento de dados.
1. Structs armazenam diferentes tipos de dados sob um nome, enquanto arrays armazenam múltiplos elementos do mesmo tipo de dados.
1. Structs são criados usando a palavra-chave typedef, enquanto arrays são criados usando a palavra-chave array.
1. Structs não podem armazenar múltiplos valores, enquanto arrays podem.


## Questão 4
_0,60pts - Alternativa correta: 3_

**Considere o seguinte programa:**
```c
#include <stdio.h>

void funA(int *x, int y)
{
    y = *x * 3;
    *x = y;
}

void funB(int x, int *y)
{
    int aux = x;
    x = *y;
    *y = aux;
}

void funC(int *x, int *y)
{
    *x = *y;
    *y = *x * 2;
}

int main()
{
    int a = 10, b = 20;
    int *ptra = &a, *ptrb = &b;

    funA(ptra, b);
    printf("%d %d\n", a, b);
    funB(a, &b);
    printf("%d %d\n", a, b);
    funC(ptra, ptrb);
    printf("%d %d\n", a, b);
    return 0;
}
```
Indique a opção correta:

1. O programa não compila
1. O programa exibe na tela:<br>
    30 30<br>
    30 30<br>
    30 30<br>
1. O programa exibe na tela<br>
    30 20<br>
    30 30<br>
    30 60<br>
1. O programa exibe na tela:<br>
    30 20<br>
    20 30<br>
    30 60<br>
1. O programa exibe na tela:<br>
    30 20<br>
    30 20<br>
    30 60<br>  


## Questão 5
_0,60pts - Resposta correta: 22_

**Qual é a saída do programa abaixo?**

```c

#include <stdio.h>
#define N 5
int func(int vet[], int n)
{
    int val = 0;
    if (vet[n - 1] % 2 == 0) {
    val = vet[n - 1];
    }
    if (n == 1) {
    return val;
    } else {
    return val + func(vet, n - 1);
    }
}

int main()
{
    int vetor[N] = { 10, 3, 5, 1, 12 };
    printf("%d\n", func(vetor, N));

    return 0;
}
```

## Questão 6
_3,50pts_
Você deseja ir ao cinema assistir Barbie e Oppenheimer, mas para tal fará um levantamento das sessões previstas para o dia de hoje antes de decidir em quais sessões comparecer. Serão analisados N_CINEMAS cinemas, cada um com 2 sessões em sequência:
1. O programa deverá criar estruturas para armazenar Sessão (contendo a hora, o idioma e o preço) e Cinema (contendo o nome e as duas sessões). Tudo deve ficar armazenado em um arranjo de cinemas.
1. Crie uma função para ler as informações de cada cinema e suas duas sessões.
1. Crie uma função para analisar todas as informações (recebendo um arranjo de cinemas) que deverá encontrar os cinemas cujo par de sessões tenha o menor valor total e exibir o nome dos cinemas na tela.

| Cinema                            | Hora | Idioma | Preço | Hora | Idioma | Preço |
| --------------------------------- | ---- | ------ | ----- | ---- | ------ | ----- |
|                                   | Sessão Barbie ||     | Sessão Oppenheimer   |||
| Cinemark Barra Sul                | 17   | L      | 26    | 21   | L      | 30    |
| GNC Cinemas Iguatemi              | 17   | D      | 26    | 22   | D      | 28    |
| Espaço de Cinema Bourbon Country  | 20   | L      | 30    | 23   | L      | 33    |
| Cinemark Bourbon Ipiranga         | 18   | D      | 28    | 21   | L      | 26    |
| GNC Cinemas Praia de Belas        | 17   | D      | 30    | 22   | L      | 26    |


[Código enviado](./q6.c)<br>
[Código corrigido após a prova](./q6_corrigida.c)

## Questão 7
_3,50pts_

Você deve construir um programa para gerar um relatório do resultado de uma eleição. Considere que há um arquivo binário chamado resultado.bin em que cada registro é uma struct que representa um candidato diferente, contendo nome (com máximo de **MAX** caracteres), total de votos (um número inteiro) e partido (um char, que pode ser ‘A’, ‘B’ ou ‘C’). O programa deve ler todos os registros deste arquivo e processá-los. Ao fim, o programa deve criar um arquivo textual chamado relatorio.txt, com as seguintes informações:

1. Total de votos (considerando todos os candidatos)
1. Maior número de votos feito por um candidato
1. Total de votos de cada partido

Abaixo, apresenta-se um exemplo de um possível arquivo texto gerado:
```plaintext
Total de votos: 555000
Maior número de votos: 88000
Total de votos do partido A: 220000
Total de votos do partido B: 155000
Total de votos do partido C: 180000
```

[Código enviado](./q7.c)<br>
[Código corrigido após a prova](./q7_corrigida.c)