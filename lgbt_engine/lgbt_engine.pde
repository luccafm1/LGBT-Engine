// LGBT Engine

import ddf.minim.*;

Minim minim;
AudioPlayer ambiente;

PImage gabriel,luca,chao,parede,teto;

float anguloY,anguloG;

float centroX,centroY,centroZ;

PVector playerPos,inimigoPos;
float inimigoVel,playerVel;

  
float x = 50; // constante basica
float y = 50; // constante basica

float aleatorizarX = random(1,5000);
float aleatorizarY = random(1,5000);
  

void setup(){
  background(0,0,0);
  size(1360,900,P3D);
  
  // carregar imagens
  gabriel = loadImage("gabriel.jpg");
  luca = loadImage("luca.jpg");
  chao = loadImage("carpet.jpg");
  teto = loadImage("roof.jpg");
  parede = loadImage("wall.jpg");
  
  //vetores camera
  playerPos = new PVector(0,0,1200);
  playerVel = 200;
  inimigoPos = new PVector(0,0,1200);
  inimigoVel = 15;
  
  minim = new Minim(this);
  ambiente = minim.loadFile("ambiente.mp3");
  ambiente.play();
  loop();
}

int xp = width/2;
int yp = height/2;

void draw(){
  background(0);
  fill(50);
 
  //shaders
  lights();

  pushMatrix();
  //inimigos
  noLights();
  translate(500,0,500);
  inimigo(gabriel);
  lights();
  noStroke();
  //orientacao
  fill(255,0,0);
  popMatrix();

  movimentoCamera();
  
  fill(255,255,255);
  
  //chao e teto do jogo
  textureWrap(REPEAT);
  PVector[] verticesChao = new PVector[4];
  for (int i = 0; i < 5000; i += 2500) { 
    verticesChao[0] = new PVector(0, 0, 0);
    verticesChao[1] = new PVector(i*x, 0, 0);
    verticesChao[2] = new PVector(i*x, i*x, 0);
    verticesChao[3] = new PVector(0, i*x, 0);
    face(verticesChao[0],verticesChao[1],verticesChao[2],verticesChao[3],chao,50000,50000);

    verticesChao[0] = new PVector(0, 0, 2000);
    verticesChao[1] = new PVector(i*x, 0, 2000);
    verticesChao[2] = new PVector(i*x, i*y, 2000);
    verticesChao[3] = new PVector(0, i*y, 2000);
    face(verticesChao[0],verticesChao[1],verticesChao[2],verticesChao[3],teto,50000,50000);
  }
  //parede do jogo
  textureWrap(REPEAT);
  
  // blocos
  bloco(aleatorizarX,aleatorizarY,200,2000);


  if (keyPressed) {
    if (keyCode == LEFT || key == 'a' || key == 'A') {
      PVector direcao = new PVector(-centroY,centroX,0);
      direcao.normalize();
      direcao.mult(playerVel);
      playerPos.sub(direcao);
    }
    if (keyCode == RIGHT || key == 'd' || key == 'D') {
      PVector direcao = new PVector(-centroY,centroX,0);
      direcao.normalize();
      direcao.mult(playerVel);
      playerPos.add(direcao);
    }
    if (keyCode == UP || key == 'w' || key == 'W') {
      PVector direcao = new PVector(centroX,centroY,0);
      direcao.normalize();
      direcao.mult(playerVel);
      playerPos.add(direcao);
    }
    if (keyCode == DOWN || key == 's' || key == 'S') {
      PVector direcao = new PVector(centroX,centroY,0);
      direcao.normalize();
      direcao.mult(playerVel);
      playerPos.sub(direcao);
    }
    // MODO FLIGHT (debug)
    if (keyCode == CONTROL) {
      playerPos.z -= playerVel;
    }
    if (keyCode == SHIFT) {
      playerPos.z += playerVel;
    }
    
  }
}

// face com textura (avançado)
void face(PVector v1, PVector v2, PVector v3, PVector v4, PImage img, float u, float v) {
  beginShape(QUADS);
  texture(img);
  vertex(v1.x, v1.y, v1.z, 0, 0);
  vertex(v2.x, v2.y, v2.z, u, 0);
  vertex(v3.x, v3.y, v3.z, u, v);
  vertex(v4.x, v4.y, v4.z, 0, v);
  endShape();
}
// face sem textura (simples)
void face(PVector v1, PVector v2, PVector v3, PVector v4) {
  beginShape(QUADS);
  vertex(v1.x, v1.y, v1.z);
  vertex(v2.x, v2.y, v2.z);
  vertex(v3.x, v3.y, v3.z);
  vertex(v4.x, v4.y, v4.z);
  endShape();
}

void movimentoCamera(){ 
  //angulo rotacao (X)
  anguloG = map(mouseX, 0, width, 0, TWO_PI);
  //angulo rotacao (Y)
  anguloY = map(mouseY, 0, height, 0, PI);
  centroX = cos(anguloG) * sin(anguloY);
  centroY = sin(anguloG) * sin(anguloY);
  centroZ = cos(anguloY);
  
  PVector dir = new PVector(centroX,centroY,centroZ);
  dir.normalize();
  translate(playerPos.x,playerPos.y,playerPos.z);
  camera(playerPos.x, playerPos.y, playerPos.z, playerPos.x + dir.x, playerPos.y + dir.y, playerPos.z + dir.z, 0, 0, -1);
}

void inimigo(PImage img){
  pushMatrix();
  //seguir player
  PVector disPos = PVector.sub(playerPos,inimigoPos);
  disPos.normalize();
  inimigoPos.add(disPos.mult(inimigoVel));
  translate(inimigoPos.x,inimigoPos.y,inimigoPos.z);
  //diferença entre vetores x,y de player e inimigo
  PVector dir = PVector.sub(new PVector(playerPos.x, playerPos.y, 0), new PVector(inimigoPos.x, inimigoPos.y, 0));
  dir.normalize();
  //rotacionar inimigo
  float apontar = atan2(dir.y,dir.x);
  rotateX(radians(90));
  rotateZ(radians(180));
  rotateY(radians(90));
  rotateY(-apontar);
  rotateZ(radians(180));
  rotateX(radians(90));
  //inimigo
  PVector[] verticesInimigo = new PVector[4];
  verticesInimigo[0] = new PVector(0, 0, 0);
  verticesInimigo[1] = new PVector(2000, 0, 0);
  verticesInimigo[2] = new PVector(2000, 0, 2000);
  verticesInimigo[3] = new PVector(0, 0, 2000);
  face(verticesInimigo[0],verticesInimigo[1],verticesInimigo[2],verticesInimigo[3],img,1000,1000);
  popMatrix();
  
}

boolean colisao(PVector x, PVector y, PVector x1){
  println(playerPos);
  println(x,y);
  if ((playerPos.x > x.x && playerPos.y > x.y && playerPos.x > y.x && playerPos.y < y.y) && (playerPos.x < x1.x)){
      return true;
    }
    else {
      return false;
    }
}

void bloco(float blocoX, float blocoY, float comprimento, float altura){
  PVector[] verticesParede = new PVector[16];
    for (int i = 0; i < comprimento; i += comprimento/2) { 
      //face esquerda
      verticesParede[0] = new PVector(blocoX, blocoY, 0);
      verticesParede[1] = new PVector(blocoX+i*x, blocoY, 0);
      verticesParede[2] = new PVector(blocoX+i*x, blocoY, altura);
      verticesParede[3] = new PVector(blocoX, blocoY, altura);
      face(verticesParede[0],verticesParede[1],verticesParede[2],verticesParede[3],parede,1300,964);
      //face direita
      verticesParede[4] = new PVector(blocoX, blocoY+(i*x)-comprimento/2, 0);
      verticesParede[5] = new PVector(blocoX+i*x, blocoY+(i*x)-comprimento/2, 0);
      verticesParede[6] = new PVector(blocoX+i*x, blocoY+(i*x)-comprimento/2, altura);
      verticesParede[7] = new PVector(blocoX, blocoY+(i*x)-comprimento/2, altura);
      face(verticesParede[4],verticesParede[5],verticesParede[6],verticesParede[7],parede,1300,964);
      //face frontal
      verticesParede[8] = new PVector(blocoX+(i*y)-comprimento, blocoY, 0);
      verticesParede[9] = new PVector(blocoX+(i*y)-comprimento, blocoY+i*y, 0);
      verticesParede[10] = new PVector(blocoX+(i*y)-comprimento, blocoY+i*y, altura);
      verticesParede[11] = new PVector(blocoX+(i*y)-comprimento, blocoY, altura);
      face(verticesParede[8],verticesParede[9],verticesParede[10],verticesParede[11],parede,1300,964);
      //face anterior
      verticesParede[12] = new PVector(blocoX, blocoY, 0);
      verticesParede[13] = new PVector(blocoX, blocoY+i*y, 0);
      verticesParede[14] = new PVector(blocoX, blocoY+i*y, altura);
      verticesParede[15] = new PVector(blocoX, blocoY, altura);
      face(verticesParede[12],verticesParede[13],verticesParede[14],verticesParede[15],parede,1300,964);
  
      if (colisao(verticesParede[12],verticesParede[13], verticesParede[8]) == true){
          println("colisão!");
          playerVel *= -10;
        }
        else {
          playerVel = 200;
        }
    }
}
