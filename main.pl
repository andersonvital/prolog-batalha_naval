
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

inserirBattleShip(Tabuleiro, NovoTabuleiro):-
    random(0,6,Linha),random(0,6,Coluna),random(0,2,Orientacao),
    encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo),Coluna2 is Coluna+1,Coluna3 is Coluna+2,Coluna4 is Coluna+3, Linha2 is Linha+1,Linha3 is Linha+2,Linha4 is Linha+3,
 (
 (Orientacao == 0) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, n, Tabuleiro2),alteraValorNoTabuleiro(Tabuleiro2, Linha, Coluna2, n, Tabuleiro3),alteraValorNoTabuleiro(Tabuleiro3, Linha, Coluna3, n, Tabuleiro4),alteraValorNoTabuleiro(Tabuleiro4, Linha, Coluna4, n, NovoTabuleiro);
 (Orientacao == 1) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, n, Tabuleiro2),alteraValorNoTabuleiro(Tabuleiro2, Linha2, Coluna, n, Tabuleiro3),alteraValorNoTabuleiro(Tabuleiro3, Linha3, Coluna, n, Tabuleiro4),alteraValorNoTabuleiro(Tabuleiro4, Linha4, Coluna, n, NovoTabuleiro)
 
 ).

inserirCruiser(Tabuleiro, NovoTabuleiro):-
    random(0,8,Linha),random(0,8,Coluna),random(0,2,Orientacao),
    encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo),Coluna2 is Coluna+1, Linha2 is Linha+1, encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna2, Simbolo2),encontraSimboloNaMatriz(Tabuleiro, Linha2, Coluna, Simbolo3),
 (
 (Simbolo == ~), (Simbolo2 == ~), (Orientacao == 0) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, n, Tabuleiro2),alteraValorNoTabuleiro(Tabuleiro2, Linha, Coluna2, n, NovoTabuleiro);
 (Simbolo == ~), (Simbolo3 == ~), (Orientacao == 1) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, n, Tabuleiro2),alteraValorNoTabuleiro(Tabuleiro2, Linha2, Coluna, n, NovoTabuleiro);
 (Orientacao == 0),((Simbolo == n);(Simbolo2 == n))-> inserirCruiser(Tabuleiro, NovoTabuleiro);
 (Orientacao == 1),((Simbolo == n);(Simbolo3 == n))-> inserirCruiser(Tabuleiro, NovoTabuleiro)
 
 ).

inserirMinesweeper(Tabuleiro, NovoTabuleiro):-random(0,9,Linha),random(0,9,Coluna),
    encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo),
 (
 (Simbolo == ~) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, n, NovoTabuleiro);
 (Simbolo == n) -> inserirMinesweeper(Tabuleiro, NovoTabuleiro)
 ).
	
	
gerarTabuleiro([[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~]]).

inserirNavios(Tabuleiro, NovoTabuleiro):-
    inserirBattleShip(Tabuleiro, Tabuleiro2),
	inserirCruiser(Tabuleiro2, Tabuleiro3),
	inserirCruiser(Tabuleiro3, Tabuleiro4),
	inserirMinesweeper(Tabuleiro4, Tabuleiro5), 
	inserirMinesweeper(Tabuleiro5, Tabuleiro6),
	inserirMinesweeper(Tabuleiro6, Tabuleiro7),
	inserirMinesweeper(Tabuleiro7, NovoTabuleiro).
	

/* Execução do programa */
:- initialization(main).
main :-
  gerarTabuleiro(TabuleiroRamdomicoAux),inserirNavios(TabuleiroRamdomicoAux, TabuleiroRamdomico),jogar(TabuleiroRamdomico,
  40, _, _).
