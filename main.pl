
criaTabuleiro( ['~','~','~','~','~','~','~','~','~'], ['~','~','~','~','~','~','~','~','~'],
 ['~','~','~','~','~','~','~','~','~'],['~','~','~','~','~','~','~','~','~'],
 ['~','~','~','~','~','~','~','~','~'], ['~','~','~','~','~','~','~','~','~'],
 ['~','~','~','~','~','~','~','~','~'], ['~','~','~','~','~','~','~','~','~']
 ['~','~','~','~','~','~','~','~','~'] ).


alteraTabuleiro(Tabuleiro, Linha, Posicao, Caractere, NovoTabuleiro) {

}

imprimeLinha(Index, [P1,P2,P3,P4,P5,P6,P7,P8,P9]):-

  print(Index),
  print('  '),print(P1),
  print('  '),print(P2),
  print('  '),print(P3),
  print('  '),print(P4),
  print('  '),print(P5),
  print('  '),print(P6),
  print('  '),print(P7),
  print('  '),print(P8),
  print('  '),print(P9).

imprimeTabuleiro([L1,L2,L3,L4,L5,L6,L7,L8,L9]) :-
print('~°~°  TABULEIRO  °~°~'),nl,
print('#  1  2  3  4  5  6  7  8  9')
imprimeLinha(1, L1),nl,
imprimeLinha(2, L2),nl,
imprimeLinha(3, L3),nl,
imprimeLinha(4, L4),nl,
imprimeLinha(5, L5),nl,
imprimeLinha(6, L6),nl,
imprimeLinha(7, L7),nl,
imprimeLinha(8, L8),nl,
imprimeLinha(9, L9).
