# Trabalho Neander 
INF01107 – Introdução à Arquitetura de Computadores – 2023/1

```plaintext
P = A×B

P ← 0
CONT ← B
se (CONT = 0)
{ pula: $FIM_MULT
CONT ← CONT + (-1)
P ← P + A
pula: $CONT_MULT 

	00  20 87   LDA 87
	02  10 83   STA 83
	04  20 81   LDA 81
	06  10 8A   STA 8A
	08  20 8A   LDA 8A    $CONT_MULT 
	0A  A0 18   JZ  18
	0C  30 88   ADD 88
	0E  10 8A   STA 8A
	10  20 83   LDA 83
	12  30 80   ADD 80
	14  10 83   STA 83
	16  80 08   JMP 08
	18  00      NOP       $FIM_MULT

============================================

Q = P/C, se C != 0. Q = 1, caso contrário.

Q ← 00h
AUX ← P
se (C = 0)
	{pula $DIV_0
C_NEG ← NOT(C)+1
AUX ← AUX + (C_NEG)
se (AUX < 0)
	{pula $FIM_DIV
Q ← Q + 01h
pula: $CONT_DIV
Q ← 01h

	19  20 87   LDA 87
	1B  10 84   STA 84
	1D  20 83   LDA 83
	1F  10 8A   STA 8A
	21  20 82   LDA 82
	23  A0 3E   JZ  3E
	25  60      NOT
	26  30 89   ADD 89
	28  10 8B   STA 8B
	2A  20 8A   LDA 8A        $CONT_DIV
	2C  30 8B   ADD 8B
	2E  10 8A   STA 8A
	30  90 42   JN  42
	32  20 84   LDA 84
	34  30 89   ADD 89
	36  10 84   STA 84
	38  20 8A   LDA 8A
	3A  A0 42   JZ  42
	3C  80 2A   JMP 2A
	3E  20 89   LDA 89       $DIV_0
	40  10 84   STA 84
	42  00      NOP          $FIM_DIV
	
============================================

X = -3Q


X ← Q
X ← X + Q
X ← X + Q
X ← NOT X
X ← X + 1

	43  20 84   LDA 84
	45  30 84   ADD 84
	47  30 84   ADD 84
	49  60      NOT
	4A  30 89   ADD 89
	4C  10 85   STA 85
	4E  00      NOP
	
============================================
Y = (a7, 1, !b5, 0, !a3, b2, 1, 0)

Y ← A AND MASK1
Y ← Y OR (B AND MASK2)

Y ← Y XOR MASK3 

*Para a execução do XOR foi realizado as seguintes operações:
AUX ← Y OR MASK1
Y  ←  AUX AND NOT(Y AND MASK3)

	4F  20 80   LDA 80
	51  50 8C   AND 8C
	53  10 86   STA 86
	55  20 81   LDA 81
	57  50 8D   AND 8D
	59  40 86   OR  86
	5B  10 86   STA 86
	5D  40 8E   OR  8E
	5F  10 8A   STA 8A
	61  20 86   LDA 86
	63  50 8E   AND 8E
	65  60      NOT
	66  50 8A   AND 8A
	68  10 86   STA 86
	6A  00      NOP
	6B  F0      HLT


ENDEREÇOS E DADOS DE MEMÓRIA:
	80  0C     
	81  0A     
	82  11     
	83  78     
	84  07     
	85  EB     
	86  62     
	87  00     
	88  FF     
	89  01     
	8A  6A     
	8B  EF     
	8C  88     
	8D  24     
	8E  6A     
```
Porto Alegre, 17 julho de 2023