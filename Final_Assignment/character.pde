int animationTimer = 0;
int animationTimerValue = 50; 

/*float xpos;
float ypos;
float vx = .03;
float vy= .03;*/
//float sprintSpeed = 3;
//float initialSpd = .5;
//boolean paused = false; 


class Player {
  float x, y, w, h, vx, vy;
  float moveSpeed;
  float jumpSpeed;
  
  Player() {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
  }
  
  void playerMove() { //moves the player
    x+=vx;
    y+=vy;
    if (y>=height-h/2) {
      y=height-h/2;
      vy=0;  //floor
    } else if (y<height) {
      vy+=0.32;  //gravity
    }
  }

  
  //Sprite Code
  /*PImage[] playerSprite;
  int imgCount;
  int frame;*/
  
  /*Player(String imgName, int count) {
    imgCount = count;
    playerSprite = new PImage[imgCount];
    
    for ( int i = 0; i < imgCount; i ++) {
      String filename = imgName + nf(i+1, 2) + ".gif";
      playerSprite[i] = loadImage(filename); 
    }  
  }*/
  
  
  void display() {
    fill(0);
    rect(x, y, w, h);
  }
  /*void display() {
    //frame = (frame+1) % imgCount;
    image(playerSprite[frame], x, y);
    if ((millis() - animationTimer) >= animationTimerValue) {
     frame = (frame + 1) % imgCount; 
     animationTimer = millis();
    }
  }
  
  int getWidth() {
    return playerSprite[0]. width;
  }*/
  //Sprite Code
    void collide(float bx, float by, float bw, float bh) { //takes info of stationary block
    if (collidedWithBlock(bx, by, bw, bh)) {
      float dx=abs(bx-x);
      float dy=abs(by-y);
      float gapx=dx-(w+bw)/2;
      float gapy=dy-(h+bh)/2;
      if (gapx<=gapy) {
        if (vy<=0 && y>by+bh/2) { //hit bottom of block
          y+=jumpSpeed/2;
          vy=0;
        } else if (vy>0 && y<by+bh/2) { //hit top of block
          y=by-((h+bh)/2-1);
          vy=0;
        }
      } else {
        if (vx<0 && x>bx) {  //hit right of block
          x=bx+(w+bw)/2;
        }
        if (vx>0 && x<bx) { //hit left of block
          x=bx-(w+bw)/2;
        }
      }
    }
  }
  boolean collidedWithBlock(float bx, float by, float bw, float bh) { //returns true if the player is touching the block
    float dx=abs(bx-x);
    float dy=abs(by-y);
    return dx<(bw+w)/2 && dy<(bh+h)/2;
  }
}

/*void playerMove() {
 
  //speed = 10 ; 
  if (holdLeft) { 
    if (initialSpd >= 3) {
      initialSpd = 3;
      xpos -= initialSpd; 
    }
    else {
      initialSpd += vx;
      xpos -= initialSpd;      
    }
    
    
  } 
  if (holdRight) { 
    if (initialSpd >= 3) {
      initialSpd = 3;
      xpos += initialSpd;
    }
    
    else {
      initialSpd += vx;
      xpos += initialSpd;
    }
    
    //xpos += initialSpd*speed;
    
  } 
  
  if (holdRight && holdSprint) {
    sprintSpeed+= vx;
    xpos += sprintSpeed;
    
    
  }
  if (holdLeft && holdSprint) {
    sprintSpeed+= vx;
    xpos -= sprintSpeed;
    
    
  }
  
  if (holdJump && ypos>= jumpMax && falling == false) { 
    
    ypos = ypos-20;
    if (ypos <= jumpMax) {
      
      falling = true;
      
    }
    
  }
 
  if (ypos >= 685) {
    ypos = 685;
    falling = false;
    
  }
  
  else {
    
    ypos = ypos+10;
    
    
  }
  
}*/

class Particles extends Player {
  float partx, party;
  float vx, vy;
  float r;
  float f;
  float a;
  float m = 1.0;
  float ks = 0.1;
  float kd = 0.1;
  float lifespan;
  
  Particles(float _vx, float _vy, float _r) {
    lifespan = 255;
    partx = player.x;
    party = player.y;
    vx = _vx;
    vy = _vy;
    r = _r;
  }
  void applyForces(float _fx, float _fy) {
    
    
    vx += _fx;
    vy += _fy;
    party -= vy;
    partx += vx;
    lifespan -= 1;
    
  }
  void display() {
    fill(255, lifespan);
    ellipse(partx, party, r, r);
  }
  boolean dead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      
      return false;
    }
    
    
  }
  
  
}