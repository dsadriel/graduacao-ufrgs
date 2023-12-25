;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname lista3-AdrielDeSouza-D) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
;;Nome: Adriel de Souza - 005*****
;;Fundamento de Algoritmos (INF05008) - Profa. Leila
;;Turma D - 2023/1
;;LISTA 3


;; ============================================
;; DEFINIÇÕES DE TIPOS DE DADOS
;; ============================================

;; ------------------
;; TIPO ARQUIVO:
;; ------------------
(define-struct arquivo (nome direitos)) 
;; Um elemento do conjunto Arquivo tem o formato
;;  (make-arquivo n d), onde
;;    n: String, é o nome do arquivo
;;    t: String,  representa os direitos de acesso do usuário sobre o arquivo,  pode ser "r" (read),"rw" (read/write) e/ou "rwx" (read/write/execute).

;; ------------------
;; TIPO CONTEUDO:
;; ------------------
;; Um Conteudo é
;; 1. empty,
;; 2. (cons a lc), onde a: Arquivo e lc: Conteudo
;; 3. (cons d lc), onde d: Diretorio e lc: Conteudo

;; ------------------
;; TIPO DIRETORIO:
;; ------------------
(define-struct diretorio (nome direitos conteudo))
;; Um elemento do conjunto Diretorio tem o formato
;;  (make-diretorio n d c), onde
;;    n: String, é o nome do diretório
;;    d: String, representa os direitos de acesso do usuário sobre o diretório,  pode ser "r" (read),"rw" (read/write) e/ou "rwx" (read/write/execute).
;;    c: Conteudo, é o conteúdo do diretório

;; ============================================
;;                  CONSTANTES
;; ============================================

(define LISTAS
  (make-diretorio "Listas" "rwx"
                  (list
                   (make-arquivo "gera-testes.sh" "rwx")
                   (make-arquivo "lista1.rkt" "rw")
                   (make-arquivo "lista2.rkt" "rw")
                   (make-arquivo "lista3.rkt" "rw")
                   (make-arquivo "lista4.rkt" "rw"))))

(define VIDEOAULAS
  (make-diretorio "Videoaulas" "r"
                  (list
                   (make-arquivo "aula1.mp4" "r")
                   (make-arquivo "aula2.mp4" "r")
                   (make-arquivo "aula3.mp4" "r"))))

(define AULAS
  (make-diretorio "Aulas" "r"
                  (list
                   VIDEOAULAS
                   (make-arquivo "texto1.pdf" "r"))))


(define INF05008 (make-diretorio "INF05008" "rwx"
                                 (list
                                  (make-arquivo "plano-de-ensino.tex" "rw")
                                  (make-arquivo "cronograma.xls" "rw")
                                  AULAS
                                  LISTAS
                                  (make-arquivo "texto1.pdf" "rw"))))

(define DESKTOP (make-diretorio "Desktop" "rwx"
                                (list
                                 (make-arquivo "lista3-2023-1-template.rkt" "rwx")
                                 (make-arquivo "Google Chrome.lnk" "r")
                                 (make-arquivo "Anotações.docx" "rwx"))))


;; =========================================================================
;;                                 QUESTÃO 1
;; =========================================================================

;; ------------------
;; FUNÇÃO: arquivo-encontrado?
;; ------------------
;; arquivo-encontrado? : Conteudo String -> Booleano
;; Dados o conteúdo de um diretório e um nome de arquivo, verifica se existe um arquivo com este nome
;; neste conteúdo considerando subdiretórios.

;; Exemplos/testes:
(check-expect (arquivo-encontrado? (diretorio-conteudo INF05008) "texto1.pdf") #t)
(check-expect (arquivo-encontrado? (diretorio-conteudo LISTAS) "texto1.pdf") #f)
(check-expect (arquivo-encontrado? (diretorio-conteudo INF05008) "notas-finais.pdf") #f)
(check-expect (arquivo-encontrado? (list (make-arquivo "notas-finais.pdf" "r") INF05008) "notas-finais.pdf") #t)


(define (arquivo-encontrado? @lista @nome)
  (cond
    ;;Se a lista estiver vazia, devolve falso
    [(empty? @lista) #f]
    [else ;; Caso contrário
     
     (or ;; OU (i) o arquivo exsite no primeiro elemento da lista
      
      (cond
        ;;Se o primeiro elemento da lita for um diretório
        [(diretorio? (first @lista))
         ;;Então devolve se o arquivo pode ser encontrado dentro do diretório
         (arquivo-encontrado? (diretorio-conteudo (first @lista)) @nome)]
        
        ;;Caso contrário, o primeiro elemento é um, devolve verdadeiro se o arquivo tem nome igual ao buscado
        [else
         (string=? (arquivo-nome (first @lista)) @nome)])

      ;; OU (ii) o arquivo existe no resto da lista
        (arquivo-encontrado? (rest @lista) @nome))]))


;; =========================================================================
;;                                 QUESTÃO 2
;; =========================================================================


;; ------------------
;; FUNÇÃO: mostra-diretorio
;; ------------------
;; mostra-diretorio : Diretorio -> Imagem
;; Dado um diretório, desenha uma imagem da estrutura deste diretório, apresentando sua estrutura
;; hierárquica, incluindo sub-diretórios e arquivos

;; Exemplos:
;; (mostra-diretorio INF05008)
;; (mostra-diretorio DESKTOP)

(define (mostra-diretorio @dir)
  (overlay/align/offset "left" "top" ;;Sobrepõe alinhado pelo canto superior esquerdo
                        (text ;; Escreve o nome do diretorio a os direitos dele
                         (string-append "📁 "(diretorio-nome @dir) " ("  (diretorio-direitos @dir) ")")
                         15 "Saddle Brown")
                        30 15 ;;Deslocado em 30 e 15 pixels

                        ;;A imagem do conteudo do diretiorio
                        (mostra-conteudo (diretorio-conteudo @dir))))



;; ------------------
;; FUNÇÃO: mostra-conteudo
;; ------------------
;; mostra-conteudo : Conteudo -> Imagem
;; Dado um Conteudo de um diretorio, desenha uma imagem da estrutura deste Conteudo apresentando a
;; estrutura hierárquica, incluindo possíveis sub-diretórios

;; Exemplos:
;; (mostra-conteudo (diretorio-conteudo INF05008)) 
;; (mostra-conteudo (diretorio-conteudo DESKTOP))

(define (mostra-conteudo @lista)
  (cond
    ;;Se a lista estiver vazia, devolve uma imagem vazia
    [(empty? @lista) empty-image]
    [else ;; Caso contrário
     (above/align ;; Desenha uma acima do outro, alinhado pela esquerda
      "left"

      (cond
        ;;Se o primeiro elemento da lita for um diretório
        [(diretorio? (first @lista))
         ;;A imagem do diretorio
         (mostra-diretorio (first @lista))]
        
        ;;Caso contrário, devolve uma imagem do modelo arquivo do primeiro elemento do conteudo
        [else
          (text ;;O texto do nome do arquivo e dos direitos
           (string-append "📄 "  (arquivo-nome (first @lista)) " ("  (arquivo-direitos (first @lista)) ")")
           15 "Navy")])

      ;; A imagem do resto do conteúdo 
      (mostra-conteudo (rest @lista)))]))


;; =========================================================================
;;                                 QUESTÃO 3
;; =========================================================================

;; ------------------
;; FUNÇÃO: profundidade
;; ------------------
;; profundidade: Diretorio -> Número
;; Dado um diretório, devolve a profundidade dele.

;; Exemplos/testes:
(check-expect (profundidade INF05008) 3)
(check-expect (profundidade VIDEOAULAS) 1)
(check-expect (profundidade DESKTOP) 1)

(define (profundidade @dir)
  (cond
    ;;So o conteúdo do diretorio possuir outro(s) diretório(s), devolve a profundidade do conteúdo
    [(contem-diretorio? (diretorio-conteudo @dir))
      (profundidade-conteudo (diretorio-conteudo @dir))]
    
    ;;Caso contrário, devolve 1
    [else 1]))


;; ------------------
;; FUNÇÃO: contem-diretorio?
;; ------------------
;; contem-diretorio? Conteudo -> Booelano
;; Dado um Conteúdo, devolve verdadeiro caso possua diretório(s) e falso caso contrário

;; Exemplos/testes:
(check-expect (contem-diretorio?  (diretorio-conteudo INF05008)) #t)
(check-expect (contem-diretorio?  (diretorio-conteudo DESKTOP)) #f)


(define (contem-diretorio? @lista)
  (cond
    ;;Se o conteudo estiver vazio, devolve falso
    [(empty? @lista) #f]
    
    ;;Se o primeiro item da conteudo for um diretório, devolve verdadeiro
    [(diretorio? (first @lista)) #t]
    
    ;;Caso contrário, verifica so resto da lista comtem diretórios
    [else
     (contem-diretorio? (rest @lista))]))


;; ------------------
;; FUNÇÃO: profundidade-conteudo
;; ------------------
;; profundidade-conteudo: Conteudo -> Número
;; Dado um Conteúdo de um diretório, devolve a profundidade dele.

;; Exemplos/testes:
(check-expect (profundidade-conteudo (diretorio-conteudo LISTAS)) 1)
(check-expect (profundidade-conteudo (diretorio-conteudo AULAS)) 2)


(define (profundidade-conteudo @lista)
  (cond
    ;;Se a lista estiver vazio, devolve 1
    [(empty? @lista) 1]

    ;;Se o primeiro elemento da lista for um diretório
    [(diretorio? (first @lista))
     (+ 1 ;; Soma 1
     (max ;; Ao máximo entre
      (profundidade (first @lista)) ;; A profundidade do diretório, representado pelo primeiro elemento da lista e
      (profundidade-conteudo (rest @lista))))] ;; A profundidade do resto da lista

    [else ;; OU devolve a profundidade do resto da lista
      (profundidade-conteudo (rest @lista))]))


;; =========================================================================
;;                                 QUESTÃO 4
;; =========================================================================

;; ------------------
;; TIPO DiretorioOUString:
;; ------------------
;; Um DiretorioOUString pde ser
;; 1. Diretorio, ou
;; 2. String.

;; ------------------
;; FUNÇÃO: insere-arquivo
;; ------------------
;; insere-arquivo: Diretorio Arquivo ->  DiretorioOUString
;; Dado um diretório e um arquivo, se o usuário tiver permissão, insere este arquivo neste diretório.
;; Caso exista arquivo com nome conflitante, substitui esse arquivo.

;; Exemplos/testes:
(check-expect (insere-arquivo VIDEOAULAS (make-arquivo "aula-extra.mp4" "r")) "Usuário sem permissão para escrever no diretório")
(check-expect (insere-arquivo DESKTOP (make-arquivo "funções-racket.pdf" "rw"))(make-diretorio "Desktop" "rwx" (list  (make-arquivo "funções-racket.pdf" "rw") (make-arquivo "lista3-2023-1-template.rkt" "rwx") (make-arquivo "Google Chrome.lnk" "r") (make-arquivo "Anotações.docx" "rwx"))))


(define (insere-arquivo @dir @arq)
  (cond
    ;;Se o usuário tiver somente permissão de leitura, retorna uma string informando o erro
    [(string=? (diretorio-direitos @dir) "r")
      "Usuário sem permissão para escrever no diretório"]

    ;;Se já existir um arquivo com o mesmo nome que o arquivo a ser inserido
    [(arquivo-encontrado? (diretorio-conteudo @dir) (arquivo-nome @arq))
     
     (make-diretorio ;;Constroi um diretório com
      (diretorio-nome @dir) ;; Nome inalterado
      (diretorio-direitos @dir) ;;Direitos inalterados
      
      (cons ;; Constroi um novo Conteúdo com:
       @arq ;; O arquivo a ser inserido e
       ;;O conteúdo do diretório com o arquivo de mesmo nome removido
       (remove-arquivo (diretorio-conteudo @dir) (arquivo-nome @arq))))]


    ;;Caso contrário, devolve o diretorio com o arquivo inserido
    [else
     (make-diretorio ;;Constroi um diretório com
      (diretorio-nome @dir) ;; Nome inalterado
      (diretorio-direitos @dir) ;;Direitos inalterados

      (cons ;; Constroi um novo Conteudo com:
       @arq ;; O arquivo a ser inserido
       (diretorio-conteudo @dir)))]))  ;;e o Conteudo já existente;


;; ------------------
;; FUNÇÃO: remove-arquivo
;; ------------------
;; insere-arquivo: Conteudo String ->  Conteudo
;; Dado um Conteúdo e um nome da arquivo, remove o arquivo com o nome infornado (se existir) e devolve
;; o conteúdo.

;; Exemplos/testes:
(check-expect (remove-arquivo (diretorio-conteudo LISTAS) "lista4.rkt") (list (make-arquivo "gera-testes.sh" "rwx") (make-arquivo "lista1.rkt" "rw") (make-arquivo "lista2.rkt" "rw") (make-arquivo "lista3.rkt" "rw")))
(check-expect (remove-arquivo (diretorio-conteudo DESKTOP)"Anotações.docx") (list (make-arquivo "lista3-2023-1-template.rkt" "rwx") (make-arquivo "Google Chrome.lnk" "r")))

(define (remove-arquivo @lista @nome)
  (cond
    ;;Se a lista estiver vazia, devolve uma lista vazia
    [(empty? @lista) empty]

    ;;Se o primeiro item da lista for um arquivo E seu nome for igual ao buscado
    [(and
      (arquivo?  (first @lista))
      (string=? (arquivo-nome (first @lista)) @nome))
     ;;Devolve o resto da lista
     (rest @lista)]

    ;;Caso contrário, constroi um novo Conteudo
    [else
     (cons
      (first @lista) ;;Com o primeiro elemento da lista
      (remove-arquivo (rest @lista) @nome))])) ;;E o resto da lista com o arquivo removido
    



;; =========================================================================
;;                                 QUESTÃO 5
;; =========================================================================


;; ------------------
;; FUNÇÃO: mostra-caminho
;; ------------------
;; mostra-caminho: Arquivo Diretorio ->  String
;; Dado um nome de arquivo e um diretório, mostra o caminho para encontrar
;; esse arquivo, ou uma mensagem dizendo que o arquivo não existe nesse diretório.

;; Exemplos/testes:
(check-expect (mostra-caminho "aula2.mp4" INF05008) "INF05008 -> Aulas -> Videoaulas -> aula2.mp4")
(check-expect(mostra-caminho "lista4.rkt" LISTAS) "Listas -> lista4.rkt")
(check-expect (mostra-caminho "aulax.mp4" INF05008) "Arquivo não encontrado")


(define (mostra-caminho @nome @dir)
  (cond
    ;;Se o arquivo não existir no diretório, devolve uma String informando que o arquivo não foi encontrado
    [(not (arquivo-encontrado? (diretorio-conteudo @dir) @nome))
     "Arquivo não encontrado"]

    ;;Caso contrário, então o arquivo existe
    [else
     (string-append ;; Junta as Strings
      (diretorio-nome @dir) ;; Nome do diretório atual,
      " -> " ;; Indicador de direção e
      ;;o caminho para o arquivo com base no conteudo do diretório
      (mostra-caminho-conteudo (diretorio-conteudo @dir) @nome))])) 


;; ------------------
;; FUNÇÃO: mostra-caminho-conteudo
;; ------------------
;; mostra-caminho: Arquivo Conteudo ->  String
;; Dado um nome de arquivo e um conteudo, mostra o caminho para encontrar
;; esse arquivo. Se o arquivo não existir, devolve uma String vazia

;; Exemplos/testes:
(check-expect (mostra-caminho-conteudo (diretorio-conteudo INF05008) "aula2.mp4" ) "Aulas -> Videoaulas -> aula2.mp4")
(check-expect (mostra-caminho-conteudo (diretorio-conteudo LISTAS) "lista4.rkt" ) "lista4.rkt")
(check-expect (mostra-caminho-conteudo  (diretorio-conteudo INF05008) "aulax.mp4") "")


(define (mostra-caminho-conteudo @lista @nome)
  (cond
    
    ;;Se a lista estiver vazia, devolve uma string vazia
    [(empty? @lista) ""]

    ;;Se primeiro item da lista for um arquivo E seu nome for igual ao buscado
    [(and
      (arquivo?  (first @lista))
      (string=? (arquivo-nome (first @lista)) @nome))
     ;;Devolve o nome do arquivo
     @nome]

    ;;Se o primeiro item da lista for um diretorio E o arquivo pode ser encontrado dentro desse diretório
    [(and
      (diretorio? (first @lista))
      (arquivo-encontrado? (diretorio-conteudo (first @lista)) @nome))
     ;;Devolve o caminho do arquivo dentro do primeiro item da lista
     (mostra-caminho @nome (first @lista))]

    ;;Caso contrário, mostra o caminho para o arquivo no resto da lista
    [else
     (mostra-caminho-conteudo (rest @lista) @nome)]))