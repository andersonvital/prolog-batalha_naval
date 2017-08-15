Projeto de implementação do jogo Batalha Naval utilizando a linguagem Prolog.

O jogador tem como objetivo destruir todos os navios presentes no tabuleiro com um
número finito de torpedos. O jogador recebe um tabuleiro que esconde 7 navios inimigos.
Sem saber a distribuição dos navios, o jogador tem que realizar tiros nos pontos (x,y) do
tabuleiro a fim de afundar os navios do adversário. Para afundar um navio, é necessário
acertar tiros em todos os pontos em que ele está presente (os navios têm tamanho
variados). Porém, não é informado para o jogador quando um navio foi totalmente
destruído, cabe ao mesmo verificar isso realizando tiros nos extremos de onde ele acreditar
estar posicionado o navio. O jogador vence caso o consiga destruir todos os navios antes
do fim da sua munição.

Existem 3 tipos de navios: Battleship (4 casas)- 1 unidade; Cruiser (2 casas) - 2 unidades; 
e MineSweeper(1 casa) - 4 unidades. A distribuição desses navios é feita de forma aleatória.

© Copyright 2017 Anderson Dalbert, Lucas Salvino.
Distribuído sobre os termos da Licença Pública Geral GNU.   

                                                                                                   
                                (@&#*,.,/%@                                                        
                            ,*             &                                                       
                             %             %,                                                      
                             %.             @                                                      
                              @             &*                                                     
                      *#%%%   #,#@@@%/,..,,*(@               .,/#%&@@#                             
                    ./     %   @             @,(&@@@@&%(,   .,* .%&& %/                            
                     #.    (,  ,#            *&      &. #  @  &  */@  @                            
                      @%*   @   &.            @      *&%&  .          @,     .*#&@%/. /.           
                       @     @   @            .&                  ,(&@@@&#*.          @/           
           (&.         *(    .@  %.            %.   ,/%@@@@@@&(,.                     @*           
          ,.(&          %.     &  %.*(%@@@@@@@&#*.                                   (@            
           .#@#%&@@@@@@@@@&#(*,                                         /  ..        @@            
     .(     (&* /.                                        %   #        ,    #       /@/            
      @. /,* (&./(                .#/         .  *        *   /          .,         @@             
      /@  %/&*, ,# .@%@          %    .      (    *         ,                      &@.             
       @@   .     ..   *         .,  %         ..                                 *@%              
        @@         &. *#                                                    ./%@&/@@               
         @@                                                .*(#&&&&#/,           @@                
          @@                         .,*(#%&@@@&%#/,.                          ,@#                 
           @@%&&&&&%%#(*,,.                                                   #@@@@%(/**/(%&@@@@@%,
            %@/                                                              @.                    
              @@                                                           %                       
           ,#@@&/@.                      ,(&@@@@@@@@@@@@@@@@%/,.    .*#@%        .,*(%@@,          
    *&@@@#.        .@(/@@@@@@@@@,/&@@@&/,                   ,/#&@@@@@@@@@@@@@@@@@@%/                
                                                                      
                                            
                                                            
                                                                                                   
                                                                                                   
