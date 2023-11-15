#include <stdio.h>

#include "listaNum.h"

int lerUmValor(){
    int x;
    printf("Digite um valor: ");
    scanf("%d", &x);

    return x;
}

int main() {
    tipoNumero* ptLista;

    ptLista = criar_lista(); // cria uma lista

    // lê os dados
    printf("Digite um número menor que zero para sair\n\n");
    int numero = lerUmValor();
    while(numero >= 0){
        ptLista = inserir(ptLista, numero);
        numero = lerUmValor();
    }

    // exibe a lista
    exibir(ptLista);

    // destroi e exibe a lista novamente
    printf("\tDestruindo a lista...\n");
    ptLista = destruir(ptLista);
    exibir(ptLista);


    return 0;
}
