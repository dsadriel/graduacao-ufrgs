# Prova 1 - Algoritmos e Programação 2023/1

## Questão 1
_0,60pts - Alternativa correta: 3_

**Qual a diferença principal entre os comandos “do-while” e “while”?**

1. O comando “do-while” deve ser utilizado quando já se sabe de antemão quantas iterações serão executadas, enquanto o comando “while” deve ser usado nos casos onde não se sabe previamente o número de iterações.
1. O bloco de repetição do comando “do-while” somente pode ser usado com arranjos, enquanto o bloco de repetição do comando “while” é de uso geral.
1. O bloco de repetição do comando “do-while” será executado ao menos uma vez, enquanto que o bloco de repetição do comando “while” pode não ser executado nenhuma vez.
1. Não há nenhuma diferença, podemos trocar os comandos “do-while” e “while” um pelo outro sem alteração do resultado da execução do código.
1. O comando “do-while” permite múltiplas condições para encerramento do laço, enquanto o comando “while” permite apenas uma condição.

## Questão 2
_0,60pts - Alternativa correta: 4_

**Ao estudar programação condicional, Diógenes se deparou com os três problemas a serem resolvidos abaixo:**
I. Emitir uma mensagem de acordo com um número digitado entre 1, 2 ou 3. <br>
II. Exibir a mensagem "Válido" caso um número real pertence ao intervalo [0, 10], "Inválido" caso contrário. <br>
III. Imprimir o conceito (A,B,C ou D) do aluno a partir da nota (real) fornecida. <br>
A partir dos problemas acima, e considerando programação em linguagem C, assinale a alternativa que corretamente os associa às respectivas estruturas condicionais indicadas:
1. O problema III deve ser resolvido preferencialmente com o comando switch/case, apesar de também poder ser resolvido com variações do comando if/else.
1. O problema II pode ser resolvido tanto com variações do comando if/else quanto com o comando switch/case, apesar de ser mais indicada a utilização do comandos switch/case.
1. Tanto o problema I quanto o problema III podem ser resolvidos com variações do comando if/else ou o comando switch/case. Entretanto, por questões de legibilidade, deve ser priorizado o uso do comando switch/case.
1. Tanto o problema II quanto o problema III podem ser resolvidos apenas com variações do comando if/else.
1. O problema I somente pode ser resolvido com o comando switch/case.

## Questão 3
_0,60pts - Alternativa correta: 3_

**O que faz o trecho de código abaixo?**
```c
int numeros[3] = {1,2,3};
printf(“%d”, numeros[3]);
```
1. Imprime 1.
1. Imprime 2.
1. Resulta em um comportamento indeterminado ou imprime um valor indeterminado.
1. Como trata-se de um erro sintático, o código não compila.
1. Imprime 3.


## Questão 4
_0,60pts - Alternativa correta: 5_

**Considere o seguinte trecho abaixo sobre programação sequencial, propositalmente deixado com as lacunas (1), (2), (3), (4) e (5):**

A programação sequencial envolve diversos conceitos básicos fundamentais para as demais etapas de programação. Na linguagem de programação C, podemos citar os comandos (1) e (2), responsáveis pela entrada e saída de dados, respectivamente. Outro pontoimportante é o conceito de (3), locais identificados onde dados são armazenados pelo comando de (4) e recuperados durante a execução de um programa. Além disso, uma boa prática é a utilização de (5)para substituir valores numéricos literais no código quase repetem com a mesma semântica.

1. scanf, printf, identificador, cópia, comentários.
1. printf, scanf, identificador, cópia, comentários.
1. printf, scanf, variável, atribuição, constantes.
1. printf, scanf, identificador, cópia, comentários.
1. scanf, printf, variável, atribuição, constantes.


## Questão 5
_0,60pts - Alternativa correta: 5_

**Considerando a tarefa de realizar a leitura adequada dos dados para preencher o vetor no seguinte programa:**

```c
#include <stdio.h>
#define N_VAL 10
int main(){
    int valores[N_VAL] = {0}, i;
    <preenchimento do vetor valores>
    return 0;
}
```
Considerando as boas práticas discutidas em aula, indique a opção que representa o trecho de código mais adequado para completareste programa:


1. 
```c
for(i=0;i<=N_VAL;i++){
    printf(“Informe o valor:\n”);
    scanf(“%d”,&valores[i]);
} 
```
2. 
```c
for(i=0;i<=N_VAL;i++){
    printf(“Informe o valor:\n”);
    scanf(“%d”,&valores);
}
```

3. 
```c
i=0;
while(i<10){
    printf(“Informe o valor:\n”);
    scanf(“%d”,&valores);
}
```

4. 
```c
i=0;
while(i<10){
    printf(“Informe o valor:\n”);
    scanf(“%d”,&valores[i]);
    i++;
}
```

5. 
```c
for(i=0;i<N_VAL;i++){
    printf(“Informe o valor:\n”);
    scanf(“%d”,&valores[i]);
}
```
## Questão 6
_3,50/3,50pts_

Uma empresa possui **N_FIL** filiais. Cada funcionário da empresa é identificado por um código numérico inteiro. A empresa deseja alocar chefes para todas as filiais. Você deve fazer um programa que controle a alocação dos chefes para as filiais. A alocação é representada por um vetor, onde cada posição **p** representa uma filial e o valor nesta posição **p** representa o código do funcionário que chefia essa filial. <br>
O programa deve continuamente requisitar que o usuário informe o código do chefe para cada filial, até que todas as filiais tenham chefes alocados. O programa não deve permitir que um mesmo chefe seja alocado para mais de uma filial, informando quando o usuário fornecer o código de um chefe que já foi alocado para outra filial. Considere 4 filiais por conveniência. A seguir temos um exemplo de interação possível: <br>
```plaintext
Informe o código do chefe da filial 1: 123
Informe o código do chefe da filial 2: 245
Informe o código do chefe da filial 3: 123
Chefe já alocado, informe outro código.
Informe o código do chefe da filial 3: 321
Informe o código do chefe da filial 4: 523
`````
[Código enviado](./q6.c)<br>
[Código corrigido após a prova](./q6_corrigida.c)

## Questão 7
_3,30/3,50pts_

Durante a apuração dos desfiles de carnaval, leia o nome da escola de samba e as notas dadas por 4 jurados para cada escola de samba do grupo especial. Assuma que são **N** escolas (considere N como 4 por conveniência). Calcule e exiba a nota final no quesito analisado, descartando a nota mais baixa que a escola recebeu dos jurados, e fazendo uma média das demais notas. Informe ao final os nome das escolas e suas médias. Abaixo, segue um exemplo de dados de entrada e um exemplo da saída. As notas em ~~vermelho~~ negrito representam as notas mais baixas que foram eliminadas.

| Nome | Notas do jurado1 | Notas do jurado2 | Notas do jurado3 | Notas do jurado4 |
| --- | --- | --- | --- | --- |
| Unidos do microchip | 10 | 9.5 | 8.5 | **8** |
| Saudosos de Alan Turing | 10 | 10 | 9.5 | **9.5** |
| Acadêmicos do INF | **9.5** | 9.5 | 10 | 10 |
| Mocidade da Computação | 9.5 | 8.6 |  **8.5** | 9.5 |

```plaintext
Notas:
Unidos do microchip: 9.33
Saudosos de Alan Turing: 9.83
Acadêmicos do INF: 9.83
Mocidade da Computação: 9.20
```

[Código enviado](./q7.c)<br>
[Código corrigido após a prova](./q7_corrigida.c)