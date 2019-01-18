class Inky extends Ghost {
  
  Ghost blinky;
  
  Inky(int xstart, int ystart, Pac pac, Ghost bl) {
    super(xstart, ystart, pac);
    pos = new PVector(13.5, 17);
    dead = true;
    deadLength = 4;
    blinky = bl;
    img[0] = loadImage("blue_up1.png");
    img[1] = loadImage("blue_down1.png");
    img[2] = loadImage("blue_left1.png");
    img[3] = loadImage("blue_right1.png");
    img[4] = loadImage("blue_up2.png");
    img[5] = loadImage("blue_down2.png");
    img[6] = loadImage("blue_left2.png");
    img[7] = loadImage("blue_right2.png");
  }
  
  PVector getTarget (PVector p) {
    PVector teleport1 = new PVector(-1, 16), teleport2 = new PVector(28, 17);
    PVector blinkyToPacman = new PVector(pacman.pos.x - blinky.pos.x, pacman.pos.y - blinky.pos.y);

    PVector target = new PVector (pacman.pos.x + blinkyToPacman.x, pacman.pos.y + blinkyToPacman.y);
    //println(getDistance(pos, teleport1) + getDistance(teleport2, target));
    //println(getDistance(pos, teleport2) + getDistance(teleport1, target));
    //println(getDistance(pos, target));
    
    if(getDistance(p, teleport1) > 3 && getDistance(p, teleport1) + getDistance(teleport2, target) < getDistance(p, target)) target = teleport1;
    if(getDistance(p, teleport2) > 3 && getDistance(p, teleport2) + getDistance(teleport1, target) < getDistance(p, target)) target = teleport2;
    stroke(0, 200, 250);
    return target;
  }
}
