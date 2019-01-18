class Pinky extends Ghost {
  
  Pinky(int xstart, int ystart, Pac pac) {
    super(xstart, ystart, pac);
    dead = true;
    pos = new PVector(11.5, 17);
    img[0] = loadImage("pink_up1.png");
    img[1] = loadImage("pink_down1.png");
    img[2] = loadImage("pink_left1.png");
    img[3] = loadImage("pink_right1.png");
    img[4] = loadImage("pink_up2.png");
    img[5] = loadImage("pink_down2.png");
    img[6] = loadImage("pink_left2.png");
    img[7] = loadImage("pink_right2.png");
  }
  
  PVector getTarget (PVector p) {
    PVector target = new PVector (pacman.pos.x, pacman.pos.y);
    char ch = pacman.currentDir;
    if(ch == 'l') {
      target.x -= 5;
      if(target.x < 0) target.x = 0;
    }
    else if(ch == 'r') {
      target.x += 5;
      if(target.x > 30) target.x = 30;
    }
    else if(ch == 'u') {
      target.y -= 5;
      if(target.y < 0) target.y = 0;
    }
    else {
      target.y += 5;
      if(target.y > 30) target.y = 30;
    }
    PVector teleport1 = new PVector(-1, 16), teleport2 = new PVector(28, 17);
    //println(getDistance(pos, teleport1) + getDistance(teleport2, target));
    //println(getDistance(pos, teleport2) + getDistance(teleport1, target));
    //println(getDistance(pos, target));
    
    if(getDistance(p, teleport1) > 3 && getDistance(p, teleport1) + getDistance(teleport2, target) < getDistance(p, target)) target = teleport1;
    if(getDistance(p, teleport2) > 3 && getDistance(p, teleport2) + getDistance(teleport1, target) < getDistance(p, target)) target = teleport2;
    return target;
  }
}
