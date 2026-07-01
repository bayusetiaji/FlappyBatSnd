class Bamboo {
  PVector pos;
  PVector vel;
  
  Bamboo() {
    pos = new PVector();
    vel = new PVector(-4, 0);
  }
  
  void move() {
    pos.add(vel);
  }
  
  void show() {
    imageMode(CENTER);
    image(bambImg, pos.x, pos.y);
  }
}