/*
P1 - Algoritmos e Programação
Adriel de Souza
Turma A

Questão 07

*/

#include <stdio.h>
#define N_ESCOLAS 4
#define N_JURADOS 4
#define MAX_NOME 50


int main(){
	char nomes[N_ESCOLAS][MAX_NOME];
	float notas[N_ESCOLAS][N_JURADOS];
	float i_nota_mb[N_ESCOLAS] = {0};
	float i_mais_baixa, soma, media;
	int e, n;
	
	
	for(e = 0; e < N_ESCOLAS; e++){
		
		//Obtem o noma da escola
		printf("Informe o nome da primeira escola: ");
		
		gets(nomes[e]);
		//Função insegura porém mais simples e pratica! Alternativamente pode-se usar scanf e fgets
		
		//Itera por todos jurados e obtém a nota
		for(n = 0;  n < N_JURADOS; n++){
			
			//Le a nota
			printf("\tInforme a nota dada pelo jurado %d: ", n+1);
			scanf("%f", &notas[e][n]);
	
			i_mais_baixa = nota_mb[e]; //Índice da menor nota da escola
			
			//Se a nota do jurador for menor que a mais baixa da escola OU se for a primeira nota informada
			if(notas[e][n] < notas[e][i_mais_baixa] || n == 0)
				nota_mb[e] = n; //O índice da nota mais baixa é atualizado
			
		}
		
		//Separador, por fins estéticos
		printf('\n');
		
	}
	
	//Inicia a saída de dados da notas
	printf("\n\nNotas: ");
	
	//Itera pelas escolas
	for(e = 0; e < N_ESCOLAS; e++){
		
		soma = 0.0;
		
		//Itera pelas notas
		for(n = 0;  n < N_JURADOS; n++){
			//Se o índice for DIFERENTE do índice da nota mais baixa da escola 
			if(n !=  i_nota_mb[e])
				soma += notas[e][n];
		}
		
		//Cacula a media, desconsiderando 1 jurado
		media = soma / (N_JURADOS - 1);
		
		//Escreve na tela
		printf("\t%s: %.2f", nomes[e], media);
	}
	
	return 0;
}