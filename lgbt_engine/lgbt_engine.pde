// LGBT Engine

import ddf.minim.*;

Minim minim;
AudioPlayer ambiente,gabrielSom,isaSom,vitorSom,gaiasSom,gustavoSom,lucaSom;

PImage gabriel,isa,vitor,gaias,gustavo,luca,chao,parede,teto;

char inimigo;

float anguloY,anguloG;

float centroX,centroY,centroZ;

PVector playerPos,inimigoPos;
float inimigoVel,playerVel;

float x = 50; 
float y = 50;
float timer;

boolean colisaoDetectar, jogoIniciado, morte = false;


void setup(){
  frameRate(120);
  background(0,0,0);
  size(1360,900,P3D);
  
  // carregar imagens
  gabriel = loadImage("gabriel.jpg");
  isa = loadImage("isa.jpg");
  vitor = loadImage("vitor.jpg");
  gustavo = loadImage("gustavo.jpg");
  gaias = loadImage("gaias.jpg");
  luca = loadImage("luca.jpg");
  chao = loadImage("carpet.jpg");
  teto = loadImage("roof.jpg");
  parede = loadImage("wall.jpg");
  
  //vetores camera
  playerPos = new PVector(random(10000,30000),random(10000,30000),1200);
  playerVel = 30;
  inimigoPos = new PVector(0,0,1200);
  inimigoVel = 25;
  
  timer = 0;
  
  minim = new Minim(this);
  ambiente = minim.loadFile("ambiente.mp3");
  ambiente.play();
  
  gabrielSom = minim.loadFile("gabriel.mp3");
  isaSom = minim.loadFile("isa.mp3");
  vitorSom = minim.loadFile("vitor.mp3");
  gaiasSom = minim.loadFile("gaias.mp3");
  gustavoSom = minim.loadFile("gustavo.mp3");
  lucaSom = minim.loadFile("luca.mp3");
  
  //gabrielSom.loop();
  //isaSom.loop();
  //vitorSom.loop();
  //gaiasSom.loop();
  //gustavoSom.loop();
  //lucaSom.loop();
}

int xp = width/2;
int yp = height/2;

void draw(){
  if (jogoIniciado && morte == false) {
    float distance = dist(playerPos.x, playerPos.y, inimigoPos.x, inimigoPos.y); 
    float volume = map(distance, 0, width, 5, 0);
    timer += 0.01;
    
    movimentoCamera();
    background(0);
    fill(50);
    //shaders
    lights();
  
    pushMatrix();
    //inimigos
    noLights();
    translate(0,0,850);
    
    // menu escolher inimigo
    
    switch(inimigo){
      case 1:
        inimigo(gabriel);
        gabrielSom.setGain(volume);
        gabrielSom.play();
        break;
      case 2:
        inimigo(vitor);
        vitorSom.setGain(volume);
        vitorSom.play();
        break;
      case 3:
        inimigo(gustavo);
        gustavoSom.setGain(volume);
        gustavoSom.play();
        break;
      case 4:
        inimigo(isa);
        isaSom.setGain(volume);
        isaSom.play();
        break;
      case 5:
        inimigo(gaias);
        gaiasSom.setGain(volume);
        gaiasSom.play();
        break;
      case 6:
        inimigo(luca);
        lucaSom.setGain(volume);
        lucaSom.play();
        break;
    }
    lights();
    noStroke();
    //orientacao
    fill(255,0,0);
    popMatrix();
    
    fill(255,255,255);
    
    //chao e teto do jogo
  
  
    textureWrap(REPEAT);
    PVector[] verticesChao = new PVector[4];
    for (int i = 0; i < 10000; i += 5000) { 
      //chao
      verticesChao[0] = new PVector(0, 0, 0);
      verticesChao[1] = new PVector(i*y, 0, 0);
      verticesChao[2] = new PVector(i*y, i*y, 0);
      verticesChao[3] = new PVector(0, i*y, 0);
      face(verticesChao[0],verticesChao[1],verticesChao[2],verticesChao[3],chao,50000,50000);
      //teto
      verticesChao[0] = new PVector(0, 0, 2000);
      verticesChao[1] = new PVector(i*y, 0, 2000);
      verticesChao[2] = new PVector(i*y, i*y, 2000);
      verticesChao[3] = new PVector(0, i*y, 2000);
      face(verticesChao[0],verticesChao[1],verticesChao[2],verticesChao[3],teto,100000,100000);
      //parede 1
      verticesChao[0] = new PVector(0, 0, 0);
      verticesChao[1] = new PVector(0, i*y, 0);
      verticesChao[2] = new PVector(0, i*y, 2000);
      verticesChao[3] = new PVector(0, 0, 2000);
      face(verticesChao[0],verticesChao[1],verticesChao[2],verticesChao[3],parede,40300,800);
      //parede 2
      verticesChao[0] = new PVector(0, 0, 0);
      verticesChao[1] = new PVector(i*y, 0, 0);
      verticesChao[2] = new PVector(i*y, 0, 2000);
      verticesChao[3] = new PVector(0, 0, 2000);
      face(verticesChao[0],verticesChao[1],verticesChao[2],verticesChao[3],parede,40300,800);
      //parede 3
      verticesChao[0] = new PVector(0, 50000, 0);
      verticesChao[1] = new PVector(i*y, 50000, 0);
      verticesChao[2] = new PVector(i*y, 50000, 2000);
      verticesChao[3] = new PVector(0, 50000, 2000);
      face(verticesChao[0],verticesChao[1],verticesChao[2],verticesChao[3],parede,40300,800);
      //parede 4
      verticesChao[0] = new PVector(50000, 0, 0);
      verticesChao[1] = new PVector(50000, i*y, 0);
      verticesChao[2] = new PVector(50000, i*y, 2000);
      verticesChao[3] = new PVector(50000, 0, 2000);
      face(verticesChao[0],verticesChao[1],verticesChao[2],verticesChao[3],parede,40300,800);
    }
    //parede do jogo
    textureWrap(REPEAT);
  
    float add = 2500;
    // blocos
    bloco(5000,7000,200,2000);
    bloco(7000,10000,200,2000);
    bloco(10000,10000,200,2000);
    bloco(10000,18000,200,2000);
    bloco(12000,10000,200,2000);
    bloco(10000,16000,200,2000);
    bloco(12000,16000,200,2000);
    bloco(18000,20000,200,2000);
    bloco(20000,20000,200,2000);
    
    bloco(5000+add,7000+add,200,2000);
    bloco(7000+add,10000+add,200,2000);
    bloco(10000+add,10000+add,200,2000);
    bloco(10000+add,18000+add,200,2000);
    bloco(12000+add,10000+add,200,2000);
    bloco(10000+add,16000+add,200,2000);
    bloco(12000+add,16000+add,200,2000);
    bloco(18000+add,20000+add,200,2000);
    bloco(20000+add,20000+add,200,2000);
    
    bloco(2*5000-add,7000+add,200,2000);
    bloco(2*7000-add,10000+add,200,2000);
    bloco(2*10000-add,10000+add,200,2000);
    bloco(2*10000-add,18000+add,200,2000);
    bloco(2*12000-add,10000+add,200,2000);
    bloco(2*10000-add,16000+add,200,2000);
    bloco(2*12000-add,16000+add,200,2000);
    bloco(2*18000-add,20000+add,200,2000);
    bloco(2*20000-add,20000+add,200,2000);
    
    bloco(5000+add,2*7000-add,200,2000);
    bloco(7000+add,2*10000-add,200,2000);
    bloco(10000+add,2*10000-add,200,2000);
    bloco(10000+add,2*18000-add,200,2000);
    bloco(12000+add,2*10000-add,200,2000);
    bloco(10000+add,2*16000-add,200,2000);
    bloco(12000+add,2*16000-add,200,2000);
    bloco(18000+add,2*20000-add,200,2000);
    bloco(20000+add,2*20000-add,200,2000);
    
    bloco(4*5000-add,7000+add,200,2000);
    bloco(4*7000-add,10000+add,200,2000);
    bloco(4*10000-add,10000+add,200,2000);
    bloco(4*10000-add,18000+add,200,2000);
    bloco(4*12000-add,10000+add,200,2000);
    bloco(4*10000-add,16000+add,200,2000);
    bloco(4*12000-add,16000+add,200,2000);
    bloco(4*18000-add,20000+add,200,2000);
    bloco(4*20000-add,20000+add,200,2000);
    
    bloco(5000+add,4*7000-add,200,2000);
    bloco(7000+add,4*10000-add,200,2000);
    bloco(10000+add,4*10000-add,200,2000);
    bloco(10000+add,4*18000-add,200,2000);
    bloco(12000+add,4*10000-add,200,2000);
    bloco(10000+add,4*16000-add,200,2000);
    bloco(12000+add,4*16000-add,200,2000);
    bloco(18000+add,4*20000-add,200,2000);
    bloco(20000+add,4*20000-add,200,2000);
    
    bloco(8*5000-add,7000+add,200,2000);
    bloco(8*7000-add,10000+add,200,2000);
    bloco(8*10000-add,10000+add,200,2000);
    bloco(8*10000-add,18000+add,200,2000);
    bloco(8*12000-add,10000+add,200,2000);
    bloco(8*10000-add,16000+add,200,2000);
    bloco(8*12000-add,16000+add,200,2000);
    bloco(8*18000-add,20000+add,200,2000);
    bloco(8*20000-add,20000+add,200,2000);
    
    bloco(5000+add,8*7000-add,200,2000);
    bloco(7000+add,8*10000-add,200,2000);
    bloco(10000+add,8*10000-add,200,2000);
    bloco(10000+add,8*18000-add,200,2000);
    bloco(12000+add,8*10000-add,200,2000);
    bloco(10000+add,8*16000-add,200,2000);
    bloco(12000+add,8*16000-add,200,2000);
    bloco(18000+add,8*20000-add,200,2000);
    bloco(20000+add,8*20000-add,200,2000);
    
    
  
    
    keyPressed();
  }
  else if (morte) {
  camera();
  fill(255);
  textSize(80);
  textAlign(CENTER,CENTER);
  text("MORRESTE",width/2,height/2);
  textSize(60);
  text("Timer: " + timer + "s", width/2, 180);
  }
  else {
    menu();
  }
}

void menu() {
  PImage menu = loadImage("menu.png");
  image(menu,0,0,1360,900);

  
  textSize(80);
  textAlign(CENTER);
  text("BACKROOMS:", width/2, 150);
  textSize(50);
  text("Escape from the Nerdolas", width/2, 200);
  
  // opcoes
  textSize(35);
  imageMode(CENTER);
  rectMode(CENTER);
  text("Escolha seu nerdola:", width/2,580);
  textSize(24);
  
  image(gabriel,width/6+200,650,80,80);
  fill(0);
  rect(width/6+200,643,80,24);
  fill(255);
  text("Gabriel", width/6+200, 650);
  
  image(vitor,width/6+300,650,80,80);
  fill(0);
  rect(width/6+300,643,80,24);
  fill(255);
  text("Vitor", width/6+300, 650);
  
  image(gustavo,width/6+400,650,80,80);
  fill(0);
  rect(width/6+400,643,80,24);
  fill(255);
  text("Gustavo", width/6+400, 650);
  
  image(isa,width/6+500,650,80,80);
  fill(0);
  rect(width/6+500,643,80,24);
  fill(255);
  text("Isa", width/6+500, 650);
  
  image(gaias,width/6+600,650,80,80);
  fill(0);
  rect(width/6+600,643,80,24);
  fill(255);
  text("Gaias", width/6+600, 650);
  
  image(luca,width/6+700,650,80,80);
  fill(0);
  rect(width/6+700,643,80,24);
  fill(255);
  text("Luca", width/6+700, 650);
  
  imageMode(CORNERS);
}

void keyPressed() {
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
    //// MODO FLIGHT (debug)
    //if (keyCode == CONTROL) {
    //  playerPos.z -= playerVel;
    //}
    //if (keyCode == SHIFT) {
    //  playerPos.z += playerVel;
    //}
    
  }
}

// menu
void mousePressed() {
  if (mousePressed && mouseY > 570 && mouseY < 730 && jogoIniciado == false) {
    if (mouseX > width/6+200-80 && mouseX < width/6+200+80) {
      inimigo = 1;
      jogoIniciado = true; 
      
    } else if (mouseX > width/6+300-80 && mouseX < width/6+300+80) {
      inimigo = 2;
      jogoIniciado = true; 
      
    } else if (mouseX > width/6+400-80 && mouseX < width/6+400+80) {
      inimigo = 3;
      jogoIniciado = true; 
      
    } else if (mouseX > width/6+500-80 && mouseX < width/6+500+80) {
      inimigo = 4;
      jogoIniciado = true; 
      
    } else if (mouseX > width/6+600-80 && mouseX < width/6+600+80) {
      inimigo = 5;
      jogoIniciado = true;
      
    } else if (mouseX > width/6+700-80 && mouseX < width/6+700+80) {
      inimigo = 6;
      jogoIniciado = true;
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
  //matar o player
  float distance = dist(playerPos.x, playerPos.y, inimigoPos.x, inimigoPos.y); 
  if (distance < 10) {
    morte = true;
  }
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


void lidarColisao() {
  if (colisaoDetectar) {
    println("colisao!");
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
      verticesParede[4] = new PVector(blocoX, blocoY+(i*x)-comprimento/2+100, 0);
      verticesParede[5] = new PVector(blocoX+i*x, blocoY+(i*x)-comprimento/2+100, 0);
      verticesParede[6] = new PVector(blocoX+i*x, blocoY+(i*x)-comprimento/2+100, altura);
      verticesParede[7] = new PVector(blocoX, blocoY+(i*x)-comprimento/2+100, altura);
      face(verticesParede[4],verticesParede[5],verticesParede[6],verticesParede[7],parede,1300,964);
      //face frontal
      verticesParede[8] = new PVector(blocoX+(i*y)-comprimento+200, blocoY, 0);
      verticesParede[9] = new PVector(blocoX+(i*y)-comprimento+200, blocoY+i*y, 0);
      verticesParede[10] = new PVector(blocoX+(i*y)-comprimento+200, blocoY+i*y, altura);
      verticesParede[11] = new PVector(blocoX+(i*y)-comprimento+200, blocoY, altura);
      face(verticesParede[8],verticesParede[9],verticesParede[10],verticesParede[11],parede,1300,964);
      //face anterior
      verticesParede[12] = new PVector(blocoX, blocoY, 0);
      verticesParede[13] = new PVector(blocoX, blocoY+i*y, 0);
      verticesParede[14] = new PVector(blocoX, blocoY+i*y, altura);
      verticesParede[15] = new PVector(blocoX, blocoY, altura);
      face(verticesParede[12],verticesParede[13],verticesParede[14],verticesParede[15],parede,1300,964);
      
      if (colisao(verticesParede[12],verticesParede[13],verticesParede[8])){
        
        colisaoDetectar = true;
        playerPos.sub(30,30,0);
      }
      else {
        colisaoDetectar = false;
      }
    }
}
