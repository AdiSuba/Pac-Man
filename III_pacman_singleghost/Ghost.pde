class Ghost {
  PVector start;
  PVector pos;
  PVector vel;
  float speed;
  PImage img[];
  int anim = 0;
  char currentDir = 'l';
  Node currentNode, previousNode, targetNode;
  Pac pacman;
  
  Ghost(int xstart, int ystart, Pac pac) {
    start = new PVector(xstart, ystart);
    pos = new PVector(8, 8);
    vel = new PVector(0, 0);
    speed = 0.11;
    moveLeft();
    
    pacman = pac;
    img  = new PImage[8];
    img[0] = loadImage("red_up1.png");
    img[1] = loadImage("red_down1.png");
    img[2] = loadImage("red_left1.png");
    img[3] = loadImage("red_right1.png");
    img[4] = loadImage("red_up2.png");
    img[5] = loadImage("red_down2.png");
    img[6] = loadImage("red_left2.png");
    img[7] = loadImage("red_right2.png");
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
  
  void moveDir(char direction) {
    currentDir = direction;
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
  
  float getDistance(PVector a, PVector b) {
    PVector vec = PVector.sub(a, b);
    return vec.magSq();
  }
  PVector getTarget () {
    PVector target = pacman.pos;
    PVector teleport1 = new PVector(-1, 16), teleport2 = new PVector(28, 17);
    println(getDistance(pos, teleport1) + getDistance(teleport2, target));
    println(getDistance(pos, teleport2) + getDistance(teleport1, target));
    println(getDistance(pos, target));
    
    if(getDistance(pos, teleport1) > 3 && getDistance(pos, teleport1) + getDistance(teleport2, target) < getDistance(pos, target)) target = teleport1;
    if(getDistance(pos, teleport2) > 3 && getDistance(pos, teleport2) + getDistance(teleport1, target) < getDistance(pos, target)) target = teleport2;
    return target;
  }
  
  void move() {
    pos.add(vel);
    if(overshotTarget()) {
      char[] vDir = targetNode.validDir;
      float minDistance = 9999;
      int minNode = 0;
      PVector target = getTarget();
      for(int i = 0; i < vDir.length; i++) {
        float distance = getDistance(targetNode.neighbor[i].pos, target);
        if (distance < minDistance) {
          minDistance = distance;
          minNode = i;
        }
      }
      char targetDir = vDir[minNode];
      pos.x = targetNode.pos.x;
      pos.y = targetNode.pos.y;
      previousNode = targetNode;
      targetNode = previousNode.neighbor[minNode];
      currentDir = targetDir; 
      moveDir(targetDir);
    }
  }
  
  void update() {
    move();
  }
  
  void display() {
    int n;
    if(currentDir == 'l') {
      n = 2;
    }
    else if(currentDir == 'r') {
      n = 3;
    }
    else if(currentDir == 'u') {
      n = 0;
    }
    else {
      n = 1;
    }
    anim++;
    int animSpeed = 10;
    if (anim/animSpeed == 2) anim = 0;
    image(img[n + anim/animSpeed*4], start.x + pos.x*16 - 8, start.y + pos.y*16 - 8);
  }
  
  void displayDebug() {
    fill(255, 255, 0);
    rect(start.x + pos.x*16, start.y + pos.y*16, 16, 16);
  }
}
