import processing.sound.*;

PImage batImg;
PImage bgImg;
PImage bambImg;

final float gravity = 0.618;
boolean paused = true;

AudioIn in;
Amplitude amp;

Bat bat;
Bamboo[] bamboos;

int score = 0;

void setup() {
  size(331, 480);
  batImg = loadImage("bat.png");
  bgImg = loadImage("bg-nite.png");
  bambImg = loadImage("bamboo.png");
    
  bat = new Bat();
  bamboos = new Bamboo[2];
  for(int i = 0; i < bamboos.length; i++)
    bamboos[i] = new Bamboo();
    
  bamboosReset();
  
  in = new AudioIn(this, 0);
  in.start();
  
  amp = new Amplitude(this);
  amp.input(in);
}

void draw() {
  imageMode(CORNER);
  image(bgImg, 0, 0);
  
  for(Bamboo b:bamboos) {
    b.show();
  }
  
  bat.show();
  
  if(!paused) {
    for(Bamboo b:bamboos) {
      b.move();
      
      if(bat.collision(b)) 
        paused = true;
            
      if(b.pos.x - bambImg.width / 2 <= 0) {
        score++;
        bamboosReset();
      }
    }
        
    bat.drop();
  }
  
  if(!bat.life)
    paused = true;
    
  fill(255, 150);
  textSize(15);
  text("Score: ", 15, 25);
  text(score, 65, 25);
  
  float a = amp.analyze();
  if(a > 0.2) {
    if(!paused && bat.life) {
      bat.up();
    } else if(paused && bat.life) {
      paused = false;
    } else {
      bat.reset();
      bamboosReset();
      paused = true;
      score = 0;
    }
  }
}

void keyPressed() {
  if(key == 'p' || key == 'P') {
    paused = true;
  }
}

void bamboosReset() {
  float yoff = random(bambImg.height / 2);
  bamboos[0].pos.set(width + bambImg.width / 2, yoff);
  bamboos[1].pos.set(width + bambImg.width / 2, yoff + bambImg.height + 100);
}