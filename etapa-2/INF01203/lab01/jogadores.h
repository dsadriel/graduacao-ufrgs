#include <stdbool.h>
#include <stdio.h>
#include <string.h>

// Estrutura do jogador
typedef struct {
    char nome[50];
    unsigned int idade, num_gols, num_faltas, num_passes_errados,
        num_passes_corretos;
} Jogador;

// Atribui os dados ao jogador informado
void atribui_dados(Jogador* jogador, char nome[50], int idade, int num_gols,
                   int num_faltas, int num_passes_errados,
                   int num_passes_corretos);

// Informa se um jogador é bom, retorna TRUE se o jogador tiver ao menos 2 vezes
// mais passes corretos do que errados e o número de faltas for menor que o
// número de gols
bool eh_bom(Jogador j);

// Imprime as estatísticas sobre o jogador
void exibe_estatistica(Jogador j);
