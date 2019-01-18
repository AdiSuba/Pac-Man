import processing.sound.*;
SoundFile begin;
import java.util.LinkedList;

PImage maze;
int xstart;
Board map;
Pac pacman;
Ghost blinky;
int k = 0;
int testNode = 0;
float time = 0;
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
  blinky.setPreviousNode(map.getNodeOnPos(new PVector(18, 11)));
  blinky.setTargetNode(map.getNodeOnPos(new PVector(15, 11)));
  size(512, 576);
  
  background(0);
  image(maze, xstart, 0);
  map.displayPellets();  
  pacman.display();
  blinky.display();
  
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
  if(time/1 >= begin.duration())  {
    begin.stop();
    time = 0;
   }
   if(begin.isPlaying() == 0) {
    checkInput();
    background(0);
    image(maze, xstart, 0);
    map.displayPellets();
    //displayDebug()
    
    pacman.update();
    blinky.update();
    //map.checkCollision(pacman);
    map.collect(pacman);
    
    
    //if(time == 0) {
    //  chomp.play();
    //  chomp.rate(0.5);
    //}
    //if(chomp.isPlaying() == 1) {
    //  time++;
    //}
    //if(time/60 >= chomp.duration()) {
    //  time = 0;
    //  chomp.stop();
    //}
    blinky.display();
    pacman.display();
  }
  else {
    time++;
  }
}
