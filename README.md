# Backrooms: Escape from the Nerdolas

Este repositório contém um mecanismo de jogo 3D básico estilo Backroooms, criado na plataforma Processing.

O jogo é estilo sobrevivência; o objetivo é sobreviver aos inimigos, que seguem o player.

![Screenshot_1](https://github.com/luccafm1/LGBT-Engine/assets/45906809/d2259f06-8669-496b-9841-5165d89690ce)

## Bibliotecas/Classes
- P3D: Esta biblioteca (Primitive 3D) fornece um motor de renderização 3D, que nos permite a criação de gráficos 3D em Processing;
- PShade: Esta biblioteca fornece uma interface simples para trabalhar com shaders em Processing;
- PVector: Esta biblioteca fornece um conjunto de funções vetoriais que facilitam o trabalho com posicionamentos 3D em Processing;
- Minim: Esta biblioteca fornece recursos para importação e manipulação de áudio no jogo; 

## Inicialização do jogo
A função setup() inicializa a janela do jogo e configura o jogador e os objetos inimigos. O jogador e o inimigo são representados por objetos PVector que armazenam sua posição no espaço 3D. O movimento do jogador é controlado pelas teclas de seta ou WASD, e a câmera é girada com base na posição do mouse. A referência da câmera adota "-Z" como "cima" no programa.

A função draw() é responsável por renderizar o jogo. Ele primeiro limpa a tela e configura a iluminação usando a função lights(). O inimigo é então renderizado usando a função inimigo(), e os blocos são desenhados usando a função bloco(), que também usa de vértices e vetores para armazenar suas posições, e texturas, e colisao() para lidar com as colisões entre o player e a parede.

A função movimentoCamera() calcula a posição e a orientação da câmera com base na posição do jogador e na posição do mouse. Ele primeiro calcula os ângulos de rotação usando a função map() e então cria um PVector que representa a direção da câmera. As funções translate() e camera() são usadas para posicionar e orientar a câmera.
 
![Screenshot_5](https://user-images.githubusercontent.com/45906809/235815387-fe450b5c-36b8-4774-999c-115f7ce624d4.png)
