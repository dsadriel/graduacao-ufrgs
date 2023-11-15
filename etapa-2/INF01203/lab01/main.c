#include <stdio.h>

#include "jogadores.h"

void main() {
    Jogador clarissa, marlon;

    // Atribui dados ao jogadores
    atribui_dados(&clarissa, "Clarissa", 32, 12, 0, 0, 15);
    atribui_dados(&marlon, "Marlon", 27, 7, 3, 16, 15);

    // Exibe as estatísticas dos jogadores
    exibe_estatistica(clarissa);
    exibe_estatistica(marlon);
}
