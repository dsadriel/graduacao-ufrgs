;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lista1-AdrielDeSouza-D) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
;;Nome: Adriel de Souza | 005***** | adriel.souza@inf.ufrgs.br
;;Fundamento de Algoritmos (INF05008) - Profa. Leila
;;LISTA 1



;; Este trabalho é individual!

;; ========================================================================================
;;                              DEFINIÇÕES DE DADOS
;; ========================================================================================

;; Definição de constantes:

;; Constantes para os naipes do baralho espanhol:
(define PAUS "paus")
(define COPAS "copas")
(define ESPADAS "espadas")
(define OUROS "ouros")

;; Constates para as cartas especiais (figuras) do baralho espanhol:
(define REI 12)
(define CAVALO 11)
(define VALETE 10)

;; Constante para contorno da carta:
(define CONTORNO-CARTA  (rectangle 60 90 "outline""black"))
(define FUNDO-CARTA     (rectangle 50 80 "solid""white"))
 
;; Tipos:

;; -----------------
;; TIPO Carta:
;; -----------------
(define-struct carta (valor naipe))  
;; Um elemento do conjunto Carta é
;;   (make-carta v n)     onde
;;   v : Número, é o valor da carta, que pode ser qualquer inteiro entre 1 e 7 ou 10 (valete), 11 (cavalo) ou 12 (rei)
;;   n : Número, é o naipe da carta, que pode ser OUROS, PAUS, ESPADAS ou COPAS

;; Constante LIVRE:
(define LIVRE "Livre")

;; ---------------------
;; TIPO CartaouString
;; ---------------------
;; Uma  CartaouString é
;; 1. Uma Carta, ou
;; 2. Uma String

;; -----------------
;; TIPO Mão
;; -----------------
(define-struct mão (pos1 pos2 pos3))
;; Um elemento do conjunto Mão é
;;   (make-mão p1 p2 p3)     onde
;;    p1, p2, p3: CartaouString, que é carta ocupando cada posição.

;; ========================================================================================
;;                               FUNÇÕES
;; ========================================================================================

;; A seguir algumas funções do laboratório 2 (exemplos/testes foram removidos).

;; -----------------------------------
;; FUNÇÃO desenha-carta-sem-estrutura:
;; -----------------------------------
;; desenha-carta-sem-estrutura: Numero String -> Imagem
;; Dados o valor e o naipe de uma carta, nesta ordem, desenha a carta correspondente.
(define (desenha-carta-sem-estrutura um-valor um-naipe)
  (overlay    ;; sobrepõe:
              (above ;; coloca acima:
                     (text (texto-carta um-valor) 15 "black") ;; a imagem do valor um-valor
                     (desenha-naipe um-naipe))                ;;a imagem do  naipe um-naipe
              CONTORNO-CARTA))                                ;; contorno preto

;; ---------------------
;; FUNÇÃO   texto-carta:
;; ---------------------
;; texto-carta: Numero -> String
;; Dado um valor de carta, gera a string correspondente a este número que deve ser escrita na carta.
(define (texto-carta n)
  (cond
       ;; se o número n for o mesmo da constante REI, escreve REI
       [(= n REI) "REI"]
       ;; se o número n for o mesmo da constante CAVALO, escreve CAVALEIRO
       [(= n CAVALO) "CAVALO"]
       ;; se o número n for o mesmo da constante VALETE, escreve VALETE
       [(= n VALETE) "VALETE"]
       ;; senão, escreve o número n
       [else (number->string n)]))

;; -----------------------
;; FUNÇÃO   desenha-naipe:
;; -----------------------
;; desenha-naipe: String -> Imagem
;; Dado um naipe, gera a imagem correspondente.
;(define (desenha-naipe um-naipe)
;  (cond
;       [(string=? um-naipe OUROS)   (circle 15 "solid" "gold")]
;       [(string=? um-naipe COPAS)   (above
;                                        (rotate 180 (wedge 15 180 "solid" "blue"))   ;; taça
;                                        (triangle 10 "solid" "blue"))]               ;; pé
;       [(string=? um-naipe PAUS)     (above
;                                        (wedge 7 180 "solid" "brown")
;                                        (rotate 180 (isosceles-triangle 40 20 "solid" "brown")))]
;       [(string=? um-naipe ESPADAS) (above
;                                        (isosceles-triangle  40 10 "solid" "gray")  ;; ponta da espada
;                                        (rectangle 10 3 "solid" "red")              ;; cabo da espada
;                                        (rectangle 5 10 "solid" "red"))]))          ;; cabo da espada ]))
;;; ----------------
;; FUNÇÃO   ganha?:
;; ----------------
;; ganha? : Número Número -> Booleano
;; Dados os valores de duas cartas diferentes do mesmo naipe, diz se a primeira ganha da segunda, de acordo com as regras da bisca.
(define (ganha? v1 v2)
  (cond
       ;; primeiro vamos considerar as cartas especias (ás e 7):
       ;; se v1 for ás, então true (ás ganha de todas cartas)
       [(= v1 1) #t]
       ;; se v2 for ás, então falso (v1 não é ás e v2 é, então v1 não ganha de v2)
       [(= v2 1) #f]
       ;; se v1 for 7, então true (v2 não pode ser ás pq senão a cond. do caso anterior seria verdadeira)
       [(= v1 7) #t]
       ;; se v2 for 7, então false
       [(= v2 7) #f]
       ;; caso contrário (as cartas não são especiais), é só comparar os números
       [else (> v1 v2)]))

;; -----------------------
;; FUNÇÃO   desenha-carta:
;; -----------------------
;; desenha-carta: Carta -> Imagem
;; Dada uma carta, gera um desenho da carta
;(define (desenha-carta v-carta)
;  (desenha-carta-sem-estrutura (carta-valor v-carta) (carta-naipe v-carta)))

;; ------------------------
;; FUNÇÃO   primeira-ganha?:
;; ------------------------
;; primeira-ganha?: Carta Carta String -> Booleano
;; Dadas 2 cartas, sendo que a primeira tem a preferência (é a carta da mesa, ou foi a primeira colocada na mesa) e o naipe do trunfo, diz se a carta da mão ganha da da mesa.
(define (primeira-ganha? v-primeira v-segunda v-trunfo)
  (cond 
       ;; se as cartas são do mesmo naipe, então a primeira ganha se for maior, de acordo com as regras da Bisca
       [(string=? (carta-naipe v-primeira) (carta-naipe v-segunda)) (ganha? (carta-valor v-primeira) (carta-valor v-segunda))]
       ;; se a primeira carta é um trunfo, ela ganha (como os naipes são diferentes, a segunda não pode ser trunfo)
       [(string=? (carta-naipe v-primeira) v-trunfo) #t]
       ;; se a segunda carta é um trunfo, ela ganha (como os naipes são diferentes, a primeira não é trunfo)
       [(string=? (carta-naipe v-segunda) v-trunfo) #f]
       ;; senão, a primeira ganha (neste caso a segunda carta não é trunfo e é de naipe diferente da primeira)
       [else #t]))

;; --------------------
;; FUNÇÃO  qual-ganha?:
;; --------------------
;; qual-ganha? Carta Carta String -> Carta
;; Dadas 2 cartas, sendo que a primeira tem a preferência (foi colocada antes, ou seja, define o naipe da rodada) e o naipe que é trunfo,
;; devolve a carta que vence, de acordo com as regras da Bisca.
(define (qual-ganha? v-c1 v-c2 v-trunfo)
  (cond
    [(primeira-ganha? v-c1 v-c2 v-trunfo) v-c1]
    [else v-c2]))

;; ---------------------------
;; FUNÇÃO  maior-carta-da-mesa:
;; ---------------------------
;; maior-carta-d-mesa: Carta Carta Carta String -> Carta
;; Dadas as 3 cartas da mesa na ordem na qual foram jogadas e o naipe que é trunfo,
;; devolve maior carta da mesa, de acordo com as regras da Bisca.
(define (maior-carta-da-mesa v-c1 v-c2 v-c3 v-trunfo)
  (qual-ganha? (qual-ganha?  v-c1 v-c2 v-trunfo)
               v-c3
               v-trunfo))

;; -------------------
;; FUNÇÃO  desenha-mão:
;; -------------------
;; desenha-mão: Mão -> Imagem
;; Dada uma mão, gera uma imagem com as cartas da mão, lado a lado
(define (desenha-mão @mao) ;; Dada uma mão @mao
  (beside ;; coloca lado a lado
        (desenha-carta-mão (mão-pos1 @mao))    ;; a imagem da carta da posição 1 da @mao
        (desenha-carta-mão (mão-pos2 @mao))    ;; a imagem da carta da posição 2 da @mao
        (desenha-carta-mão (mão-pos3 @mao))))  ;; a imagem da carta da posição 3 da @mao

;; --------------------------
;; FUNÇÃO  desenha-carta-mão:
;; --------------------------
;; desenha-carta-mão: Mão -> Imagem
;; Dada uma carta da mão, gera imagem da carta, se for uma carta,
;; ou uma imagem de um retângulo escrito LIVRE, se não for carta.
(define (desenha-carta-mão @carta)
  (cond
      ;; se a posição for livre, desenha um retângulo escrito livre
      [(string? @carta) (overlay (text @carta 25 "black") (rectangle 60 90 "outline""black"))]
      ;; senão, desenha a carta  correspondente
      [else (desenha-carta  @carta)]))

;
;
;
;
;
;
;
;
;
;
;
;
;
;
;
;
;
;
;
;
;
;
;
;; ========================================================================================
;;                                 EXERCÍCIOS
;; ========================================================================================


;; ==============================================================
;; 8 8 8 8 8 8 8 8 8 8 8  QUESTÃO BÔNUS 8 8 8 8 8 8 8 8 8 8 8 8
;; ==============================================================
;; Coloque aqui a suas novas funções desenha-carta, desenha-naipe
;; e outras auxiliares.


;; Definição de constantes:

;; Constantes para os desenhos dos naipes do baralho:

(define DESENHO-PAUS
  (scale .35
         (rotate -20
                 (overlay/xy
                  (star-polygon 5 10 3 "solid" "cornflowerblue")
                  -23 -75
                  (overlay/xy
                   (star-polygon 4 10 3 "solid" "cornflowerblue")
                   -23 -119
                   (overlay/xy
                    (rotate -30(ellipse 20 10 "solid" "Olive Drab"))
                    -30 -27
                    (overlay/xy
                     (rotate -135 (ellipse 20 8 "solid" "Olive Drab"))
                     -14 -55
                     (overlay/xy
                      (ellipse 15 10 "solid" "Olive Drab")
                      -30 -95
                      (add-curve 
                       (above
                        (wedge 30 180 "solid" "brown")
                        (triangle/sss 120 120 60 "solid" "brown"))
                       55 20 20 -1.3
                       23 120 30 -0.8
                       (make-pen "Dark Olive Green" 5 "solid" "round" "round"))))))))))

(define DESENHO-OUROS
  (scale .5
         (overlay
          (scale .8 (overlay/align/offset
                     "center" "bottom"
                     (rectangle 25 20 "solid" "Goldenrod")
                     -5 -5
                     (overlay/align/offset
                      "left" "center"
                      (triangle 25 "solid" "Goldenrod")
                      7 0
                      (circle 20 "solid" "Goldenrod"))))
          (circle 27 "solid" "gold")
          (circle 30 "solid" "Goldenrod"))))

(define DESENHO-COPAS
  (scale .8
         (overlay
          (radial-star	8 4 8 "solid" "Orange")
          (above
           (star 5 "solid" "Firebrick")
           (crop 0 0 30 10 (wedge 15 180 "solid" "gold"))
           (crop 0 20 30 20 (ellipse 30 40 "solid" "Firebrick"))
           (crop 0 10 20 10 (triangle 20 "solid" "gold"))))))

(define DESENHO-ESPADAS
  (rotate -20
          (scale .4
                 (overlay/align/offset
                  "center" "bottom"
                  (overlay/xy
                   (ellipse 25 10 "solid" "gold")
                   5 -15
                   (rectangle 15 20 "solid" "dark goldenrod"))
                  0 -20
                  (above
                   (beside
                    (flip-horizontal (right-triangle 10 100 "solid" "Royal blue"))
                    (right-triangle 10 100 "solid" "Dodger Blue"))
                   (beside
                    (rectangle 10 8 "solid" "royal blue")
                    (rectangle 10 8 "solid" "dodger blue"))
                   (overlay/xy
                    (circle 5 "solid" "Goldenrod")
                    -30 0
                    (overlay/xy
                     (circle 5 "solid" "Goldenrod")
                     5 0
                     (rectangle 30 8 "solid" "Goldenrod"))))))))


;; ========================================================================================
;;                               FUNÇÕES
;; ========================================================================================


;; ----------------------
;; FUNÇÃO  desenha-naipe:
;; ----------------------
;; desenha-naipe: String -> Imagem
;; Dada uma naipe (string), retorna uma imagem correspondente
;; Exemplos:
;;  (desenha-naipe PAUS)
(define (desenha-naipe @naipe)
  (cond ;;Inicio do bloco condicional
    
    ;;Se @naipe for um naipe possível então chama sua respectiva constante
    [(string=? @naipe OUROS) DESENHO-OUROS]
    [(string=? @naipe COPAS) DESENHO-COPAS]
    [(string=? @naipe ESPADAS) DESENHO-ESPADAS]
    [(string=? @naipe PAUS) DESENHO-PAUS]))



;; -----------------------------------
;; FUNÇÃO desenha-carta:
;; -----------------------------------
;; desenha-carta: Carta  -> Imagem
;; Dado uma carta desenha a carta correspondente.
;; Exemplos:
;;   (desenha-carta (make-carta 1 OUROS))

(define (desenha-carta @carta)
  (overlay;; sobrepõe:
   (cond  ;;Gera uma imagem correspondente para cada valor possível.
     [(string? @carta) (rotate 90 (text LIVRE 20 "gray"))] ;;Se a carta for Livre escreve "Livre"

     ;;Para as cartas numéricas, de 1 a 7, desenha a quantidade correspondente:

     ;;Se o valor da carta for 1
     [(= (carta-valor @carta) 1) (scale 1.2 ;;Escala a imagem 1.2x
                                        (desenha-naipe (carta-naipe @carta)))] ;;Desenha o  naipe

     ;;Se o valor da carta for 2
      [(= (carta-valor @carta) 2) (scale .8 ;;Escala a imagem 0.8x
                                         (overlay/xy ;;Sobrepõe deslocando x,y                          
                                            (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                            0 ;;Deslocamento x
                                            45 ;;Deslocamento y
                                            (desenha-naipe (carta-naipe @carta))))] ;;Desenha o naipe

      ;;Se o valor da carta for 3
     [(= (carta-valor @carta) 3) (scale .8  ;;Escala a imagem 0.8x
                                        (overlay/xy ;;Sobrepõe deslocando x,y (i)
                                            (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                            -35 ;;Deslocamento x (i)
                                            -20 ;;Deslocamento y (i)
                                            (overlay/xy ;;Sobrepõe deslocando x,y (ii)
                                             (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                             0 ;;Deslocamento x (ii)
                                             50 ;;Deslocamento y (ii)
                                             (desenha-naipe (carta-naipe @carta)))))] ;;Desenha o naipe

     ;;Se o valor da carta for 4
     [(= (carta-valor @carta) 4) (scale .5  ;;Escala a imagem 0.5x
                                        (overlay/xy ;;Sobrepõe deslocando x,y (i)
                                            (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                            -5  ;;Deslocamento x (i)
                                            0 ;;Deslocamento y (i)
                                            (overlay/xy ;;Sobrepõe deslocando x,y (ii)
                                             (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                             -50  ;;Deslocamento x (ii)
                                             -100 ;;Deslocamento y (ii)
                                             (overlay/xy ;;Sobrepõe deslocando x,y (iii)
                                              (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                              0  ;;Deslocamento x (iii)
                                              -100 ;;Deslocamento y (iii)
                                              (desenha-naipe (carta-naipe @carta))))))] ;;Desenha o naipe

     ;;Se o valor da carta for 5
     [(= (carta-valor @carta) 5) (scale .5  ;;Escala a imagem 0.5x
                                        (overlay ;;Sobrepõe
                                            (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                            (overlay/xy ;;Sobrepõe deslocando x,y (i)
                                             (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                             -50 ;;Deslocamento x (i)
                                             0 ;;Deslocamento y (i)
                                             (overlay/xy ;;Sobrepõe deslocando x,y (i)
                                              (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                              -50 ;;Deslocamento x (ii)
                                              -100 ;Deslocamento y (iii)
                                              (overlay/xy ;;Sobrepõe deslocando x,y (i)
                                               (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                               0 ;;Deslocamento x (iii)
                                               -100 ;Deslocamento y (iii)
                                               (desenha-naipe (carta-naipe @carta)))))))] ;;Desenha o naipe

     ;;Se o valor da carta for 6
     [(= (carta-valor @carta) 6) (scale .5  ;;Escala a imagem 0.5x
                                        (overlay/xy ;;Sobrepõe deslocando x,y (i)
                                         (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                         -50 ;;Deslocamento x (i)
                                         -50 ;;Deslocamento y (i)
                                         (overlay/xy ;;Sobrepõe deslocando x,y (ii)
                                          (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                          0 ;;Deslocamento x (ii)
                                          -50 ;;Deslocamento y (ii)
                                          (overlay/xy ;;Sobrepõe deslocando x,y (iii)
                                           (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                           -50 ;;Deslocamento x (iii)
                                           0 ;;Deslocamento y (iii)
                                           (overlay/xy ;;Sobrepõe deslocando x,y (iv)
                                            (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                            -50 ;;Deslocamento x (iv)
                                            -100 ;;Deslocamento y (iv)
                                            (overlay/xy ;;Sobrepõe deslocando x,y (v)
                                             (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                             0 ;;Deslocamento x (v)
                                             -100 ;;Deslocamento y (v)
                                             (desenha-naipe (carta-naipe @carta))))))))] ;;Desenha o naipe

     ;;Se o valor da carta for 7
     [(= (carta-valor @carta) 7) (scale .5 ;;Escala a imagem 0.5x
                                        (overlay/xy ;;Sobrepõe deslocando x,y (i)
                                         (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                         -25 ;;Deslocamento x (i)
                                         -25 ;;Deslocamento y (i)
                                         (overlay/xy ;;Sobrepõe deslocando x,y (ii)
                                          (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                          -50 ;;Deslocamento x (ii)
                                          -65 ;;Deslocamento y (ii)
                                          (overlay/xy ;;Sobrepõe deslocando x,y (iii)
                                           (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                           0 ;;Deslocamento x (iii) 
                                           -65 ;;Deslocamento y (iii)
                                           (overlay/xy ;;Sobrepõe deslocando x,y (iv)
                                            (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                            -50 ;;Deslocamento x (iv)
                                            0 ;;Deslocamento y (iv)
                                            (overlay/xy ;;Sobrepõe deslocando x,y (v)
                                             (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                             -50 ;;Deslocamento x (v)
                                             -100 ;;Deslocamento y (v)
                                             (overlay/xy ;;Sobrepõe deslocando x,y (vi)
                                              (desenha-naipe (carta-naipe @carta)) ;;Desenha o naipe
                                              0 ;;Deslocamento x (vi)
                                              -100 ;;Deslocamento y (vi) 
                                              (desenha-naipe (carta-naipe @carta)))))))))] ;;Desenha o naipe


     [(= (carta-valor @carta) REI) ;;Se for a carta for REI
      (beside ;;Coloca ao lado
      (rotate 90 ;;Rotaciona 90º
              (text "--- Rei ---" 18 "black")) ;;Escreve o texto
      (desenha-naipe (carta-naipe @carta)))]  ;;Desenha o naipe
     [(= (carta-valor @carta) VALETE)  ;;Se for a carta for VALETE
      (beside
      (rotate 90  ;;Rotaciona 90º 
              (text "-- Valete --" 18 "black")) ;;Escreve o texto
      (desenha-naipe (carta-naipe @carta)))]  ;;Desenha o naipe
      
     [(= (carta-valor @carta) CAVALO)  ;;Se for a carta for CAVALO
      (beside
      (rotate 90  ;;Rotaciona 90º 
              (text "- Cavalo -" 18 "black")) ;;Escreve o texto
      (desenha-naipe (carta-naipe @carta)))] ;;Desenha o naipe
      
     )
   FUNDO-CARTA ;;O fundo da carta
   CONTORNO-CARTA))


;; Constante do tipo Imagem contendo o baralho completo
(define BARALHO (above (beside (desenha-carta (make-carta 1 OUROS))(desenha-carta (make-carta 2 OUROS))(desenha-carta (make-carta 3 OUROS))(desenha-carta (make-carta 4 OUROS))(desenha-carta (make-carta 5 OUROS))(desenha-carta (make-carta 6 OUROS))(desenha-carta (make-carta 7 OUROS))(desenha-carta (make-carta CAVALO OUROS))(desenha-carta (make-carta VALETE OUROS))(desenha-carta (make-carta REI OUROS)))(beside (desenha-carta (make-carta 1 COPAS))(desenha-carta (make-carta 2 COPAS))(desenha-carta (make-carta 3 COPAS))(desenha-carta (make-carta 4 COPAS))(desenha-carta (make-carta 5 COPAS))(desenha-carta (make-carta 6 COPAS))(desenha-carta (make-carta 7 COPAS))(desenha-carta (make-carta CAVALO COPAS))(desenha-carta (make-carta VALETE COPAS))(desenha-carta (make-carta REI COPAS)))(beside (desenha-carta (make-carta 1 ESPADAS))(desenha-carta (make-carta 2 ESPADAS))(desenha-carta (make-carta 3 ESPADAS))(desenha-carta (make-carta 4 ESPADAS))(desenha-carta (make-carta 5 ESPADAS))(desenha-carta (make-carta 6 ESPADAS))(desenha-carta (make-carta 7 ESPADAS))(desenha-carta (make-carta CAVALO ESPADAS))(desenha-carta (make-carta VALETE ESPADAS))(desenha-carta (make-carta REI ESPADAS)))(beside (desenha-carta (make-carta 1 PAUS))(desenha-carta (make-carta 2 PAUS))(desenha-carta (make-carta 3 PAUS))(desenha-carta (make-carta 4 PAUS))(desenha-carta (make-carta 5 PAUS))(desenha-carta (make-carta 6 PAUS))(desenha-carta (make-carta 7 PAUS))(desenha-carta (make-carta CAVALO PAUS))(desenha-carta (make-carta VALETE PAUS))(desenha-carta (make-carta REI PAUS)))))



;; ==============================================================
;; 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
;; ==============================================================
;; ---------------
;; FUNÇÃO  pontos:
;; ---------------
;; pontos: CartaouString ->  Numero
;;    Dada uma carta, devolve o valor da pontuação desta carta de acordo com as
;;    regras da Bisca
;; Exemplos:
;; (pontos (make-carta 1 PAUS))
;; (pontos (make-carta 2 OUROS))
;; (pontos (make-carta REI OUROS))
;; (pontos LIVRE)

(define (pontos @carta)(cond
                         [(string? @carta) 0]                ;;Se a carta for uma string, retorna 0 pontos
                         [(= (carta-valor @carta) 1) 11]     ;;Se Ás, então vale 11 pontos
                         [(= (carta-valor @carta) 7) 10]     ;;Se 7, então vale 10 pontos
                         [(= (carta-valor @carta) REI) 4]    ;;Se REI, então vale 4 pontos
                         [(= (carta-valor @carta) CAVALO) 3] ;;Se CAVALO, então vale 3 pontos
                         [(= (carta-valor @carta) VALETE) 2] ;;Se VALETE, então vale 2 pontos
                         [else 0]))                          ;;Caso contrário, todas as demiais cartras valem 0 pontos 

;;Testes:
(check-expect (pontos (make-carta 1 PAUS)) 11)
(check-expect (pontos LIVRE) 0)
(check-expect (pontos (make-carta REI OUROS)) 4)
(check-expect (pontos (make-carta 7 ESPADAS)) 10)

;; ==============================================================
;; 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
;; ==============================================================
;; --------------------
;; FUNÇÃO  soma-pontos:
;; ---------------
;; soma-pontos Mão ->  Numero
;;    Dada uma mão, devolve devolve a soma dos pontos das cartas que há na mão
;; Exemplos:
;; (soma-pontos (make-mão (make-carta 1 PAUS) (make-carta 2 OUROS) (make-carta REI OUROS))) = 15
;; (soma-pontos (make-mão (make-carta VALETE PAUS) (make-carta 2 ESPADAS) (make-carta REI OUROS))) = 6

(define (soma-pontos @mão)(+
                           (cond
                             [(carta? (mão-pos1 @mão)) (pontos (mão-pos1 @mão))] ;;Se o conteúdo da PRIMEIRA posição da mão for uma carta, usa seus pontos
                             [else 0])                                           ;;Caso contrário, usa 0 

                           (cond
                             [(carta? (mão-pos2 @mão)) (pontos (mão-pos2 @mão))] ;;Se o conteúdo da SEGUNDA posição da mão for uma carta, usa seus pontos
                             [else 0])                                           ;;Caso contrário, usa 0 

                           (cond
                             [(carta? (mão-pos3 @mão)) (pontos (mão-pos3 @mão))] ;;Se o conteúdo da TERCEIRA posição da mão for uma carta, usa seus pontos
                             [else 0])))                                         ;;Caso contrário, usa 0 
;;Teste:
(check-expect (soma-pontos (make-mão (make-carta 1 PAUS) (make-carta 2 OUROS) (make-carta REI OUROS))) 15)
(check-expect (soma-pontos (make-mão (make-carta VALETE PAUS) (make-carta 2 ESPADAS) (make-carta REI OUROS))) 6)
          

;; ==============================================================
;; 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
;; ==============================================================
;; -----------
;; TIPO Dupla:
;; -----------
(define-struct dupla (nome pontos mão1 mão2))
;; Um elemento do conjunto Duplo é
;;   (make-dupla m p m1 m2)     onde
;;   m : String, é nome da dupla
;;   p : Numero, é numero de pontos acumulados
;;   m1: Mão, é a mão do primeiro jogador
;;   m2: Mão, é a mão do segundo jogador

;; Constantes do tipo Dupla
(define DUPLA_1
  (make-dupla "Adriel e Refael"
              11
              (make-mão (make-carta 1 ESPADAS) (make-carta VALETE COPAS) "Livre")
              (make-mão (make-carta 5 PAUS) (make-carta 1 COPAS) (make-carta REI OUROS))))

(define DUPLA_2
  (make-dupla "Maria e Henrique"
              10
              (make-mão (make-carta 1 PAUS) (make-carta 2 OUROS) (make-carta REI OUROS))
              (make-mão (make-carta 7 OUROS) (make-carta CAVALO PAUS) LIVRE)))


;; ==============================================================
;; 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 
;; ==============================================================
;; ------------------------
;; FUNÇÃO  atualiza-pontos:
;; ------------------------
;; atualiza-pontos: Dupla ->  Dupla
;;    Dada uma dupla atualiza o número de pontos da dupla somando
;     aos pontos acumulados os pontos das cartas das mãos dos jogadores da dupla.
;; Exemplos:
;; (atualiza-pontos DUPLA_1)
;; (atualiza-pontos DUPLA_2)

(define (atualiza-pontos @dupla)(make-dupla ;;Retorna um novo elemento do tipo/conjunto Dupla
                                 (dupla-nome @dupla) ;;Não altera o nome
                                 (+ ;;Soma:
                                  (dupla-pontos @dupla) ;; (i) Os pontos da dupla
                                  (soma-pontos (dupla-mão1 @dupla));; (ii) Os pontos da mão1 da dupla
                                  (soma-pontos (dupla-mão2 @dupla)));; e (iii) Os pontos da mão2 da dupla
                                 (dupla-mão1 @dupla) ;;Não altera a mão1
                                 (dupla-mão2 @dupla)));;Não altera a mão1
;;Testes
(check-expect (atualiza-pontos DUPLA_1)  (make-dupla "Adriel e Refael" 39 (make-mão  (make-carta 1 ESPADAS)  (make-carta 10 COPAS)  "Livre") (make-mão  (make-carta 5 PAUS)  (make-carta 1 COPAS)  (make-carta REI OUROS))))
(check-expect (atualiza-pontos DUPLA_2)  (make-dupla "Maria e Henrique" 38 (make-mão (make-carta 1 PAUS) (make-carta 2 OUROS) (make-carta REI OUROS)) (make-mão (make-carta 7 OUROS) (make-carta CAVALO PAUS) LIVRE)))


;; ==============================================================
;; 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 
;; ==============================================================
;; -----------------
;; TIPO Par:
;; -----------------
(define-struct par (nome pontos))
;; Um elemento do conjunto Par é
;;   (make-par m p)     onde
;;   m : String, é nome da dupla
;;   p : Numero, é numero de pontos acumulados

;; -----------------
;; TIPO Resultado:
;; -----------------
;; Uma  Resultado é
;; 1. Um Par, ou
;; 2. Uma String

;; ------------------------
;; FUNÇÃO  define-vencedor:
;; ------------------------
;; define-vencedor: Dupla Dupla ->  Resultado
;;    Dadas duas duplas, devolve o nome da dupla vencedora, bem como sua pontuação.
;         Em caso de empate devolve a Empate, caso contrário devolve um Par.
;; Exemplos:
;; (define-vencedor DUPLA_1 DUPLA_2)

(define (define-vencedor @dupla1 @dupla2)
  (cond  ;;Inicio do bloco condicional
    [(= (dupla-pontos @dupla1) (dupla-pontos @dupla2)) ;;Se os pontos forem iguais, retorna "Empate"
     "Empate"]
    [(> (dupla-pontos @dupla1) (dupla-pontos @dupla2)) ;;Se  a dupla1 possuir mais pontos que a dupla2, retorna um Par com os dados da dupla1
     (make-par (dupla-nome @dupla1) (dupla-pontos @dupla1))]
    [else (make-par (dupla-nome @dupla2) ;;Caso contrário, retorna um Par com os dados da dupla2
                    (dupla-pontos @dupla2))]))

;;Testes
(check-expect (define-vencedor DUPLA_1 DUPLA_2) (make-par (dupla-nome DUPLA_1) (dupla-pontos DUPLA_1)))

;; ==============================================================
;; 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 
;; ==============================================================
;; ----------------------
;; FUNÇÃO  define-jogada:
;; ----------------------
;; define-jogada: Mão Carta Carta Carta String ->  Carta
;;    Dados uma mão, três cartas da mesa e o naipe que é trunfo, nesta
;;    ordem, devolve a carta da mão escolhida para ser jogada,
;; Exemplos:
;; (define-jogada (dupla-mão1 DUPLA_1) (make-carta 2 OUROS) (make-carta REI PAUS) (make-carta VALETE COPAS) COPAS)
;; (define-jogada (dupla-mão1 DUPLA_1) (make-carta 2 OUROS) (make-carta REI PAUS) (make-carta 7 COPAS) OUROS)

(define (define-jogada @mão @carta1 @carta2 @carta3 @trunfo)
  (cond ;;Inicio do bloco condicional
    
    
    [(and
     (carta? (mão-pos1 @mão))
     (not (primeira-ganha? ;;Se a maior carta da mesa NÃO GANHA da carta na PRIMEIRA posição da mão, então devolve essa carta; 
           (maior-carta-da-mesa @carta1 @carta2 @carta3 @trunfo)
           (mão-pos1 @mão) @trunfo)))
     (mão-pos1 @mão)]
    [(and
     (carta? (mão-pos2 @mão))
     (not (primeira-ganha? ;;Se a maior carta da mesa NÃO GANHA da carta na SEGUNDA posição da mão, então devolve essa carta; 
           (maior-carta-da-mesa @carta1 @carta2 @carta3 @trunfo)
           (mão-pos2 @mão)
           @trunfo)))
     (mão-pos2 @mão)]
    [(carta? (mão-pos3 @mão)) (mão-pos3 @mão)];; Se a for uma carta na TERCEIRA posição, devolve ela
    [(carta? (mão-pos2 @mão)) (mão-pos2 @mão)];; Se a for uma carta na SEGUNDA posição, devolve ela
    [(carta? (mão-pos1 @mão)) (mão-pos1 @mão)];; Se a for uma carta na SEGUNDA posição, devolve ela
    [else (mão-pos3 @mão)] ;;Caso contrário, devolve o conteúdo da TERCEIRA posição.
    ))

;;Teste
(check-expect (define-jogada (dupla-mão1 DUPLA_1) (make-carta 1 OUROS) (make-carta REI PAUS) (make-carta VALETE COPAS) OUROS) (make-carta 10 COPAS))
(check-expect (define-jogada (dupla-mão2 DUPLA_1) (make-carta 2 OUROS) (make-carta REI PAUS) (make-carta 7 COPAS) ESPADAS) (make-carta REI OUROS))

;; ==============================================================
;; 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 
;; ==============================================================
;; ----------------------
;; FUNÇÃO  mostra-jogada:
;; ----------------------
;; mostra-jogada: Dupla Carta Carta Carta String ->  Imagem
;; Dados uma dupla, as 3 cartas da mesa e o naipe que é trunfo, gera uma
;; imagem mostrando a jogada, considerando as cartas do segundo jogador da dupla

;; Exemplos:
;;(mostra-jogada DUPLA_1 (make-carta 2 OUROS) (make-carta REI PAUS) (make-carta 7 COPAS) COPAS)
;;(mostra-jogada DUPLA_1 (make-carta 2 OUROS) (make-carta REI PAUS) (make-carta 7 COPAS) PAUS)
;;(mostra-jogada DUPLA_1 (make-carta 2 OUROS) (make-carta REI PAUS) (make-carta 7 COPAS) ESPADAS)
;;(mostra-jogada DUPLA_1 (make-carta 2 OUROS) (make-carta REI PAUS) (make-carta 7 COPAS) OUROS)

(define (mostra-jogada @dupla @carta1 @carta2 @carta3 @trunfo)
  (above ;; Coloca a partida acima do status
   (overlay/align/offset  ;;Sobrepõe a partir de uma origem com deslocamento (i)
        "center" ;; Origem horizontal (i)
        "bottom" ;; Origem vertical (i)
        (overlay/align/offset ;;Sobrepõe a partir de uma origem com deslocamento (ii)
            "right" ;; Origem horizontal (ii)
            "top" ;; Origem vertical (ii)
            (scale 0.7 (desenha-trunfo @trunfo));; Desenha o trunfo
            -45 20 ;; Deslocamento (ii)
            (desenha-mesa @carta1 @carta2 @carta3)) ;;Desenha a mesa
        0 130 ; Deslocamento (i)
        (overlay/align/offset  ;;Sobrepõe a partir de uma origem com deslocamento (iii)
         "right" ;; Origem horizontal (iii)
         "top" ;; Origem horizontal (iii)
         (desenha-carta-selecionada (define-jogada (dupla-mão2 @dupla) @carta1 @carta2 @carta3 @trunfo))
         -80 0 ; Deslocamento (iii)
         (above ;;Desenha a mão acima o texto
          (desenha-mão (dupla-mão2 @dupla)) ;;Desenha a mão
          (text "Mão do segundo jogador" 13 "black")))) ;;Escreve o texto
   (desenha-status-partida ;;Desenha o status da partida
    (dupla-nome @dupla)
    (primeira-ganha?
     (define-jogada (dupla-mão2 @dupla) @carta1 @carta2 @carta3 @trunfo)
     (maior-carta-da-mesa @carta1 @carta2 @carta3 @trunfo)
     @trunfo))))


;; -----------------------------------------------------------------------
;; FUNÇÃO-AUXILIARES CRIADAS PARA USO EXCLUSIVO DA FUNÇÃO "mostra-jogada"
;; -----------------------------------------------------------------------

;; ----------------------
;; FUNÇÃO  desenha-mesa
;; ----------------------
;; desenha-mesa: Carta Carta Carta ->  Imagem
;; Dado três cartas desenha a mesa contendo tais cartas
;; Exemplos:
;;(desenha-mesa  (make-carta 2 OUROS) (make-carta REI PAUS) (make-carta 7 COPAS))
(define (desenha-mesa @carta1 @carta2 @carta3)
  (overlay/xy ;;Sobrepõe deslocando em x,y (i)
      (desenha-mão (make-mão @carta1 @carta2 @carta3)) ;;Desenha a mão
      -30 -37 ;;Quantidade a ser deslocada (i)
      (overlay/xy  ;;Sobrepõe deslocando em x,y (i)
       (text "Mesa:" 17 "white")  ;;Escreve o texto
       -10 -5 ;;Quantidade a ser deslocada (ii)
       (rectangle 240 150  "solid" "Saddle Brown")))) ;;Desenha um retangulo marrom

;; ----------------------
;; FUNÇÃO  desenha-trunfo
;; ----------------------
;; desenha-trunfo: String ->  Imagem
;; Exemplos:
;; Dado um trunfo (string) desenha seu emblema
;;(desenha-trunfo OUROS)
(define (desenha-trunfo @trunfo)
  (overlay/xy ;;Sobrepõe deslocando em x,y (i)
       (text "Trunfo" 17 "navy") ;;Escreve o texto
       -25 -68 ;;Quantidade a ser deslocada (i)
       (overlay/align/offset ;;Sobrepõe a partir de uma origem com deslocamento (ii)
        "center" ;;Origem horizontal (ii)
        "bottom" ;;Origem vertical (ii)
        (desenha-naipe @trunfo) ;;Desenha o naipe de @trunfo
        0 35 ;;Deslocamento (ii)
        (overlay ;;Sobrepõe (iii)
         (radial-star 15 43 47 "solid" "white") ;;Estrela radial branca
         (radial-star 15 47 50 "solid" "navy"))))) ;;Estrela radial azul-naval

;; ----------------------
;; FUNÇÃO  desenha-carta-selecionada
;; ----------------------
;; desenha-carta-selecionada : Carta ->  Imagem
;; Dado uma carta desenha ela como a carta selecionada
;; com uma borda azul e o texto "Carta Selecionada"
;; Exemplos:
;;(desenha-carta-selecionada (make-carta REI PAUS))
(define (desenha-carta-selecionada @carta)
  (above ;;Coloca um acima do outro
   (overlay ;;Sobrepõe
    (desenha-carta @carta) ;;Desenha a carta
    (rectangle 60 90 "solid" "Dodger Blue")) ;;Desenha um retangulo aul
   (text "      Carta\nselecionada" 12 "Dodger Blue"))) ;;Escreve o texto
   
;; ----------------------
;; FUNÇÃO  desenha-status-partida
;; ----------------------
;; desenha-status-partida : String Booleano ->  Imagem
;; Dado o nome da dupla e um booleano, desenha o texto informando o status da partida
;; Exemplos:
;;(desenha-status-partida "Adriel e Rafael" #f)
(define (desenha-status-partida @nome @ganhou)
  (cond ;;Incío do bloco condicional
    
    [@ganhou ;;Se @ganhou é verdadeiro
     (text ;;Retorna uma imagem contendo do texto
      (string-append "A dupla '" @nome "': Ganhou!") ;;Junta strings
      18
      "Yellow Green")]
    [else ;;Caso contrário
     (text ;;Retorna uma imagem contendo do texto
      (string-append"A dupla '" @nome "': Perdeu :(") ;;Junta strings
      18
      "Firebrick")]))



;; ==============================================================
;; QUESTÃO BÔNUS: Questão 8 foi deslocada para cima pois precisa
;;                ser definida antes de seu uso em outras funções.
;; ==============================================================


;;Exibe informações úteis no console quando o programa é executado

"==========================="
"Adriel de Souza | 005***** | adriel.souza@inf.ufrgs.br"
"Fundamento de Algoritmos (INF05008) - Profa. Leila"
"LISTA 1"
"==========================="
"Dica: Use a constante BARALHO para ver todas as cartas da questão bônus"

