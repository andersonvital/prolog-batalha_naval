
  tabuleiroInicial( ['~','~','~','~','~','~','~','~','~'], ['~','~','~','~','~','~','~','~','~'],
   ['~','~','~','~','~','~','~','~','~'],['~','~','~','~','~','~','~','~','~'],
   ['~','~','~','~','~','~','~','~','~'], ['~','~','~','~','~','~','~','~','~'],
   ['~','~','~','~','~','~','~','~','~'], ['~','~','~','~','~','~','~','~','~'],
   ['~','~','~','~','~','~','~','~','~'] ).

tiro(Tabuleiro, Linha, Coluna, NovoTabuleiro) :-
  encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo).
  /*(Simbolo =:= '~' -> alteraValor(Tabuleiro, Linha, Coluna, '#', NovoTabuleiro);
   Simbolo =:= 'N' -> alteraValor(Tabuleiro, Linha, Coluna, 'X', NovoTabuleiro);
   Simbolo =:= '#' -> print("Você já atirou nessa posição!");
   Simbolo =:= 'X' -> print "Você já atirou nessa posição!" ).*/

encontraSimboloNaMatriz(Matriz, Linha, Coluna, Simbolo) :-
  nth1(Linha, Matriz, ListaDaPos),
  nth1(Coluna, ListaDaPos, Simbolo).

/*alteraValor(Tabuleiro, Linha, Coluna, NovoValor, NovoTabuleiro) :-
  */

imprimeTabuleiroReal(MatrizTabuleiro) :-
  print('~°~°  TABULEIRO REAL °~°~'),nl,
  print('   1   2   3   4   5   6   7   8   9'),nl,
  imprimeLinhas(MatrizTabuleiro, 1).

imprimeLinhas([], _).
imprimeLinhas([H|T], Index) :-
  print(Index), print(' '), imprimeLinha(H), nl,nl,
  NewIndex is Index+1,
  imprimeLinhas(T, NewIndex).

imprimeLinha([]).
imprimeLinha([H|T]) :-
  print(H), print(' '),
  imprimeLinha(T).
