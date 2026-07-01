class Bat {
  PVector pos;
  PVector vel;
  boolean life;
  
  Bat() {
    pos = new PVector();
    vel = new PVector();
    reset();
  }
  
  void drop() {
    if(life) {
      vel.y += gravity;
      pos.add(vel);
      
      if(pos.y + batImg.height / 2 >= height || pos.y - batImg.height / 2 <= 0)
        life = false;
    }
  }
  
  void up() {
    if(life)
      vel.y = -8;
  }
  
  boolean collision(Bamboo b) {
    if((abs(pos.x - b.pos.x) <= batImg.width / 2 + bambImg.width / 2) &&
       (abs(pos.y - b.pos.y) <= batImg.height / 2 + bambImg.height / 2)
    ) {
      life = false;
      return true;
    }
    return false;
  }
  
  void show() {
    imageMode(CENTER);
    image(batImg, pos.x, pos.y);
  }
  
  void reset() {
    pos.set(100, height / 2);
    vel.mult(0);
    life = true;
  }
}