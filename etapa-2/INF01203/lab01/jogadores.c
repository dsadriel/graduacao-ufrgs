#include "jogadores.h"

// Atribui os dados ao jogador informado
void atribui_dados(Jogador* j, char nome[50], int idade, int num_gols,
                   int num_faltas, int num_passes_errados,
                   int num_passes_corretos) {
    strcpy(j->nome, nome);
    j->idade = idade;
    j->num_gols = num_gols;
    j->num_faltas = num_faltas;
    j->num_passes_errados = num_passes_errados;
    j->num_passes_corretos = num_passes_corretos;
}

// Informa se um jogador é bom, retorna TRUE se o jogador tiver ao menos 2 vezes
// mais passes corretos do que errados e o número de faltas for menor que o
// número de gols
bool eh_bom(Jogador j) {
    return (j.num_passes_corretos > 2 * j.num_passes_errados) &&
           (j.num_faltas < j.num_gols);
}

// Imprime as estatísticas sobre o jogador
void exibe_estatistica(Jogador j) {
    printf(
        "===========================================\n"
        " Estatisticas sobre o jogador  \n"
        " NOME: %s\n"
        " IDADE: %d\n"
        " NUMERO GOLS: %d\n"
        " NUMERO FALTAS: %d\n"
        " PASSES (CORRETOS/ERRADOS): %d/%d\n"
        " \nPodemos afirmar que o jogador %s bom.\n"
        "===========================================\n",
        j.nome, j.idade, j.num_gols, j.num_faltas, j.num_passes_corretos,
        j.num_passes_errados, eh_bom(j) ? "EH" : "NAO EH");
}
