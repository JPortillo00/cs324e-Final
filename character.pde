int animationTimer = 0;
int animationTimerValue = 50; 
Player player;
float xpos;
float ypos;
int speed = 3;
boolean paused = false; 


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
    image(playerSprite[frame], 630, ypos);
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
    xpos += speed;
    
  } 
  if (holdRight) { 
    xpos -= speed;
    
  } 
  
  if (holdRight && holdSprint) {
    speed = 4;
    xpos -= speed;
    
    
  }
  if (holdLeft && holdSprint) {
    speed = 4;
    xpos += speed;
    
    
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