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
  boolean frightened = false, ghost = false, dead = false;
  int deadTimer = 0, deadLength = 2;
  
  Ghost(int xstart, int ystart, Pac pac) {
    start = new PVector(xstart, ystart);
    pos = new PVector(15, 14);
    vel = new PVector(0, 0);
    speed = 0.1;
    moveLeft();
    
    pacman = pac;
    img  = new PImage[12];
    img[0] = loadImage("red_up1.png");
    img[1] = loadImage("red_down1.png");
    img[2] = loadImage("red_left1.png");
    img[3] = loadImage("red_right1.png");
    img[4] = loadImage("red_up2.png");
    img[5] = loadImage("red_down2.png");
    img[6] = loadImage("red_left2.png");
    img[7] = loadImage("red_right2.png");
    img[8] = loadImage("fright_1.png");
    img[9] = loadImage("fright_2.png");
    img[10] = loadImage("ghost_1.png");
    img[11] = loadImage("ghost_1.png");
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
  
  PVector getTarget (PVector p) {
    PVector target = pacman.pos;
    PVector teleport1 = new PVector(-1, 16), teleport2 = new PVector(28, 17);
    //println(getDistance(pos, teleport1) + getDistance(teleport2, target));
    //println(getDistance(pos, teleport2) + getDistance(teleport1, target));
    //println(getDistance(pos, target));
    
    if(getDistance(p, teleport1) > 3 && getDistance(p, teleport1) + getDistance(teleport2, target) < getDistance(p, target)) target = teleport1;
    if(getDistance(p, teleport2) > 3 && getDistance(p, teleport2) + getDistance(teleport1, target) < getDistance(p, target)) target = teleport2;
    stroke(255, 0, 0);
    return target;
  }
  
  PVector getTarget () {
    return getTarget(pos);
  }
  
  
  void showPath() {
  Node tempNode = targetNode, prevTempNode = previousNode;
  line(32+pos.x*16 + 8, pos.y*16 + 8, 32+tempNode.pos.x*16 + 8, tempNode.pos.y*16 + 8);
  k = 0;
  PVector tempPos = pos;
  Node target =  pacman.targetNode;
  if(getDistance(pos, pacman.targetNode.pos) > getDistance(pos, pacman.previousNode.pos)) target = pacman.previousNode;
  while (k < 30 && tempNode != target && tempNode != previousNode) {
    k++;
    char[] vDir = tempNode.validDir;
    float minDistance = 9999;
    int minNode = 0;
    PVector targetPos = getTarget(tempPos);
    if(ghost) targetPos = new PVector(13.5, 14);
    for(int i = 0; i < vDir.length; i++) {
      float distance = getDistance(tempNode.neighbor[i].pos, targetPos);
      if (distance < minDistance && tempNode.neighbor[i] != previousNode) {
        minDistance = distance;
        minNode = i;
      }
    }
    prevTempNode = tempNode;
    tempNode = prevTempNode.neighbor[minNode];
    tempPos = tempNode.pos;
    if(!(prevTempNode.teleport && tempNode.teleport))
      line(32 + prevTempNode.pos.x*16 + 8, prevTempNode.pos.y*16 + 8, 32 + tempNode.pos.x*16 + 8, tempNode.pos.y*16 + 8);
  }
  PVector fin = getTarget(tempNode.pos);
  line(32+tempNode.pos.x*16 + 8, tempNode.pos.y*16 + 8, 32+fin.x*16 + 8, fin.y*16 + 8);
  }
  
  void move() {
    pos.add(vel);
    if(overshotTarget()) {
      char[] vDir = targetNode.validDir;
      float minDistance = 9999;
      int minNode = 0;
      PVector target = getTarget();
      if(ghost) target = new PVector(13.5, 14);
      for(int i = 0; i < vDir.length; i++) {
        float distance = getDistance(targetNode.neighbor[i].pos, target);
        if (distance < minDistance  && targetNode.neighbor[i] != previousNode) {
          minDistance = distance;
          minNode = i;
        }
      }
      if(frightened) minNode = 0;
      char targetDir = vDir[minNode];
      pos.x = targetNode.pos.x;
      pos.y = targetNode.pos.y;
      previousNode = targetNode;
      targetNode = previousNode.neighbor[minNode];
      currentDir = targetDir; 
      moveDir(targetDir);
    }
  }
  
  boolean opposite(char a, char b) {
    return (a == 'l' && b == 'r') || (a == 'u' && b == 'd');
  }
  
  char opposite(char a) {
    if(a == 'l') return('r');
    if(a == 'r') return('l');
    if(a == 'u') return('d');
    return 'u';  }
  
  void update() {
    
    if(ghost) {
      frightened = false;
      speed = 0.15;
      moveDir(currentDir);
      if(getDistance(new PVector(13.5, 14), pos) < 1) {
        dead = true;
        ghost = false;
        pos.x = 13.5;
        pos.y = 17;
      }
    }
    
    if(!ghost && pacman.power == 2 && !dead) {
      frightened = true;
      speed = 0.05;
      moveDir(currentDir);
    }
    else if(pacman.power == 0) {
      frightened = false;
      speed = 0.1;
      moveDir(currentDir);
    }
    if(dead) {
      speed = 0.1;
      deadTimer++;
      if(deadTimer/60 > deadLength) {
        deadTimer = 0;
        deadLength = 2;
        dead = false;      }
    }
    else move();
  }
  
  void display() {
    //showPath();
    
    int n;
    if(ghost) {
      n = 10;
    }
    else if(frightened) {
      n = 8;
    }
    else {
      speed = 0.11;
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
    }
    anim++;
    int animSpeed = 10;
    if (anim/animSpeed == 2) anim = 0;
    if(frightened || ghost) {
      image(img[n + anim/animSpeed], start.x + pos.x*16 - 8, start.y + pos.y*16 - 8);
    }
    else image(img[n + anim/animSpeed*4], start.x + pos.x*16 - 8, start.y + pos.y*16 - 8);
  }
  
  void displayDebug() {
    fill(255, 255, 0);
    rect(start.x + pos.x*16, start.y + pos.y*16, 16, 16);
  }
}
