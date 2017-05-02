import java.util.Random;
Random randint = new Random();
Player player;

int s;
int startvalue;
int counter;
boolean N;
ArrayList<Particles> particles = new ArrayList<Particles>();
timer time = new timer();

void setup(){
  size(1280, 720);
  //background(255);
  buttoncolor = color(102);
  highlight = color(51); 
  button[0] = new RectButton(640, 300, 85, 30, buttoncolor, highlight, "Resume");
  button[1] = new RectButton(640, 350, 125, 30, buttoncolor, highlight, "New Game");
  button[2] = new RectButton(640, 400, 60, 30, buttoncolor, highlight, "Exit");


  
  
  startvalue = second();
  counter = 0;
  N = false;
  
  //xpos = 600;
  //ypos = 800;
  //float x, float y, float w, float h
  player=new Player();
  player.x = width/2;
  player.y = width/2-200;
  player.w = 30;
  player.h = 30;
  player.vy=0;
  rectMode(CENTER);
  player.moveSpeed=3;
  player.jumpSpeed=8;
  /*for (int i = 0; i < 10; i ++){
    particles.add(new Particles(0, 0, 2));
    
    
  }*/
  
  //frameRate(24);
  
  
}

RectButton [] button = new RectButton[3];
boolean locked = false;
color currentcolor, buttoncolor, highlight;
boolean paused = false;

void update(int x, int y) {
  if (locked == false) {
    button[0].update();
    button[1].update();
    button[2].update();
  } else {
    locked = false;
  }
  if (mousePressed && paused) {
    if (button[0].pressed()) {
      paused = false;
    } else if (button[1].pressed()) {
      paused = false;
    } else if (button[2].pressed()) {
      exit();
    }
  }
}

void Paused() {
  update(mouseX, mouseY);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  stroke(255);
  fill(currentcolor);
  rect(640, 200, 150, 60);
  fill(255);
  text("Paused", 640, 200);
  button[0].display();
  button[1].display();
  button[2].display(); 
  rectMode(CORNER);
  textAlign(BASELINE);
}

float randFloaty = random(0, .01);
float randFloatx = random(0, .01);
void draw(){
  background(5);
  
  
  //player.display(0, ypos);
  player.playerMove();
  
  player.display();
  particles.add(new Particles(0, 0, 2));
  
  
  for (int i = 0; i < particles.size(); i ++) {
    Particles particle = particles.get(i);
    particle.display();
    randFloaty = random(0, .01);
    randFloatx = random(-.01, .01);
    particle.applyForces(randFloatx, randFloaty);
  }
  
  if (paused){
    Paused();
  }

  
  
 


  
  
  
  
  
  
  
  
  
  
  
  /*time.createnumber();
  time.displaynumber();*/  
 }
  

   
void gameOver()  {
  background(255);
  textSize(50);
  fill(255,0,0);
  text("GAME OVER", 510, 500);
  text("SCORE: " + str(time.s), 520, 600);
  noLoop();
  
  
}


boolean holdLeft = false, holdRight = false, holdSprint = false, holdJump = false;
int jumpMax = 500;
boolean falling = false;

void setSignal (boolean setTo) { 
  
  /*if (keyCode == LEFT || key == 'a') { 
    holdLeft = setTo;
  } 
  if (keyCode == RIGHT || key == 'd'){ 
    holdRight = setTo;
  }*/
  if (key == 'q'){
    holdSprint = setTo;  
  }
  
  /*if (key == ' ' || keyCode == UP) {
    
    holdJump = setTo;
  }*/
  
  
}
 
void keyPressed() {
  if (key==CODED && keyCode==LEFT && paused == false) player.vx=-1*player.moveSpeed; //move left
  if (key==CODED && keyCode==RIGHT && paused == false) player.vx=player.moveSpeed; //move right
  if (key==CODED && keyCode==UP && player.vy==0 && paused == false || key == ' ' && player.vy==0 && paused == false) { //jump
    player.y-=player.jumpSpeed;
    player.vy=-1*player.jumpSpeed;
  }
  
  
  if (key == 'p' || key =='P'){
    paused = !paused;
    setSignal(false);  
  }else if (paused == false){
  setSignal(true);
  }

  
}
 
void keyReleased() { 
  if (key==CODED && keyCode==LEFT && player.vx<0) player.vx=0;
  if (key==CODED && keyCode==RIGHT && player.vx>0) player.vx=0;
  setSignal(false);
  
  /*if ((key == ' ' || keyCode == UP)&& paused == false) {
    
    falling = true;
    
  }*/
  
  
  /*if (key != ' ' || keyCode != UP) {
    initialSpd = .5;
    sprintSpeed = 3;
    
    
  }*/
  
    //if (ypos > 400) { 
    //  ypos -=20;
    //} else {
    //  ypos+=20;
    //}
  
}