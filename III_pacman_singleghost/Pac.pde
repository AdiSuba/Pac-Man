class Pac {
  PVector start;
  PVector pos;
  PVector vel;
  float speed;
  PImage img[];
  int anim= 0;
  char currentDir = 'l', targetDir = 'l';
  Node previousNode, targetNode;
  
  Pac(int xstart, int ystart) {
    start = new PVector(xstart, ystart);
    pos = new PVector(13.5, 26);
    vel = new PVector(0, 0);
    speed = 0.125;
    moveLeft();
    
    img  = new PImage[3];
    img[0] = loadImage("pacman_1.png");
    img[1] = loadImage("pacman_2.png");
    img[2] = loadImage("pacman_3.png");
  }
  
  void setPreviousNode(Node p) {
    previousNode = p;
  }
  void setTargetNode(Node t) {
    targetNode = t;
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
  
  void moveDir() {
    if(currentDir == 'l') moveLeft();
    if(currentDir == 'r') moveRight();
    if(currentDir == 'u') moveUp();
    if(currentDir == 'd') moveDown();
  }
  
  float lengthFromNode(PVector targetPosition) {
    PVector vec = PVector.sub(targetPosition, previousNode.pos);
    return vec.magSq();
  }
  
  boolean overshotTarget() {
    float nodeToTarget = lengthFromNode(targetNode.pos);
    float nodeToSelf = lengthFromNode(pos);
    return nodeToSelf > nodeToTarget || (previousNode.getTp() && targetNode.getTp());
  }
  
  void move() {
    pos.add(vel);
    if(overshotTarget()) {
      char[] vDir = targetNode.validDir;
      boolean invalid = true;
      for(int i = 0; i < vDir.length; i++) {
        if(vDir[i] == targetDir) {
          changeTargetDirection(targetDir);
          pos.x = targetNode.pos.x;
          pos.y = targetNode.pos.y;
          previousNode = targetNode;
          targetNode = previousNode.neighbor[i];
          currentDir = targetDir; 
          moveDir();
          invalid = false;
        }
      }
      if(invalid) {
        for(int i = 0; i < vDir.length; i++) {
          if(vDir[i] == currentDir) {
            previousNode = targetNode;
            targetNode = previousNode.neighbor[i];
            invalid = false;
          }
        }
        if(invalid) {
          pos.x = targetNode.pos.x;
          pos.y = targetNode.pos.y;
          anim--;
        } 
      }
      //print(pos.x);
      //println(pos.y);
    }
  }
  
  void update() {
    move();
  }
  
  void move(float x, float y) {
    pos.x += x;
    pos.y += y;
  }
  
  boolean opposite(char a, char b) {
    return (a == 'l' && b == 'r') || (a == 'u' && b == 'd');
  }
  
  void changeTargetDirection(char newDir) {
    targetDir = newDir;
    if(opposite(currentDir, targetDir) || opposite(targetDir, currentDir)) {
      currentDir = targetDir;
      Node temp = targetNode;
      targetNode = previousNode;
      previousNode = temp;
      moveDir();
    }
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
    anim++;
    if (anim/8 == 3) anim = 0;
    popMatrix();
  }
  void displayDebug() {
    fill(255, 255, 0);
    rect(start.x + pos.x*16, start.y + pos.y*16, 16, 16);
  }
}
