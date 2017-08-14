
/* Regras para realizar tiros, manipulando o tabuleiro */
atirar(Tabuleiro, Linha, Coluna, NovoTabuleiro) :-
 encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo),
 (
 (Simbolo == ~) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, 'e', NovoTabuleiro);
 (Simbolo == n) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, x, NovoTabuleiro);
 (Simbolo == e) -> print("Você já atirou nessa posição anteriormente! Atire em outro lugar.");
 (Simbolo == x) -> print("Você já atirou nessa posição anteriormente! Atire em outro lugar.")
 ).

encontraSimboloNaMatriz(Matriz, Linha, Coluna, Simbolo) :-
  nth0(Linha, Matriz, ListaDaPos),
  nth0(Coluna, ListaDaPos, Simbolo).

substituir([_|T], 0, X, [X|T]).
substituir([H|T], Index, NewElement, [H|U]) :-
  Index1 is Index - 1, substituir(T, Index1, NewElement, U).

alteraValorNoTabuleiro([H|T], 0, Coluna, NovoValor, [J|T]) :- substituir(H, Coluna, NovoValor, J).
alteraValorNoTabuleiro([H|T], Linha, Coluna, NovoValor, [H|U]) :-
  Linha1 is Linha - 1, alteraValorNoTabuleiro(T, Linha1, Coluna, NovoValor, U).

/* EXIBIÇÃO */

/* Impressão do tabuleiro exibindo os navios inimigos */

imprimeTabuleiroReal(Tabuleiro) :-
  write('~°~°  TABULEIRO REAL °~°~'),nl,nl,
  write('   0   1   2   3   4   5   6   7   8'),nl,nl,
  imprimeLinhas(Tabuleiro, 0).

imprimeLinhas([], _).
imprimeLinhas([H|T], Index) :-
  write(Index), write('  '), imprimeLinha(H), nl,nl,
  NewIndex is Index+1,
  imprimeLinhas(T, NewIndex).

imprimeLinha([]).
imprimeLinha([H|T]) :-
  write(H), write('   '),
  imprimeLinha(T).

  /* Impressão da exibição que o jogador tem do tabuleiro, omitindo navios */
imprimeTabuleiroJogador(Tabuleiro) :-
  write('   0   1   2   3   4   5   6   7   8'),nl,nl,
  imprimeMatrizJogador(Tabuleiro, 0).

imprimeMatrizJogador([], _).
imprimeMatrizJogador([H|T], Index) :-
    write(Index), write('   '), imprimeLinhaJogador(H), nl,nl,
    NewIndex is Index+1,
    imprimeMatrizJogador(T, NewIndex).

imprimeLinhaJogador([]).
imprimeLinhaJogador([H|T]) :-
  (H == '~', write('~');
  H == n, write('~');
  H == e, write('@');
  H == x, write('x')),
  imprimeLinhaJogador(T).

/* - - - - - - - - - - - - - - - - - - - - - - -  */

acertar:-
    write('ACERTOU!'), nl.

miss :-
    write('ERROU!'), nl.

/*mira(X, Y, State) :-
  (posNavio(X, Y) ->
    acertar, atualizaTabuleiro(X,Y);
    miss). */

prompt_number(Prompt, Number) :-
  write(Prompt),
  write(': '),
  read(Number).

/*:- initialization(main).
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
*/
