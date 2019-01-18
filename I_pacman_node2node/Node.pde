class Node {
  
  PVector pos;
  Node[] neighbor;
  char[] validDir;
  
  Node(float x, float y) {
    pos = new PVector(x, y);
    neighbor = new Node[0];
    validDir = new char[0];
  }
  
  void addNeighbor(Node a, char dir) {
    neighbor = (Node[])append(neighbor, a);
    validDir = (char[])append(validDir, dir);
  }
  
  void displayNeighbors() {
    for(int i = 0; i < neighbor.length; i++) {
      fill(250, 100, 0);
      rect(32+neighbor[i].pos.x*16, neighbor[i].pos.y*16, 16, 16);
    }
  }
}
