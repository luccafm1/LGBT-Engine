// LGBT Engine


float anguloY,anguloG;

float centroX,centroY,centroZ;

PVector playerPos;
PVector inimigoPos;
float inimigoVel;
float playerVel;

void setup(){
  background(0,0,0);
  size(1320,900,P3D);
  //vetores camera
  playerPos = new PVector(0,0,0);
  playerVel = 10;
  inimigoPos = new PVector(0,0,0);
  inimigoVel = 8;
}

int xp = width/2;
int yp = height/2;

void draw(){
  background(0);
  fill(50);

  //shaders
  lights();

  pushMatrix();
  //inimigo
  translate(0,100,0);
  inimigo();
  noStroke();
  //orientacao
  fill(255,0,0);
  //tamanho e posicao dos objetos
  float blocoTamanho = height/6;
  float xPos = xp - blocoTamanho*3;
  float yPos = yp - blocoTamanho*2.5;
  //vermelho
  fill(255, 0, 0);
  bloco(xPos, yPos, 0, blocoTamanho*6, blocoTamanho, blocoTamanho);
  //laranja
  fill(255, 128, 0);
  bloco(xPos, yPos+blocoTamanho, 0, blocoTamanho*6, blocoTamanho, blocoTamanho);
  //amarelo
  fill(255, 255, 0);
  bloco(xPos, yPos+blocoTamanho*2, 0, blocoTamanho*6, blocoTamanho, blocoTamanho);
  //verde
  fill(0, 255, 0);
  bloco(xPos, yPos+blocoTamanho*3, 0, blocoTamanho*6, blocoTamanho, blocoTamanho);
  //azul
  fill(0, 128, 255);
  bloco(xPos, yPos+blocoTamanho*4, 0, blocoTamanho*6, blocoTamanho, blocoTamanho);
  //roxo
  fill(127, 0, 255);
  bloco(xPos, yPos+blocoTamanho*5, 0, blocoTamanho*6, blocoTamanho, blocoTamanho);
  popMatrix();
  
  movimentoCamera();
  
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
  println(centroX,centroY,centroZ);
  println(playerPos.x,playerPos.y,playerPos.z);
  println(inimigoPos.x,inimigoPos.y,inimigoPos.z);
}

void bloco(float x, float y, float z, float largura, float altura, float profundidade) {
  pushMatrix();
  translate(x,y,z);
  box(largura,altura,profundidade);
  popMatrix();
}

void inimigo(){
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
  //inimigo
  mario();
  popMatrix();
}

void mario(){ 
  fill(255, 0, 0);
  rect(xp-90, yp-160, 200, 30);
  rect(xp-120, yp-130, 320, 30);
  fill(210, 143, 104);
  square(xp-90, yp-100, 200);
  rect(xp+110, yp-100, 30, 200);
  rect(xp+140, yp-50, 30, 150);
  rect(xp+170, yp-50, 30, 100);
  rect(xp+200, yp-30, 30, 30);
  rect(xp-120, yp-100, 30, 150);
  fill(125, 70, 33);
  rect(xp-150, yp-70, 30, 120);
  rect(xp-120, yp-100, 30, 30);
  rect(xp-120, yp+20, 30, 30);
  rect(xp-90, yp-100, 30, 120);
  rect(xp-60, yp-100, 30, 30);
  rect(xp-60, yp-10, 30, 30);
  rect(xp+110, yp-10, 30, 30);
  rect(xp+80, yp+20, 120, 30);
  fill(0, 0, 0);
  rect(xp+80, yp-100, 30, 90); 
}
