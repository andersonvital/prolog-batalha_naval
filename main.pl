
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

 alteraValorNoTabuleiro([H|T], 0, Coluna, NovoValor, [J|T]) :- substituir(H, Coluna, NovoValor, J).
 alteraValorNoTabuleiro([H|T], Linha, Coluna, NovoValor, [H|U]) :-
   Linha1 is Linha - 1, alteraValorNoTabuleiro(T, Linha1, Coluna, NovoValor, U).

encontraSimboloNaMatriz(Matriz, Linha, Coluna, Simbolo) :-
  nth0(Linha, Matriz, ListaDaPos),
  nth0(Coluna, ListaDaPos, Simbolo).

substituir([_|T], 0, X, [X|T]).
substituir([H|T], Index, NewElement, [H|U]) :-
  Index1 is Index - 1, substituir(T, Index1, NewElement, U).


/* EXIBIÇÃO */

/* Impressão da visão que o jogador tem do tabuleiro, omitindo navios */
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

/* Impressão do tabuleiro exibindo os navios inimigos */

imprimeTabuleiroReal(Tabuleiro) :-
  write('~°~°~°~°~  TABULEIRO REAL  ~°~°~°~°~'),nl,nl,
  write('   0   1   2   3   4   5   6   7   8'),nl,nl,
  imprimeLinhas(Tabuleiro, 0),
  write('Legenda:'),nl,
  write('~ = ÁGUA | n = NAVIO | @ = TIRO NA ÁGUA | x = TIRO EM NAVIO'), nl, nl.

imprimeLinhas([], _).
imprimeLinhas([H|T], Index) :-
  write(Index), write('  '), imprimeLinha(H), nl,nl,
  NewIndex is Index+1,
  imprimeLinhas(T, NewIndex).

imprimeLinha([]).
imprimeLinha([H|T]) :-
  write(H), write('   '),
  imprimeLinha(T).

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

ultimoMissel :-
  write('Resta apenas um míssel!'), nl, nl.

misseisEsgotados :-
  write('Seus mísseis acabaram!'), nl, nl.

gameOver :-
  write('---------------------------------------------------'), nl,
  write('Você não conseguiu afundar toda a frota inimiga :-( Game Over!'),
  write('---------------------------------------------------').

vitoria :-
  write('---------------------------------------------------'), nl,
  write('Você destruiu toda a frota inimiga e conseguiu vencer a Batalha Naval!! Parabéns, estrategista!'), nl,
  write('---------------------------------------------------').

/* Imprime uma mensagem na tela e lê um número da entrada */
prompt_number(Prompt, Number) :-
  write(Prompt),
  write(': '),
  read(Number).


/* Funções que verificam a existência de elementos em listas e matriz */

contem([X|_], X).
contem([_|T], X) :-
  contem(T, X).

existemNavios([H|_]) :- contem(H, n).
existemNavios([_|T]) :- existemNavios(T).


/* Execução da lógica sequencial do jogo */
jogar(Tabuleiro, Misseis, NovoTabuleiro, NovosMisseis) :-
  Misseis > 0,
  imprimeTabuleiroJogador(Tabuleiro),
  atirar(Tabuleiro, NovoTabuleiro), NovosMisseis is Misseis-1,
  (
  not( existemNavios(NovoTabuleiro) ) -> vitoria;
  (NovosMisseis > 1 -> misseis(NovosMisseis), jogar(NovoTabuleiro, NovosMisseis, _, _);
  NovosMisseis =:= 1 -> ultimoMissel, jogar(NovoTabuleiro, NovosMisseis, _, _);
  NovosMisseis =:= 0 -> misseisEsgotados, imprimeTabuleiroReal(NovoTabuleiro), gameOver)
  ).


/* Execução do programa */
:- initialization(main).
main :-
  jogar([[~,~,n,n,n,n,~,~,~],[~,~,n,n,~,~,~,~,~],[~,~,~,~,~,n,~,~,~],[~,~,~,~,~,n,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,n,~,~,~],[~,~,n,~,~,~,n,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,n]],
  40, _, _).
