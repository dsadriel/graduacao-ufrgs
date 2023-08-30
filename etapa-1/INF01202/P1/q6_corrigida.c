/*
P1 - Algoritmos e Programação
Adriel de Souza
Turma A

Questão 06

*/

#include <stdio.h>
#define N_FIL 4


int main(){
	int fil_chefe[N_FIL] = {0};
	int i, j, cod_chefe, ja_alocado;
	
	//Itera por todas a filiais
	for(i = 0; i < N_FIL; i++){
		
		//Executa 1 vez e repete enquanto o cod do chefe informado ja estiver alocado em outra filial
		do{
			ja_alocado = 0;
			//Le o cod do chefe
			printf("Informe o codigo do chefe da filial %d: ", i+1);
			scanf("%d", &cod_chefe);
			
			//Itera por todas as filiais, desde 0 até i-1 (ou seja, da primeira até a antes da atual)
			j = 0;
			while(j < i && ja_alocado == 0){
				//Se o codigo chefe da filial j for igual o código informado, então ele ja esta alocado
				if(fil_chefe[j] == cod_chefe)
					ja_alocado = 1;
				
				j++;
			}
			
			//Se ja estiver alocado, mostra a mensagem de erro. Alternativamente pode-se usar j == i para verificar tal condição
			if(ja_alocado == 1)
				printf("Chefe ja alocado, informe outro codigo.\n");
			else //Caso contrário, preenche o vetor com cod do chefe
				fil_chefe[j] = cod_chefe;
				
		}while(ja_alocado == 1);
		
	}
	
	return 0;
}


/*
Erros:
1. Faltou "while" na linha 44;
*/
