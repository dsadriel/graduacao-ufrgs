;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lista2-AdrielDeSouza-D) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
;;Nome: Adriel de Souza
;;Fundamento de Algoritmos (INF05008) - Profa. Leila
;;LISTA 2

;; Este trabalho é individual!

;; ========================================================================================
;;                              DEFINIÇÕES DE DADOS
;; ========================================================================================

;; -----------------
;; TIPO Produto:
;; -----------------
(define-struct produto (nome código quantidade preço min-desconto))  
;; Um elemento do conjunto Produto é
;;   (make-produto n c q p m)     onde
;;   n : String, é o nome do produto
;;   c : Número, é o código do produto
;;   q : Número, é a quantidade do produto em estoque
;;   p : Número, é o preço unitário do produto
;;   m : Número, é número mínimo de itens que o cliente deve comprar para obter desconto de 10%

;; -----------------
;; TIPO Item
;; -----------------
(define-struct item (código quantidade))  
;; Um elemento do conjunto Item é
;;   (make-item c q)     onde
;;   c : Número, é o código do produto
;;   q : Número, é a quantidade do produto no carrinho de compras

;; ========================================================================================
;;                     FUNÇÕES ÚTEIS PARA REALIZAR O EXERCÍCIO 8
;; ========================================================================================

;; ------------------------
;; FUNÇÃO imprime-preço:
;; ------------------------
;; imprime-preço: Número -> String
;; Dado um número, gera a string correspondente este valor em reais.
;; Exemplos:
;;       (imprime-preço 2) = "R$ 2,00"
;;       (imprime-preço 2.1) = "R$ 2,10"
;;       (imprime-preço 2.15) = "R$ 2,15"
;;       (imprime-preço 2.159) = "R$ 2,15"
(define (imprime-preço N)
   (string-append
                 "R$ "
                 (number->string (floor N))  ;; string com a parte inteira de N
                 ","
                 (cond ;; definir como serão as 2 casas decimais do valor:
                   ;; se o número N for inteiro,  devolver string com dois zeros
                   [(integer? N) "00"]
                   ;; se N tiver somente uma casa decimal, gerar string com essa casa e um zero depois
                   [(integer? (* N 10)) (string-append  (number->string (remainder (* N 10)  10)) "0")]
                   ;; se N tiver duas casas decimais, gerar string com as duas casas decimais de N
                   [(integer? (* N 100)) (number->string (remainder (* N 100)  100)) ]
                   ;; senão, truncar N para 2 casas decimais e gerar string com essas casas decimais
                   [else (number->string (remainder (floor (* N 100))  100))])))

;; ------------------------
;; FUNÇÃO imprime-courier:
;; ------------------------
;; imprime-courier: String  Numero  String-> Imagem
;; Dados uma string, um tamanho de fonte e uma cor, gera uma imagem a partir da string com fonte courier no tamanho e cor desejados.
(define (imprime-courier uma-string tam cor)
  (text/font uma-string tam cor "courier" "default" "normal" 'normal #f))

;; ------------------------
;; FUNÇÃO completa-string:
;; ------------------------
;; completa-string: String Numero String -> String
;; Dados um caracter a ser usado como separador, um número representando o tamanho desejado da string e uma string,
;; insere o separador o número de vezes necessárias no final da string até atingir o tamanho dado.
;; Exemplos:
;;    (completa-string "-" 5 "") = "-----"
;;    (completa-string "*" 3 "ABC") = "ABC"
;;    (completa-string "*" 0 "ABC") = "ABC"
;;    (completa-string "." 10 "1 - AAA") = "1 - AAA..."

(define (completa-string SIMB N STR)
  (cond
    ;; se o tamanho da string STR é maior ou igual a N, devolver essa string
    [(>= (string-length STR) N) STR]
    ;; senão inserir o símbolo SIMB em STR até atingir o tamanho N
    [else (completa-string SIMB N (string-append STR SIMB))])) 
 
;; ========================================================================================
;;                                 EXERCÍCIOS
;; ========================================================================================

;; ==============================================================
;; 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
;; ==============================================================

;; -----------
;; TIPO Estoque:
;; -----------
;; Um elemento do tipo Estoque é
;;  i. vazio (empty) ou
;;  ii. (cons e l), onde
;;   e:  um Produto,
;    l: um elemento do tipo Estoque

;; Constantes do tipo Estoque:
(define ESTOQUE1
  (cons(make-produto "Água" 1 256 1.0 12)
       (cons(make-produto "Pão" 2 50 6.5 5)
            (cons(make-produto "Leite" 3 75 4.5 12)
                 (cons(make-produto "Lava roupas" 4 100 12.75 6)
                      (cons(make-produto "Vinagre" 5 48 3.15 8)
                           (cons(make-produto "Azeite" 6 120 7.43 20)
                                (cons(make-produto "Arroz" 7 780 12.5 10)
                                     (cons(make-produto "Feijão" 8 180 7.6 6)
                                          (cons(make-produto "Esponja" 9 1000 0.99 50)
                                               (cons(make-produto "Sabonete" 10 300 1.5 8)
                                                    empty)))))))))))

(define ESTOQUE2
  (cons(make-produto "Refrigerante" 11 450 6.65 8)
       (cons(make-produto "Vinho" 12 50 34.9 24)
            (cons(make-produto "Bolacha" 13 140 5.3 24)
                 (cons(make-produto "Farrinha" 14 100 17.5 5)
                      (cons(make-produto "Iogurte" 15 50 3.25 6)
                           (cons (make-produto "Lampada" 16 120 7.99 5)
                                 (cons(make-produto "Ração" 17 140 13.99 6)
                                      (cons(make-produto "Chocolate" 18 60 6.75 12)
                                           (cons(make-produto "Molho de tomate" 19 750 1.99 14)
                                                (cons(make-produto "Brinquedo" 20 300 15.5 3)
                                                     empty)))))))))))

;; -----------------
;; TIPO Carrinho:
;; -----------------
;; Um elemento do tipo Carrinho: é
;;  i. vazio (empty) ou
;;  ii. (cons e l), onde
;;   e : um Item,
;    l : um elemento do tipo Carrinho

;; Constantes do tipo Carrinho:
(define CARRINHO1
  (cons(make-item 5 12)
       (cons(make-item 6 8)
            (cons(make-item 3 3)
                 (cons(make-item 2 4)
                      (cons(make-item 10 5)
                           (cons(make-item 9 15)
                                (cons(make-item 7 10)
                                     empty))))))))

(define CARRINHO2
  (cons(make-item 15 25)
       (cons(make-item 16 16)
            (cons(make-item 13 85)
                 (cons(make-item 12 12)
                      (cons(make-item 20 43)
                           (cons(make-item 19 10)
                                (cons(make-item 17 25)
                                     empty))))))))


;; ==============================================================
;; 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
;; ==============================================================

;; ---------------------
;; FUNÇÃO preço-produto:
;; ---------------------
;;preço-produto: Número Estoque -> Número
;;Dado um código de um produto e um estoque, nesta ordem, devolve o
;; valor deste produto.

;;Exemplos/testes
(check-expect (preço-produto 1 ESTOQUE1) 1.0)
(check-expect (preço-produto 51 ESTOQUE1) -1)
(check-expect (preço-produto 14 ESTOQUE2) 17.5)

(define (preço-produto @cod @estoque)
  (cond
    ;;Se @estoque estiver vazio, devolve -1
    [(empty? @estoque) -1]

    ;;Se o código do primeiro item do @estoque for igual ao buscado devolve o preço.
    [(= (produto-código (first @estoque)) @cod) (produto-preço (first @estoque))]

    ;;Caso contrário, busca o preço no resto de @cod no resto do @estoque
    [else (preço-produto @cod (rest @estoque))]))
 
;; ==============================================================
;; 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
;; ==============================================================

;; -----------
;; TIPO StringOuNúmero:
;; -----------
;; Um elemento do tipo StringOuNúmero é
;;  i. String ou
;;  ii. Número

;; -----------
;; TIPO ProdutoOuNúmero:
;; -----------
;; Um elemento do tipo ProdutoOuNúmero é
;;  i. Produto ou
;;  ii. Número

;; -----------------------
;; FUNÇÃO atributo-produto:
;; -----------------------
;; atribuito-produto: String Número Estoque -> StringOuNúmero
;; Dados um tipo de atributo, o código de um produto, e um estoque, nesta ordem, devolve o
;; tipo de atributo do produto desejado desta forma:
;; se o tipo for "preço" devolve o preço, se for "nome" devolve o nome, se for "quantidade" devolve
;; a quantidade em estoque e se for "min-desconto" devolve o mínimo de unidades que devem ser
;; compradas para obter desconto. Se o produto não estiver no estoque, devolve -1.
(check-expect (atributo-produto "nome" 1 ESTOQUE1) "Água")
(check-expect (atributo-produto "quantidade" 51 ESTOQUE1) -1)
(check-expect (atributo-produto "min-desconto" 14 ESTOQUE2) 5)


(define (atributo-produto @atr @cod @estoque)
  (cond
    ;;Se (busca-produto) retornar -1, então o produto não existe no estoque, devolve -1
    [(number? (busca-produto @cod @estoque)) -1]

    ;;Para os demais casos, obtem de retorna o atributo selecionado
    [(string=? "preço" @atr) (produto-preço (busca-produto @cod @estoque))]
    [(string=? "nome" @atr) (produto-nome (busca-produto @cod @estoque))]
    [(string=? "quantidade" @atr) (produto-quantidade (busca-produto @cod @estoque))]
    [(string=? "min-desconto" @atr) (produto-min-desconto (busca-produto @cod @estoque))]
    ))

;; -----------------------
;; FUNÇÃO busca-produto
;; -----------------------
;; busca-produto Número Estoque -> ProdutoOuNúmero
;; Dados o código de um produto e um estoque, nesta ordem, devolve o produto correspondente;
;; Exemplos/testes
(check-expect (busca-produto 1 ESTOQUE1) (make-produto "Água" 1 256 1 12))
(check-expect (busca-produto 51 ESTOQUE1) -1)
(check-expect (busca-produto 14 ESTOQUE2) (make-produto "Farrinha" 14 100 17.5 5))


(define (busca-produto @cod @estoque)
  (cond
    ;;Se @estoque estiver vazio, devolve -1
    [(empty? @estoque) -1]

    ;;Se o código do primeiro item do @estoque for igual ao buscado devolve o produto.
    [(= (produto-código (first @estoque)) @cod) (first @estoque)]

    ;;Caso contrário, busca o produto no resto de @cod no resto do @estoque
    [else (busca-produto @cod (rest @estoque))]))


;; ==============================================================
;; 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 
;; ==============================================================

;; --------------------------
;; FUNÇÃO  total-item:
;; --------------------------
;; Dados um item e um estoque, nesta ordem, devolve o valor a ser pago pela
;; quantidade comprada deste item.
;; Exemplos/testes
(check-expect (total-item (make-item 15 25) ESTOQUE2) 73.125)
(check-expect (total-item (make-item 16 16) ESTOQUE2) 115.056)
(check-expect (total-item (make-item 13 2) ESTOQUE2) 10.6)

(define (total-item @item @estoque)
  ;;Retorna o resultado da multiplicação de:
  (*
   (item-quantidade @item) ;;Quantidade do item
   (atributo-produto "preço" (item-código @item) @estoque) ;;Preço do produto
   (cond
     [(>= ;;Se a quantidade do item for maior ou igual ao min. para desconto
       (item-quantidade @item)
       (atributo-produto "min-desconto" (item-código @item) @estoque))
      0.9] ;;Multiplica por 0.9 (-10%);
     [else 1]) ;;Caso contrário por 1;
   ))

;; ==============================================================
;; 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 
;; ==============================================================
;; --------------------------
;; FUNÇÃO total-carrinho:
;; --------------------------
;; total-carrinho: Carrrinho Estoque -> Número
;; Dados um carrinho e um estoque, nesta ordem, devolve o valor a ser pago, considerando
;; os possíveis descontos por quantidade
;; Exemplos/testes
(check-expect (total-carrinho CARRINHO1 ESTOQUE1) 267.81)
(check-expect (total-carrinho CARRINHO2 ESTOQUE2) 1946.956)


(define (total-carrinho @carrinho @estoque)
  (cond
    [(empty? @carrinho) 0] ;; Se @carrinho for vazio, devolve 0
    [else ;;Caso contrário
     (+ ;;Soma
      (total-item (first @carrinho) @estoque) ;;O total do primeiro item do carrinho
      (total-carrinho (rest @carrinho) @estoque) ;;Com o total do resto do carrinho
      )]))

;; ==============================================================
;; 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 
;; ==============================================================


;; -----------
;; TIPO EstoqueOuString
;; -----------
;; Um elemento do tipo EstoqueOuString é
;;  i. Estoque ou
;;  ii. String


;; ------------------------
;; FUNÇÃO atualiza-estoque:
;; ------------------------
;; atualiza-estoque: Item Estoque -> EstoqueOuString
;; Dados um item do carrinho e um estoque, nesta ordem, atualiza o estoque removendo a
;; quantidade comprada deste item do estoque. Se o item não constar no estoque devolve  "Produto não encontrado"
;; Exemplos/testes
(check-expect (atualiza-estoque (make-item 1 56) ESTOQUE1)  (cons (make-produto "Água" 1 200 1.0 12) (cons (make-produto "Pão" 2 50 6.5 5)(cons (make-produto "Leite" 3 75 4.5 12)(cons (make-produto "Lava roupas" 4 100 12.75 6)(cons (make-produto "Vinagre" 5 48 3.15 8)(cons (make-produto "Azeite" 6 120 7.43 20)(cons (make-produto "Arroz" 7 780 12.5 10)(cons (make-produto "Feijão" 8 180 7.6 6) (cons (make-produto "Esponja" 9 1000 0.99 50)(cons (make-produto "Sabonete" 10 300 1.5 8) empty)))))))))))
(check-expect (atualiza-estoque-certeza (make-item 3 12) ESTOQUE1)  (cons (make-produto "Água" 1 256 1.0 12) (cons (make-produto "Pão" 2 50 6.5 5)(cons (make-produto "Leite" 3 63 4.5 12)(cons (make-produto "Lava roupas" 4 100 12.75 6)(cons (make-produto "Vinagre" 5 48 3.15 8)(cons (make-produto "Azeite" 6 120 7.43 20)(cons (make-produto "Arroz" 7 780 12.5 10)(cons (make-produto "Feijão" 8 180 7.6 6) (cons (make-produto "Esponja" 9 1000 0.99 50)(cons (make-produto "Sabonete" 10 300 1.5 8) empty)))))))))))
(check-expect (atualiza-estoque (make-item 1 56) ESTOQUE2)  "Produto não encontrado")

(define (atualiza-estoque @item @estoque)
  (cond
   ;;O (busca-produto) retornar um número, então o item não existe no estoque, devolve  "Produto não encontrado"
   [(number? (busca-produto (item-código @item) @estoque)) "Produto não encontrado"]
   ;;Caso contrário, devolve o estoque atualizado
   [else (atualiza-estoque-certeza @item @estoque)]))


;; ------------------------
;; FUNÇÃO atualiza-estoque-certeza:
;; ------------------------
;; atualiza-estoque: Item Estoque -> Estoque
;; Dados um item do carrinho e um estoque, nesta ordem, atualiza o estoque removendo a
;; quantidade comprada deste item do estoque
;; Exemplos/testes
(check-expect (atualiza-estoque-certeza (make-item 2 5) ESTOQUE1)  (cons (make-produto "Água" 1 256 1.0 12) (cons (make-produto "Pão" 2 45 6.5 5)(cons (make-produto "Leite" 3 75 4.5 12)(cons (make-produto "Lava roupas" 4 100 12.75 6)(cons (make-produto "Vinagre" 5 48 3.15 8)(cons (make-produto "Azeite" 6 120 7.43 20)(cons (make-produto "Arroz" 7 780 12.5 10)(cons (make-produto "Feijão" 8 180 7.6 6) (cons (make-produto "Esponja" 9 1000 0.99 50)(cons (make-produto "Sabonete" 10 300 1.5 8) empty)))))))))))
(check-expect (atualiza-estoque-certeza (make-item 3 12) ESTOQUE1)  (cons (make-produto "Água" 1 256 1.0 12) (cons (make-produto "Pão" 2 50 6.5 5)(cons (make-produto "Leite" 3 63 4.5 12)(cons (make-produto "Lava roupas" 4 100 12.75 6)(cons (make-produto "Vinagre" 5 48 3.15 8)(cons (make-produto "Azeite" 6 120 7.43 20)(cons (make-produto "Arroz" 7 780 12.5 10)(cons (make-produto "Feijão" 8 180 7.6 6) (cons (make-produto "Esponja" 9 1000 0.99 50)(cons (make-produto "Sabonete" 10 300 1.5 8) empty)))))))))))

(define (atualiza-estoque-certeza @item @estoque)
  (cond
   ;;Se o estoque estiver vazio, retorna empty
   [(empty? @estoque) empty]
   ;;Coso contrário, constrói uma lista
   [else
    (cons
     (cond
       [(= (produto-código (first @estoque)) (item-código @item)) ;;Se o código do primeiro produto do estoque for igual ao código do item
        (atualiza-qtde-produto (first @estoque) (- (item-quantidade @item)))] ;;Devolve o produto atualizado
       [else (first @estoque)]) ;;Caso contrário, devolve o produto sem alteração
     ;;Com o estoque atualizado do resto da lista
     (atualiza-estoque-certeza @item (rest @estoque))
     )]))


;; ------------------------
;; FUNÇÃO atualiza-qtde-produto:
;; ------------------------
;; atualiza-qtde-produto Produto Número -> Produto
;; Dados um produto e uma quantidade (positiva ou negativa), altera a quantidade
;; do produto
(check-expect (atualiza-qtde-produto (make-produto "Água" 1 256 1.0 12) -200) (make-produto "Água" 1 56 1.0 12))
(check-expect (atualiza-qtde-produto (make-produto "Água" 1 256 1.0 12) 44) (make-produto "Água" 1 300 1.0 12))

(define (atualiza-qtde-produto @produto @qtde)
  (make-produto ;;Constroi um produto mantendo todas os atributos inalterados execeto  a quantidade
   (produto-nome @produto)
   (produto-código @produto)
   (+ (produto-quantidade @produto) @qtde) ;;Soma a quantidade do produto com @qtde;
   (produto-preço @produto)
   (produto-min-desconto @produto)))

;; ==============================================================
;; 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 
;; ==============================================================

;; -----------------
;; TIPO Item-nota:
;; -----------------
(define-struct item-nota (nome quantidade valor-bruto valor))
;; Um elemento do conjunto Item-nota é dado por
;; (make-item-nota @n @q @v-b @v), onde
;;    @n : String, representando o nome do produto
;;    @q : String, representando a quantidade do item
;;    @v-b : String, representando o valor bruto (sem descontos)
;;    @v : String, representando o valor total do item (com descontos)

;; -----------------
;; TIPO ItensNota
;; -----------------
;; Um elemento do conjunto ItensNota pode ser:
;;  i. Vazio (empty) ou
;;  ii. (cons @e @l), onde:
;;    @e : ul elemento do conjunto Item-nota,
;;    @l : ItensNota



;; ---------------------------
;; FUNÇÃO  lista-itens-nota-fiscal:
;; ---------------------------
;; lista-itens-nota-fiscal: Carrinho Estoque -> ItensNota
;; Dados um carrinho e um estoque, devolve uma lista de quadruplas contendo, para cada item do carrinho:
;; o nome do produto comprado, a quantidade, o valor que seria pago  por esta quantidade de itens
;; sem desconto e o valor a ser pago considerando o desconto, nesta ordem.
;; Exemplos/testes:
(check-expect (lista-itens-nota-fiscal CARRINHO1 ESTOQUE1) (cons (make-item-nota "Vinagre" 12 37.8 34.02)(cons (make-item-nota "Azeite" 8 59.44 59.44) (cons (make-item-nota "Leite" 3 13.5 13.5) (cons (make-item-nota "Pão" 4 26 26) (cons (make-item-nota "Sabonete" 5 7.5 7.5) (cons (make-item-nota "Esponja" 15 14.85 14.85) (cons (make-item-nota "Arroz" 10 125 112.5) empty))))))))
(check-expect (lista-itens-nota-fiscal CARRINHO2 ESTOQUE2) (cons(make-item-nota "Iogurte" 25 81.25 73.125)(cons (make-item-nota "Lampada" 16 127.84 115.056) (cons (make-item-nota "Bolacha" 85 450.5 405.45) (cons (make-item-nota "Vinho" 12 418.8 418.8) (cons (make-item-nota "Brinquedo" 43 666.5 599.85) (cons (make-item-nota "Molho de tomate" 10 19.9 19.9) (cons (make-item-nota "Ração" 25 349.75 314.775) empty))))))))

(define (lista-itens-nota-fiscal @carrinho @estoque)
  (cond
    ;;Se @carrinho for vazio, devolve empty
    [(empty? @carrinho) empty]
    ;;Caso contrário
    [else
     ;;Constrói uma lista com
     (cons
       ;;Um elemento do tipo Item-nota com base no primeiro item do carrinho
      (make-item-nota
       (atributo-produto "nome" (item-código (first @carrinho)) @estoque) ;;Nome o item
       (item-quantidade (first @carrinho)) ;; Quantidade do item
       (* ;;O valor bruto do produto -- Quantidade multiplicada pelo preço
        (item-quantidade (first @carrinho))
        (atributo-produto "preço" (item-código (first @carrinho)) @estoque))
       (total-item (first @carrinho) @estoque)) ;;O valor total do item
      ;;Com a lista dos itens do resto do carrinho
      (lista-itens-nota-fiscal (rest @carrinho) @estoque)
      )]))


;; ==============================================================
;; 8 8 8 8 8 8 8 8 8 8 8  QUESTÃO BÔNUS 8 8 8 8 8 8 8 8 8 8 8 8
;; ==============================================================

;; DEFINIÇÃO DE CONSTANTES

(define ESPAÇADOR5 (rectangle 1 5 "solid" "transparent"))
(define ESPAÇADOR10 (rectangle 1 10 "solid" "transparent"))
(define ESPAÇADOR20 (above ESPAÇADOR10 (line 300 0 "darkgray") ESPAÇADOR10))

;; ------------------------
;; FUNÇÃO  gera-nota-fiscal:
;; ------------------------
;; gera-nota-fiscal: Carrinho Estoque -> Imagem
;; Dados o carrinho e o estoque, nesta ordem, gera uma imagem da nota fiscal desta compra
;; Exemplos:
;; (gera-nota-fiscal CARRINHO1 ESTOQUE1)
;; (gera-nota-fiscal CARRINHO2 ESTOQUE2)

(define (gera-nota-fiscal @carrinho @estoque)
  (gera-nota-fiscal-lista (lista-itens-nota-fiscal @carrinho @estoque)))


;; ------------------------
;; FUNÇÃO  gera-nota-fiscal-lista:
;; ------------------------
;; gera-nota-fiscal: ItensNota -> Imagem
;; Dado um elemento do tipo ItensNota, gera uma imagem da nota fiscal desta compra
;; (gera-nota-fiscal (lista-itens-nota-fiscal CARRINHO1 ESTOQUE1))
;; (gera-nota-fiscal (lista-itens-nota-fiscal CARRINHO2 ESTOQUE2))


(define (gera-nota-fiscal-lista @lista)
  (desenhar-fundo ;;Desenha o fundo na cor "Cornsilk"
   "Cornsilk"
   (above
    ;;Escreve os dados do cabeçalho
    (imprime-courier "Mercado Huppes" 35 "Black")
    (imprime-courier "Rua Rui Barbosa, 2689 - Rui Barbosa\n Arroio do Meio/RS 95940-000" 10 "Black")
    ESPAÇADOR20

    ;;Desenha os itens da @lista, iniciando pelo indice 1     #
    (imprime-courier "# Descrição               Qtde     Valor   " 13 "black")
    ESPAÇADOR5
    (desenha-itens-nota-fiscal @lista 1)             
    ESPAÇADOR20

    ;;Desenha o rodapé da nota
    (imprime-courier
     (string-append
      "Valor bruto: "
      (imprime-preço (dados-nota-fiscal @lista "valor-bruto"))) ;;Escreve o valor bruto
     15 "black")
    (imprime-courier
     (string-append
      "Desconto total: "
      (imprime-preço (dados-nota-fiscal @lista "desconto"))) ;;Escreve o desconto
     15 "darkgreen")
    (imprime-courier
     (string-append
      "Valor à pagar: "
      (imprime-preço (dados-nota-fiscal @lista "valor"))) ;;Escreve o valor a pagar
     20 "black"))))

;; ------------------------
;; FUNÇÃO  desenhar-fundo
;; ------------------------
;; desenhar-fundo: String Imagem -> Imagem
;; Dados uma cor e uma imagem, nesta ordem, gera uma imagem com o fundo preenchido
;; Exemplo:
;; (desenhar-fundo "black" (circle 25 "solid" "white"))
;; (desenhar-fundo "black" (rectangle 45 45 "outline" "green"))

(define (desenhar-fundo @cor @imagem)
  (overlay ;;Sobrepõe
   @imagem ;;A imagem fornecida
   (rectangle ;;Sobre um retângulo
    (+ 20 (image-width @imagem)) ;;Com largura 20pxs maior que da imagem
    (+ 20 (image-height @imagem)) ;;Com altura 20pxs maior que da imagem
    "solid"
    @cor)))


;; ------------------------
;; FUNÇÃO  dados-nota-fiscal
;; ------------------------
;; dados-nota-fiscal: ItensNota String -> Número
;; Dado um elemento do tipo ItensNota e um tipo de dado, nesta ordem, retorna o dado requisitado
;; Exemplos/Testes:
(check-expect (dados-nota-fiscal (cons (make-item-nota "Vinagre" 12 37.8 34.02) (cons (make-item-nota "Água" 12 11.88 10.69) empty)) "valor-bruto") 49.68)
(check-expect (dados-nota-fiscal (cons (make-item-nota "Vinagre" 12 37.8 34.02) (cons (make-item-nota "Água" 12 11.88 10.69) empty)) "valor") 44.71)


(define (dados-nota-fiscal @lista @tipo)
  (cond
    ;;Se @lista for vazia, devolve 0
    [(empty? @lista) 0]
    ;;Caso contrário, soma
    [else
     (+
      (cond 
        [(string=? @tipo "valor") (item-nota-valor (first @lista))] ;;Se @tipo for valor, o valor
        [(string=? @tipo "valor-bruto") (item-nota-valor-bruto (first @lista))] ;;Se @tipo for valor-bruto, o valor-bruto
        ;;Se @tipo for desconto, o valor-bruto - valor;
        [(string=? @tipo "desconto") (- (item-nota-valor-bruto (first @lista)) (item-nota-valor (first @lista)))])
      ;;À soma do resto dos dados @tipo do resto da @lista
      (dados-nota-fiscal (rest @lista) @tipo))]))



;; ------------------------
;; FUNÇÃO  desenha-itens-nota-fiscal:
;; ------------------------
;; desenha-itens-nota-fiscal: ItensNota Número -> Imagem
;; Dado uma lista de intens da nota e um número inicial gera uma imagem;
;; Exemplos/Testes:
;;(desenha-itens-nota-fiscal (cons (make-item-nota "Vinagre" 12 37.8 34.02) (cons (make-item-nota "Água" 12 11.88 10.69) empty)) 1)
;;(desenha-itens-nota-fiscal (cons (make-item-nota "Doce de leite" 1 4.5 4.5) (cons (make-item-nota "Pão francês" 3 2.34 2.30) empty)) 1)


(define (desenha-itens-nota-fiscal @itens @i)
  (cond
    ;;Se @itens for empty, devolve uma imagem vazia
    [(empty? @itens) empty-image]
    ;; Caso contrário, juntas as imagens, uma acima da outras e alinhadas pela direita
    [else
     (above/align "left"
                  (desenha-item-nota-fiscal (first @itens) @i) ;;Desenha o item
                  (desenha-itens-nota-fiscal (rest @itens) (+ @i 1)))])) ;;Desenha o resto @itens


;; ------------------------
;; FUNÇÃO  desenha-item-nota-fiscal:
;; ------------------------
;; desenha-item-nota-fiscal: Item Número -> Imagem
;; Dado um item e um número, desenha a representação do item na nota fiscal
;; Exemplos/Testes:
;;(desenha-item-nota-fiscal (make-item-nota "Vinagre" 12 37.8 34.02) 1)
;;(desenha-item-nota-fiscal (make-item-nota "Água" 12 11.88 10.69) 5)


(define (desenha-item-nota-fiscal @item @i)
  (above/align "right" ;;Junta as imagens acima uma da outra, alinhadas pela direita
               (imprime-courier ;;Escreve a descriçã(desenha-item-nota-fiscal (make-item-nota "Vinagre" 12 37.8 34.02) ESTOQUE1)o do item
                (string-append ;;Concenta as strings
                 (number->string @i) " " ;;Indice do item, seguido de " "
                 (completa-string "." 20 (item-nota-nome @item)) " " ;;Nome do item
                 (completa-string " " 6 (string-append (number->string (item-nota-quantidade @item)) "un")) ;; Quantidade do item
                 (imprime-preço (item-nota-valor-bruto @item))) ;;Valor bruto do item
                15 "black")
               (cond
                 ;;Se valor bruto for igual ao valor (liquido) devolve uma imagem vazia
                 [(= (item-nota-valor @item) (item-nota-valor-bruto @item)) empty-image]

                 ;;Caso contrário
                 [else 
                  (above/align "right"  ;;Junta as imagens acima uma da outra, alinhadas pela direita
                               (imprime-courier
                                ;;Concatena a string "- " com a diferença entre o valor bruto e valor (liquido)
                                (string-append "- " (imprime-preço (- (item-nota-valor-bruto @item) (item-nota-valor @item))))
                                10 "darkgreen")
                               (beside ;;Juntas as imagens lado a lado
                                (imprime-courier ;;Escreve o indice e "Valor com desconto"
                                 (string-append "(" (number->string @i) ") Valor com desconto: ") 10 "black")
                                (imprime-courier ;;Escreve o valor (liquido)
                                 (imprime-preço (item-nota-valor @item))
                                 13 "black")))])))





;;Informações importantes para o corretor
(gera-nota-fiscal CARRINHO1 ESTOQUE1)


(above
(text "ATENÇÃO!" 25 "red")
(text "As funções que geram imagens devem ser verificadas no programa DrRacket" 10 "red")
(text "pois foram utilizadas funçõos não suportadas pelo WeScheme!" 10 "red")
(text "Grato pela atenção e boa correção ;)" 15 "black"))
