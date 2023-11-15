// Lab LSE
// Adriel de Souza

struct numero {
  int num;
  struct numero* prox;
};

typedef struct numero tipoNumero;

tipoNumero* criar_lista();
tipoNumero* inserir(tipoNumero* lista, int num);
tipoNumero* destruir(tipoNumero* lista);
int tamanho(tipoNumero* lista);
void exibir(tipoNumero* lista);

//tipoNumero* remover(tipoNumero* lista, ??); // não implementado
