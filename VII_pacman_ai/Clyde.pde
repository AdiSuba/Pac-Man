class Clyde extends Ghost {
  
  Clyde(int xstart, int ystart, Pac pac) {
    super(xstart, ystart, pac);
    dead = true;
    deadLength = 6;
    pos = new PVector(15.5, 17);
    img[0] = loadImage("yellow_up1.png");
    img[1] = loadImage("yellow_down1.png");
    img[2] = loadImage("yellow_left1.png");
    img[3] = loadImage("yellow_right1.png");
    img[4] = loadImage("yellow_up2.png");
    img[5] = loadImage("yellow_down2.png");
    img[6] = loadImage("yellow_left2.png");
    img[7] = loadImage("yellow_right2.png");
  }
  
  PVector getTarget (PVector p) {
    PVector target = new PVector (pacman.pos.x, pacman.pos.y);
    PVector teleport1 = new PVector(-1, 16), teleport2 = new PVector(28, 17);
    
    if(getDistance(p, teleport1) > 3 && getDistance(p, teleport1) + getDistance(teleport2, target) < getDistance(p, target)) target = teleport1;
    if(getDistance(p, teleport2) > 3 && getDistance(p, teleport2) + getDistance(teleport1, target) < getDistance(p, target)) target = teleport2;
    if(getDistance(pos, pacman.pos) < 8*16) target = new PVector(1, 32);
    stroke(250, 250, 0);
    return target;
  }
}
