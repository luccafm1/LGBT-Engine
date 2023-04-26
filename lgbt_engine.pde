// LGBT Engine

float anguloY; //cima e baixo
float anguloG; //graus

float centroX;
float centroY;
float centroZ;

PVector playerPos;
float playerTamanho;
float vetorFinal;
float playerVel;

void setup(){
  background(0,0,0);
  size(1320,900,P3D);
  playerPos = new PVector(0,0,0);
  playerVel = 10;
}

int xp = width/2;
int yp = height/2;

void draw(){
  background(0,0,0);
  fill(50);
  movimentoCamera();
  pushMatrix();
  noStroke();
  translate(playerPos.x,playerPos.y,playerPos.z); // bloco inicial (teste)
  fill(255,0,0);
  box(200, -50, 200);
  bloco(xp-500,yp+200,5,-300,600,200,200);
  bloco(xp-500,yp+200,-100,1500,1500,1,200);
  popMatrix();
  println(playerPos.x,playerPos.y,playerPos.z);
  if (keyPressed) {
    if (keyCode == LEFT) {
      playerPos.x += playerVel * -sin(anguloG);
      playerPos.y += playerVel * cos(anguloG);
    }
    if (keyCode == RIGHT) {
      playerPos.x -= playerVel * -sin(anguloG);
      playerPos.y -= playerVel * cos(anguloG);
    }
    if (keyCode == UP) {
      float hipotAngulo = sqrt((centroX*centroX)+(centroY*centroY));
      playerPos.x -= playerVel * (centroX/hipotAngulo);
      playerPos.y -= playerVel * (centroY/hipotAngulo);
    }
    if (keyCode == DOWN) {
      float hipotAngulo = sqrt((centroX*centroX)+(centroY*centroY));
      playerPos.x += playerVel * (centroX/hipotAngulo);
      playerPos.y += playerVel * (centroY/hipotAngulo);
    }
    if (keyCode == SHIFT) {
      playerPos.z -= playerVel;
    }
    if (keyCode == CONTROL) {
      playerPos.z += playerVel;
    }
  }
}

void movimentoCamera(){ //movimento basico camera
  anguloG = map(mouseX, 0, width, 0, TWO_PI);
  anguloY = map(mouseY, 0, height, 0, PI);
  centroX = cos(anguloG) * sin(anguloY);
  centroY = sin(anguloG) * sin(anguloY);
  centroZ = cos(anguloY);
  rotateY(-mouseX*0.1); // camera rotacao
  camera(0, 0, 0, centroX, centroY, centroZ, 0, 0, -1); // camera basica
}

void bloco(float posBlocoX, float posBlocoY, float posBlocoZ, float blocoX, float blocoY, float altura, float comprimento) {
  pushMatrix();
  fill(255,0,0);
  translate(posBlocoX,posBlocoY,posBlocoZ);
  box(blocoX,blocoY,altura);
  scale(1,comprimento);
  popMatrix();
}
  
