#include "listaNum.h"

#include <stdio.h>
#include <stdlib.h>

// Cria uma nova lista
tipoNumero* criar_lista() { return NULL; };

// Obtem o tamanho da lista
int tamanho(tipoNumero* lista) {
    if (lista == NULL) return 0;

    int tamanhoLista = 1;
    tipoNumero* nodoAtual = lista;

    while (nodoAtual->prox != NULL) {  // Percore a lista até o final
        nodoAtual = nodoAtual->prox;
        tamanhoLista++;
    }

    return tamanhoLista;
}

/*
• Número = 0 -> insere no meio da lista
• Número par -> insere no início da lista
• Número ímpar -> insere no fim da lista
*/
// Insire um novo elemento na lista
tipoNumero* inserir(tipoNumero* lista, int num) {
    if (num < 0)  // se for menor que zero devolve a lista atual sem modificar
        return lista;

    // Cria um novo nodo para o dado
    tipoNumero* novoNodo = (tipoNumero*)malloc(sizeof(tipoNumero));
    novoNodo->num = num;
    novoNodo->prox = NULL;

    // Se a lista for vazia, devolve somente o novo nodo criado
    if (lista == NULL) return novoNodo;

    tipoNumero* nodoAtual = lista;

    if (num % 2 == 0 && num != 0) {  // se for par e != 0
        novoNodo->prox = nodoAtual;  // conecta o novo nodo no inico da lista e
        return novoNodo;             // retorna o novo nodo
    }

    if (num % 2 == 1) {                  // se for impar
        while (nodoAtual->prox != NULL)  // percore a lista até o final
            nodoAtual = nodoAtual->prox;

        nodoAtual->prox = novoNodo;  // insere o novo nodo no final da lista
        return lista;
    }

    /* 
    // solução com o uso do tamanho da lista, porém esse código é ineficiente
    // e pode ocasionar erros se por exemplo a lista for composta apenas
    // por números impares ou pares

    if (num == 0) { // se o número for zero
        int meioLista = tamanho(lista) / 2 - 1;

        // navega até a metade da lista
        for (int i = 0; i < meioLista; i++) nodoAtual = nodoAtual->prox;

        // insere o novo nodo
        novoNodo->prox = nodoAtual->prox;
        nodoAtual->prox = novoNodo;

        return lista;
    }
    */

   // se o número for zero
    if (num == 0) {
        // se o primeiro número é impar insere o zero no inicio
        if(nodoAtual->num % 2 == 1){
            novoNodo->prox = nodoAtual;
            return novoNodo; 
        }

        // navega até o nodo atencessor ao primero impar
        while (nodoAtual->prox != NULL && nodoAtual->prox->num % 2 == 0 &&
               nodoAtual->prox->num != 0)
            nodoAtual = nodoAtual->prox;

        // insiere o novo nodo antes do primeiro impar
        novoNodo->prox = nodoAtual->prox;
        nodoAtual->prox = novoNodo;
    }
}

// Destroi uma lista
tipoNumero* destruir(tipoNumero* lista) {
    tipoNumero* nodoAtual = lista;
    tipoNumero* aux;

    while (nodoAtual != NULL) {  // pecorre a lista e desaloca os dados
        aux = nodoAtual;
        nodoAtual = nodoAtual->prox;
        free(aux);
    }
    free(nodoAtual);

    return NULL;
}

// Dada uma lista de números imprime o conteúdo
void exibir(tipoNumero* lista) {
    printf("\nExibindo o conteudo da lista:\n");

    if (lista == NULL) {
        printf("\tLista vazia\n");
        return;
    }

    tipoNumero* nodoAtual = lista;

    while (nodoAtual != NULL) {
        printf("\tValor %d\n", nodoAtual->num);
        nodoAtual = nodoAtual->prox;
    }
}