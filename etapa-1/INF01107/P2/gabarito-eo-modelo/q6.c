/*
6ª questão – Arquivos
O arquivo binário cadastro.bin contém os dados de pacientes de uma clínica. Para
cada paciente são armazenados numa struct os seguintes dados: nome (30
caracteres), sexo (char M ou F), altura (float), peso (float). Você NÃO sabe
quantos pacientes existem no arquivo. Escreva um programa que lê o arquivo
cadastro.bin descrito acima e grava dois arquivos texto com nomes homens.txt e
mulheres.txt. O primeiro arquivo texto armazena somente os dados dos pacientes
do sexo masculino e o segundo arquivo texto apenas dados dos pacientes do sexo
feminino. Os arquivos texto devem conter o nome e o peso (um paciente por linha)
apenas daqueles pacientes com peso MAIOR do que um peso lido do usuário no
início do programa. O programa deve apresentar também ao final na tela o peso
médio de TODOS os homens e de TODAS as mulheres.
*/

#include <stdio.h>
#include <stdlib.h>

typedef struct {
    char nome[30];
    char sexo;
    float altura;
    float peso;
} PACIENTE;

int main() {
    FILE *arquivoBinario, *arquivoHomens, *arquivoMulheres;
    PACIENTE paciente;
    float pesoMedioHomens = 0, pesoMedioMulheres = 0, pesoDeReferencia;
    int qtdHomens = 0, qtdMulheres = 0;

    arquivoBinario = fopen("cadastro.bin", "rb");
    arquivoHomens = fopen("homens.txt", "w");
    arquivoMulheres = fopen("mulheres.txt", "w");

    printf("Informe um peso de referência:\n");
    scanf("%d", &pesoDeReferencia);

    if (arquivoBinario != NULL && arquivoHomens != NULL &&
        arquivoMulheres != NULL) {
        // Enquanto não chegar no final do arquivo
        while (!feof(arquivoBinario)) {
            // Lê um registro do arquivo binário
            if (fread(&paciente, sizeof(PACIENTE), 1, arquivoBinario) == 1) {
                // Verifica o sexo do paciente
                switch (paciente.sexo) {
                    // Se for homem, incrementa o peso médio dos homens
                    case 'M':
                        pesoMedioHomens += paciente.peso;
                        qtdHomens++;
                        // Se o peso do paciente for maior que o peso de
                        // referência grava no arquivo homens.txt
                        if (paciente.peso > pesoDeReferencia)
                            fprintf(arquivoHomens, "%s %.2f\n", paciente.nome,
                                    paciente.peso);
                        break;

                    // Se for mulher, incrementa o peso médio das mulheres
                    case 'F':
                        pesoMedioMulheres += paciente.peso;
                        qtdMulheres++;
                        // Se o peso do paciente for maior que o peso de
                        // referência grava no arquivo mulheres.txt
                        if (paciente.peso > pesoDeReferencia)
                            fprintf(arquivoMulheres, "%s %.2f\n", paciente.nome,
                                    paciente.peso);
                        break;
                }
            }
        }

        pesoMedioHomens = pesoMedioHomens / (float)qtdHomens;
        pesoMedioMulheres = pesoMedioMulheres / (float)qtdMulheres;

        printf("Peso médio dos homens: %.2f\n Peso médio das mulheres: %.2f\n",
               pesoMedioHomens, pesoMedioMulheres);

    } else {
        printf("Erro ao abrir o arquivo.\n");
    }

    return 0;
}
