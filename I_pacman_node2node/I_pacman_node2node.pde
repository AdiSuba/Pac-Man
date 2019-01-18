PImage maze;
int xstart;
Board map;
Pac pacman;
int k = 0;
int testNode = 0;

void setup() {
  maze = loadImage("pacman_map.png");
  frameRate(60);
  xstart = 16*2;
  map = new Board();
  pacman = new Pac(xstart, 0);
  size(512, 576);
}

char keyToDir(char c) {
   if(c == 'a') return 'l';
   if(c == 'd') return 'r';
   if(c == 'w') return 'u';
   if(c == 's') return 'd';
   return 'x';
}

void checkInput() {
  if(keyPressed) {
    if(key == 'a' || key == 's' || key == 'd' || key == 'w') {
      char dir = keyToDir(key);
      //pacman.moveOld(dir);
      Node temp = map.getNodeOnPos(pacman.pos);
      if (temp !=  null) {
        temp.displayNeighbors();
        char[] vDir = temp.validDir;
        for(int i = 0; i < vDir.length; i++) {
          if(vDir[i] == dir) {
            pacman.changeTargetDirection(dir);
            pacman.moveToPos(temp.neighbor[i].pos);
          }
        }
      }
    }
    else {
      pacman.stop();
    }
  }
  else {
    pacman.stop();
  }
  
  if(mousePressed) {
    testNode++;
    if(testNode == map.nodes.length) testNode = 0;
  }
}

void displayDebug() {
  map.displayPellets();
  map.displayCollisionMap(xstart, 0);
  map.checkCollision(pacman);
  map.collect(pacman);
  map.displayNodeMap();
  map.displayNodes();
  map.nodes[testNode].displayNeighbors();  
  pacman.displayDebug();
}

void draw() {
  //println(frameRate);
  if(k == 5) {
    checkInput();
    k = 0;
  }
  k++;
  background(0);
  image(maze, xstart, 0);
  map.displayPellets();
  //displayDebug();
  
  pacman.update();
  //map.checkCollision(pacman);
  map.collect(pacman);
  pacman.display();
}
