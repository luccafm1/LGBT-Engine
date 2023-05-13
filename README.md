# Backrooms: Escape from Gabriel

Este repositório contém um mecanismo de jogo 3D básico estilo Backroooms. Criado com a biblioteca P3D, classes PShade e PVector na linguagem de programação Processing (Java), a 'engine' renderiza o jogador, paredes e inimigos, os quais podem se mover no espaço 3D. O usuário controla o jogador usando as teclas de seta ou WASD, e a câmera pode ser girada usando o mouse.

![Screenshot_1](https://github.com/luccafm1/LGBT-Engine/assets/45906809/d2259f06-8669-496b-9841-5165d89690ce)

## Bibliotecas/Classes
- P3D: Esta biblioteca fornece um motor de renderização 3D que permite a criação de gráficos 3D em Processing.
- PShade: Esta classe fornece uma interface simples para trabalhar com shaders em Processing.
- PVector: Esta biblioteca fornece um conjunto de funções vetoriais que facilitam o trabalho com gráficos 3D em Processing.

## Inicialização
A função setup() inicializa a janela do jogo e configura o jogador e os objetos inimigos. O jogador e o inimigo são representados por objetos PVector que armazenam sua posição no espaço 3D. O movimento do jogador é controlado pelas teclas de seta ou WASD, e a câmera é girada com base na posição do mouse.

A função draw() é chamada uma vez por quadro e é responsável por renderizar o jogo. Ele primeiro limpa a tela e configura a iluminação usando a função lights(). O inimigo é então renderizado usando a função inimigo(), que desenha uma forma 3D básica usando a função box(). Os blocos coloridos são desenhados usando a função bloco(), que também usa a função box() para desenhar formas 3D de tamanhos diferentes.

A função movimentoCamera() calcula a posição e a orientação da câmera com base na posição do jogador e na posição do mouse. Ele primeiro calcula os ângulos de rotação usando a função map() e então cria um PVector que representa a direção da câmera. As funções translate() e camera() são usadas para posicionar e orientar a câmera.

Essa engine fornece uma estrutura básica para a criação de jogos 3D em Processing usando as bibliotecas P3D, PShade e PVector. Ele permite a criação de objetos 3D, movimento do jogador e rotação da câmera, podendo ser usado como ponto de partida para jogos mais complexos.

![Screenshot_5](https://user-images.githubusercontent.com/45906809/235815387-fe450b5c-36b8-4774-999c-115f7ce624d4.png)
