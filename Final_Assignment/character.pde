int animationTimer = 0;
int animationTimerValue = 50; 
Player player;
float xpos;
float ypos;
float vx = .03;
float vy= .03;
float ax = 1.1;
float ay= 1.1;
float m;
float sprintSpeed = 3;
float initialSpd = .5;
//boolean paused = false; 


class Player {

  
  //Sprite Code
  PImage[] playerSprite;
  int imgCount;
  int frame;
  
  Player(String imgName, int count) {
    imgCount = count;
    playerSprite = new PImage[imgCount];
    
    for ( int i = 0; i < imgCount; i ++) {
      String filename = imgName + nf(i+1, 2) + ".gif";
      playerSprite[i] = loadImage(filename); 
    }  
  }
  
  void display(float xpos, float ypos) {
    //frame = (frame+1) % imgCount;
    image(playerSprite[frame], xpos, ypos);
    if ((millis() - animationTimer) >= animationTimerValue) {
     frame = (frame + 1) % imgCount; 
     animationTimer = millis();
    }
  }
  
  int getWidth() {
    return playerSprite[0]. width;
  }
  //Sprite Code
  
}

void playerMove() {
 
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
 
  
  
  
}