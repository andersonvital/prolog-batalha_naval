
  tabuleiroInicial( [['~','~','~','~','~','~','~','~','~'], ['~','~','~','~','~','~','~','~','~'],
   ['~','~','~','~','~','~','~','~','~'],['~','~','~','~','~','~','~','~','~'],
   ['~','~','~','~','~','~','~','~','~'], ['~','~','~','~','~','~','~','~','~'],
   ['~','~','~','~','~','~','~','~','~'], ['~','~','~','~','~','~','~','~','~'],
   ['~','~','~','~','~','~','~','~','~']] ).

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

  
board([[0, 0, 0, 0, 0, 0, 0, 0, 0],
       [1, 1, 0, 0, 0, 0, 0, 0, 0],
       [0, 0, 0, 0, 0, 0, 0, 0, 0],
       [1, 1, 1, 1, 0, 0, 0, 0, 0],
       [0, 0, 0, 0, 0, 0, 0, 0, 1],
	   [1, 1, 1, 1, 0, 0, 0, 0, 0],
	   [1, 1, 1, 1, 0, 0, 0, 0, 0],
	   [1, 1, 1, 1, 0, 0, 0, 0, 0],
	   [1, 1, 1, 1, 0, 0, 0, 0, 0]]).

linhaAux(X, Row) :-
  board(Board),
  nth0(X, Board, Row).

colunaAux(Y, Row, Cell) :-
  nth0(Y, Row, Cell).

posNavio(X, Y) :-
  linhaAux(X, Row),
  colunaAux(Y, Row, Cell),
  Cell = 1.

acertar:-
    write('ACERTOU!'), nl.

miss :-
    write('ERROU!'), nl.

mira(X, Y, State) :-
  (posNavio(X, Y) ->
    acertar, atualizaTabuleiro(X,Y);
    miss).

/*funcao pra atualizar o novo tabuleiro
  */	
  
atualizaTabuleiro(TabuleiroVisto,TabuleiroComNavios PosX, PosY, NovoTabuleiroVisto).
	
prompt_number(Prompt, Number) :-
  write(Prompt),
  write(': '),
  read(Number).

:- initialization(main).
main :-
  
  repeat,
  tabuleiroInicial(TABULEIRO),
  imprimeTabuleiroReal(TABULEIRO),
  prompt_number('ENTRE COM O NUMERO DA COLUNA', Col),
  prompt_number('ENTRE COM O NUMERO DA LINHA', Row),
  mira(Row, Col, State),
  (posNavio(Row, Col) ->
    write('you won!'), nl, halt ;
    write('Continue Tentando!'), nl, fail).  
	
	