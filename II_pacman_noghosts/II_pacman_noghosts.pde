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
  pacman.setPreviousNode(map.getNodeOnPos(new PVector(15, 26)));
  pacman.setTargetNode(map.getNodeOnPos(new PVector(12, 26)));
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
      pacman.changeTargetDirection(dir);
    }
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
