import processing.sound.*;
SoundFile begin;
import java.util.LinkedList;

PImage maze;
int xstart;
Board map;
Pac pacman;
Ghost blinky, pinky, inky, clyde;
int k = 0;
int testNode = 0;
float time = 0;
float spawn = 0;
SoundFile chomp;

void setup() {
  maze = loadImage("pacman_map.png");
  frameRate(60);
  xstart = 16*2;
  map = new Board();
  pacman = new Pac(xstart, 0);
  pacman.setPreviousNode(map.getNodeOnPos(new PVector(15, 26)));
  pacman.setTargetNode(map.getNodeOnPos(new PVector(12, 26)));
  
  blinky = new Ghost(xstart, 0, pacman);
  blinky.setPreviousNode(map.getNodeOnPos(new PVector(15, 14)));
  blinky.setTargetNode(map.getNodeOnPos(new PVector(15, 14)));
  
  pinky = new Pinky(xstart, 0, pacman);  
  pinky.setPreviousNode(map.getNodeOnPos(new PVector(15, 14)));
  pinky.setTargetNode(map.getNodeOnPos(new PVector(15, 14)));
  
  inky = new Inky(xstart, 0, pacman, blinky);  
  inky.setPreviousNode(map.getNodeOnPos(new PVector(15, 14)));
  inky.setTargetNode(map.getNodeOnPos(new PVector(15, 14)));
  
  clyde = new Clyde(xstart, 0, pacman);  
  clyde.setPreviousNode(map.getNodeOnPos(new PVector(15, 14)));
  clyde.setTargetNode(map.getNodeOnPos(new PVector(15, 14)));
  size(512, 576);
  
  pacman.setGhosts(blinky, pinky, inky, clyde);
  background(0);
  image(maze, xstart, 0);
  map.displayPellets();  
  pacman.display();
  
  blinky.display();
  pinky.display();
  inky.display();
  clyde.display();

  begin = new SoundFile(this, "pacman_beginning.wav");
  chomp = new SoundFile(this, "pacman_chomp.wav");
  begin.play();
  begin.rate(0.25);
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
  //print(begin.duration());
  if(time/60 >= begin.duration())  {
    begin.stop();
    time = 0;
   }
   if(begin.isPlaying() == 0 && !pacman.dead) {
    //checkInput();
    background(0);
    image(maze, xstart, 0);
    map.displayPellets();
    //displayDebug()
    
    pacman.update();
    
    blinky.update();
    pinky.update();
    inky.update();
    clyde.update();
    //map.checkCollision(pacman);
    map.collect(pacman);
    
    blinky.display();
    pinky.display();
    inky.display();
    clyde.display();
    
    if(blinky.frightened && blinky.getDistance(blinky.pos, pacman.pos) < 1.5) {
      blinky.ghost = true;
      pacman.display();
    }
    else if(pinky.frightened && pinky.getDistance(pinky.pos, pacman.pos) < 1.5) {
      pinky.ghost = true;
      pacman.display();
    }
    else if(inky.frightened && inky.getDistance(inky.pos, pacman.pos) < 1.5) {
      inky.ghost = true;
      pacman.display();
    }
    else if(clyde.frightened && clyde.getDistance(clyde.pos, pacman.pos) < 1.5) {
      clyde.ghost = true;
      pacman.display();
    }
    else if((!blinky.ghost && blinky.getDistance(blinky.pos, pacman.pos) < 1.5) || (!pinky.ghost && pinky.getDistance(pinky.pos, pacman.pos) < 1.5 )|| 
       (!inky.ghost && inky.getDistance(inky.pos, pacman.pos) < 1.5) || (!clyde.ghost && clyde.getDistance(clyde.pos, pacman.pos) < 1.5)) {
      pacman.dead = true;
    }
    else pacman.display();
    spawn++;
  }
  else {
    time++;
  }
}
