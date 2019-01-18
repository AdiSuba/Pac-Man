class Pac {
  PVector start;
  PVector pos;
  PVector vel;
  float speed;
  PImage img[];
  int anim= 0;
  char currentDir = 'l', targetDir = 'l';
  boolean dead = false;
  int power = 0;
  int[] collision = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 3, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 3, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 2, 2, 2, 2, 1, 1, 2, 2, 2, 2, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 2, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 2, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 2, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 2, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 2, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 2, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 3, 2, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 2, 3, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 2, 2, 2, 2, 1, 1, 2, 2, 2, 2, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  

  Ghost gh1, gh2, gh3, gh4;
  Node previousNode, targetNode;
  
  Pac(int xstart, int ystart) {
    start = new PVector(xstart, ystart);
    pos = new PVector(13.5, 26);
    vel = new PVector(0, 0);
    speed = 0.125;
    moveLeft();
    
    gh1 = new Ghost(0, 0, this);
    gh2 = new Ghost(0, 0, this);
    gh3 = new Ghost(0, 0, this);
    gh4 = new Ghost(0, 0, this);
    
    img  = new PImage[3];
    img[0] = loadImage("pacman_1.png");
    img[1] = loadImage("pacman_2.png");
    img[2] = loadImage("pacman_3.png");
  }
  
  void setGhosts(Ghost g1, Ghost g2, Ghost g3, Ghost g4) {
    gh1 = g1;
    gh2 = g2;
    gh3 = g3;
    gh4 = g4;
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
  
  float getDistance(PVector a, PVector b) {
    PVector vec = PVector.sub(a, b);
    return vec.magSq();
  }
  
  PVector getTarget (PVector p) {
    PVector teleport1 = new PVector(-1, 16), teleport2 = new PVector(28, 17);
    //println(getDistance(pos, teleport1) + getDistance(teleport2, target));
    //println(getDistance(pos, teleport2) + getDistance(teleport1, target));
    //println(getDistance(pos, target));
    
    //if(getDistance(p, teleport1) > 3 && getDistance(p, teleport1) + getDistance(teleport2, target) < getDistance(p, target)) target = teleport1;
    //if(getDistance(p, teleport2) > 3 && getDistance(p, teleport2) + getDistance(teleport1, target) < getDistance(p, target)) target = teleport2;
    
    PVector sum = new PVector(p.x, p.y);
    float d = PVector.dist(p, gh1.pos)/30;
    if(gh1.frightened && power/60 < 3.5) {
        //sum.add(PVector.sub(gh1.pos, p));
        //sum.normalize();
        //sum.limit(0.5);
        PVector diff = PVector.sub(gh1.pos, p);
        diff.normalize();
        diff.div(d);
        sum.add(diff);
    }
    else if(d > 0 && d < 10*16 && !(gh1.ghost||gh1.dead)) {
      PVector diff = PVector.sub(p, gh1.pos);
      diff.normalize();
      diff.div(d);
      sum.add(diff);
    }
    d = PVector.dist(p, gh2.pos)/30;
    if(gh2.frightened && power/60 < 3.5) {
        PVector diff = PVector.sub(gh2.pos, p);
        diff.normalize();
        diff.div(d);
        sum.add(diff);
    }
    else if(d > 0 && d < 10*16 && !(gh2.ghost||gh2.dead)) {
      PVector diff = PVector.sub(p, gh2.pos);
      diff.normalize();
      diff.div(d);
      sum.add(diff);
    }
    d = PVector.dist(p, gh3.pos)/30;
    if(gh3.frightened && power/60 < 3.5) {
      PVector diff = PVector.sub(gh3.pos, p);
      diff.normalize();
      diff.div(d);
      sum.add(diff);
    }
    else if(d > 0 && d < 10*16 && !(gh3.ghost||gh3.dead)) {
      PVector diff = PVector.sub(p, gh3.pos);
      diff.normalize();
      diff.div(d);
      sum.add(diff);
    }
    d = PVector.dist(p, gh4.pos)/30;
    if(gh4.frightened && power/60 < 3.5) {
      PVector diff = PVector.sub(gh4.pos, p);
      diff.normalize();
      diff.div(d);
      sum.add(diff);
    }
    else if(d > 0 && d < 10*16 && !(gh4.ghost||gh4.dead)) {
      PVector diff = PVector.sub(p, gh4.pos);
      diff.normalize();
      diff.div(d);
      sum.add(diff);
    }
    
    stroke(255, 255, 0);
    return sum;
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
  
  void moveDir(char direction) {
    currentDir = direction;
    if(currentDir == 'l') moveLeft();
    if(currentDir == 'r') moveRight();
    if(currentDir == 'u') moveUp();
    if(currentDir == 'd') moveDown();
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
        if (distance < minDistance  && targetNode.neighbor[i] != previousNode) {
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
    if(power > 0) power++;
    if(power/60 > 5) power = 0;
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
    showPath();
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
