class Pac {
  PVector start;
  PVector pos;
  PVector vel;
  float speed;
  PImage img[];
  int anim= 0;
  char currentDir = 'r', targetDir = 'l';
  Node currentNode, PreviousNode, TargetNode;
  
  Pac(int xstart, int ystart) {
    start = new PVector(xstart, ystart);
    pos = new PVector(12, 26);
    vel = new PVector(0, 0);
    speed = 0.125;
    
    img  = new PImage[3];
    img[0] = loadImage("pacman_1.png");
    img[1] = loadImage("pacman_2.png");
    img[2] = loadImage("pacman_3.png");
  }
  
  void moveLeft() {
    vel.x = -speed;
    vel.y = 0;
  }
  
  void moveRight() {
    vel.x = speed;
    vel.y = 0;
  }
  
  void moveUp() {
    vel.y = -speed;
    vel.x = 0;
  }
  
  void moveDown() {
    vel.y = speed;
    vel.x = 0;
  }
  
  void moveOld(char direction) {
    currentDir = direction;
    if(currentDir == 'l') moveLeft();
    if(currentDir == 'r') moveRight();
    if(currentDir == 'u') moveUp();
    if(currentDir == 'd') moveDown();
  }
  
  void move(char direction) {
    currentDir = direction;
  }
  void stop() {
    vel.x = 0;
    vel.y = 0;
  }
  
  void stopX() {
    vel.x = 0;
  }
  
  void stopY() {
    vel.y = 0;
  }
  
  void update() {
    pos.add(vel);
  }
  
  void move(float x, float y) {
    pos.x += x;
    pos.y += y;
  }
  
  void changeTargetDirection(char newDir) {
    currentDir = newDir;
  }
  
  void moveToPos(PVector newPos) {
    pos.x = newPos.x;
    pos.y = newPos.y;
  }
  
  void display() {
    pushMatrix();
    translate(start.x + pos.x*16 + 8, start.y + pos.y*16 + 8);
    if(currentDir == 'l') {
      rotate(PI);
    }
    else if(currentDir == 'r') {
      rotate(0);
    }
    else if(currentDir == 'u') {
      rotate(-PI/2.0);
    }
    else {
      rotate(PI/2.0);
    }
    translate(- 16, - 16);
    image(img[anim/8], 0, 0);
    anim = anim + 1;
    if (anim/8 == 3) anim = 0;
    popMatrix();
  }
  void displayDebug() {
    fill(255, 255, 0);
    rect(start.x + pos.x*16, start.y + pos.y*16, 16, 16);
  }
}
