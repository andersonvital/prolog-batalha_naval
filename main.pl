
/* Regras para realizar tiros, manipulando o tabuleiro */

atirar(Tabuleiro, NovoTabuleiro) :-
  selecione,
  prompt_number('Linha', Linha),
  prompt_number('Coluna', Coluna),nl,
 encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo),
 (
 (Simbolo == ~) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, @, NovoTabuleiro), errou, nl;
 (Simbolo == n) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, x, NovoTabuleiro), acertou, nl;
 (Simbolo == @) -> invalido, atirar(Tabuleiro, _);
 (Simbolo == x) -> invalido, atirar(Tabuleiro, _)
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
  write('~°~°~°~°~  TABULEIRO REAL ~°~°~°~°~'),nl,nl,
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
  write('~°~°~°~°~°~° TABULEIRO ~°~°~°~°~°~°~'),nl,nl,
  write('   0   1   2   3   4   5   6   7   8'),nl,nl,
  imprimeMatrizJogador(Tabuleiro, 0),
  write('Legenda:'),nl,
  write('~ = ÁGUA | @ = TIRO NA ÁGUA | x = TIRO EM NAVIO'), nl, nl.

imprimeMatrizJogador([], _).
imprimeMatrizJogador([H|T], Index) :-
    write(Index), write('  '), imprimeLinhaJogador(H), nl,nl,
    NewIndex is Index+1,
    imprimeMatrizJogador(T, NewIndex).

imprimeLinhaJogador([]).
imprimeLinhaJogador([H|T]) :-
  (H == '~', write('~');
  H == n, write('~');
  H == @, write('@');
  H == x, write('x')), write('   '),
  imprimeLinhaJogador(T).

/* Impressões simples */

acertou :-
  write('ACERTOU!'), nl.

errou :-
  write('ERROU!'), nl.

invalido :-
  write('Você já atirou aqui! Atire em outro lugar.'), nl.

selecione :-
  write('Selecione as coordenadas de onde deseja atirar!'), nl.

misseis(Qtd) :-
  write('Você ainda tem '), write(Qtd), write(' mísseis.'), nl, nl.

/* Imprime uma mensagem na tela e lê um número da entrada */
prompt_number(Prompt, Number) :-
  write(Prompt),
  write(': '),
  read(Number).


/* Execução da lógica sequencial do jogo */
jogar(Tabuleiro, Misseis, NovoTabuleiro, NovosMisseis) :-
  Misseis > 0,
  imprimeTabuleiroJogador(Tabuleiro),
  atirar(Tabuleiro, NovoTabuleiro), NovosMisseis is Misseis-1,
  misseis(NovosMisseis),
  jogar(NovoTabuleiro, NovosMisseis, _, _).


:- initialization(main).
main :-
  jogar([[~,~,n,n,n,n,~,~,~],[~,~,n,n,~,~,~,~,~],[~,~,~,~,~,n,~,~,~],[~,~,~,~,~,n,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,n,~,~,~],[~,~,n,~,~,~,n,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,n]], 40, _, _).

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
