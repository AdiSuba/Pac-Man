import java.util.LinkedList;
import java.util.Map;


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
    pos = new PVector(18, 11);
    vel = new PVector(0, 0);
    speed = 0.12;
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
    //println(getDistance(pos, teleport1) + getDistance(teleport2, target));
    //println(getDistance(pos, teleport2) + getDistance(teleport1, target));
    //println(getDistance(pos, target));
    
    if(getDistance(pos, teleport1) > 3 && getDistance(pos, teleport1) + getDistance(teleport2, target) < getDistance(pos, target)) target = teleport1;
    if(getDistance(pos, teleport2) > 3 && getDistance(pos, teleport2) + getDistance(teleport1, target) < getDistance(pos, target)) target = teleport2;
    return target;
  }
  
  PVector getTarget (PVector p) {
    PVector target = pacman.pos;
    PVector teleport1 = new PVector(-1, 16), teleport2 = new PVector(28, 17);
    //println(getDistance(pos, teleport1) + getDistance(teleport2, target));
    //println(getDistance(pos, teleport2) + getDistance(teleport1, target));
    //println(getDistance(pos, target));
    
    if(getDistance(p, teleport1) > 3 && getDistance(p, teleport1) + getDistance(teleport2, target) < getDistance(p, target)) target = teleport1;
    if(getDistance(p, teleport2) > 3 && getDistance(p, teleport2) + getDistance(teleport1, target) < getDistance(p, target)) target = teleport2;
    return target;
  }
  
  void showPath() {
    Node tempNode = targetNode, prevTempNode = previousNode;
    stroke(255);
    line(32+pos.x*16 + 8, pos.y*16 + 8, 32+tempNode.pos.x*16 + 8, tempNode.pos.y*16 + 8);
    k = 0;
    PVector tempPos = pos;
    while (k < 30 && tempNode != pacman.targetNode) {
      k++;
      char[] vDir = tempNode.validDir;
      float minDistance = 9999;
      int minNode = 0;
      PVector target = getTarget(tempPos);
      for(int i = 0; i < vDir.length; i++) {
        float distance = getDistance(tempNode.neighbor[i].pos, target);
        if (distance < minDistance && tempNode.neighbor[i] != previousNode) {
          minDistance = distance;
          minNode = i;
        }
      }
      prevTempNode = tempNode;
      tempNode = prevTempNode.neighbor[minNode];
      tempPos = tempNode.pos;
      line(32 + prevTempNode.pos.x*16 + 8, prevTempNode.pos.y*16 + 8, 32 + tempNode.pos.x*16 + 8, tempNode.pos.y*16 + 8);
    }
    line(32+tempNode.pos.x*16 + 8, tempNode.pos.y*16 + 8, 32+pacman.pos.x*16 + 8, pacman.pos.y*16 + 8);
  }
  
  boolean opposite(char a, char b) {
    return (a == 'l' && b == 'r') || (a == 'u' && b == 'd');
  }
  
  void findPath(Node endNode) {
    stroke(255);
    line(32+pos.x*16 + 8, pos.y*16 + 8, 32+targetNode.pos.x*16 + 8, targetNode.pos.y*16 + 8);
    HashMap<Integer, Node> path = new HashMap<Integer, Node>();
    HashMap<Integer, Float> dist =  new HashMap<Integer, Float>();
    HashMap<Integer, Character> dir =  new HashMap<Integer, Character>();
    Node tempNode = targetNode;
    path.put(0, tempNode);
    dist.put(0, 0.0);
    PVector tempPos = pos;
    int n = 1;
    while(!path.containsValue(endNode) && n < 20) {
      float minDistance = 9999, refDist = 0;
      char refDir = 'l';
      Node minNode = null;
      for(int j = 0; j < n; j++) {
        tempNode = path.get(j);
        float currentDist = dist.get(j);
        char[] vDir = tempNode.validDir;
        PVector target = getTarget(tempPos);
        for(int i = 0; i < vDir.length; i++) {
          if(!path.containsValue(tempNode.neighbor[i])) {
            float distance = getDistance(tempNode.neighbor[i].pos, target);
            if (distance + currentDist < minDistance && tempNode.neighbor[i] != previousNode) {
              minDistance = distance + currentDist;
              minNode = tempNode.neighbor[i];
              refDist = getDistance(tempNode.pos, minNode.pos);
              refDir = tempNode.validDir[i];
              stroke(0, 0, 180);
              line(32 + tempNode.pos.x*16 + 8, tempNode.pos.y*16 + 8, 32 + minNode.pos.x*16 + 8, minNode.pos.y*16 + 8);
            }
          }
        }
      }
      path.put(n, minNode);
      dist.put(n, refDist);
      dir.put(n, refDir);
      if(minNode != targetNode) n++;
    }
    Node prevTempNode = path.get(n);
    tempNode = path.get(n);
    int id = n;
    while(prevTempNode != null && prevTempNode != path.get(0)) {
      char[] vDir = currentNode.validDir;
      for(int i = 0; i < vDir.length; i++) {
        if(opposite(vDir[i], dir.get(id))) {
          prevTempNode = tempNode;
          tempNode = previousNode.neighbor[i];
          stroke(0, 0, 150);
          line(32 + prevTempNode.pos.x*16 + 8, prevTempNode.pos.y*16 + 8, 32 + tempNode.pos.x*16 + 8, tempNode.pos.y*16 + 8);
          break;
        }
      }
    }
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
    findPath(pacman.targetNode);
    //showPath();
    //move();
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
