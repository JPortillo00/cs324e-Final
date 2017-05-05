import java.util.Random;
Random randint = new Random();
Player player;
import ddf.minim.*;
Minim minim;
AudioPlayer audio;

import processing.serial.*;
Serial myPort;

int s;
int startvalue;
int counter;
boolean N;
ArrayList<Platform> hubArea = new ArrayList<Platform>();
ArrayList<PlatParticles> platParticles = new ArrayList<PlatParticles>();
ArrayList<Platform> blocks1 = new ArrayList<Platform>();
ArrayList<Platform> blocks2 = new ArrayList<Platform>();
ArrayList<Platform> blocks3 = new ArrayList<Platform>();
ArrayList<Platform> blocks4 = new ArrayList<Platform>();
ArrayList<Platform> blocks5 = new ArrayList<Platform>();
ArrayList<Particles> particles = new ArrayList<Particles>();
//ArrayList<StationaryBlock> blocks=new ArrayList<StationaryBlock>();
ArrayList<Door> arraydoors= new ArrayList<Door>();
int openDoor = 0;
float respawnLocationx, respawnLocationy;
float flash = 0;
float movingValuex;
boolean moveLimit;

void setup(){
  size(1280, 720);
  
    //arduino code
  myPort = new Serial(this, "COM1", 9600);
  myPort.bufferUntil('\n'); 
  
  movingValuex = 0;
  buttoncolor = color(102);
  highlight = color(51); 
  button[0] = new RectButton(640, 300, 85, 30, buttoncolor, highlight, "Resume");
  button[1] = new RectButton(640, 350, 125, 30, buttoncolor, highlight, "New Game");
  button[2] = new RectButton(640, 400, 60, 30, buttoncolor, highlight, "Exit");
  //audiofile
  minim = new Minim(this);
  audio = minim.loadFile("TYMELAPSE - We Became Strangers.. Again.wav");
  audio.play();

  startvalue = second();
  counter = 0;
  N = false;
  
  player=new Player();
  player.x = 200;
  player.y = 700;
  player.w = 10;
  player.h = 10;
  player.vy=0;
  rectMode(CENTER);
  player.moveSpeed=3;
  player.jumpSpeed=8;
  
  
  hubArea.add(new Platform(width/2, 750, 80, 600, false, false));
  hubArea.add(new Platform(width/2 - 80, 850, 80, 600, false, false));
  hubArea.add(new Platform(width/2 + 80, 850, 80, 600, false, false));
  hubArea.add(new Platform(width/2 + 160, 950, 80, 600, false, false));
  hubArea.add(new Platform(width/2 - 160, 950, 80, 600, false, false));
  hubArea.add(new Platform(640,720,width,10, false, false)); 
  print(width / 2);
  
  blocks1.add(new Platform(200, 300, 60, 20, false, false));
  blocks1.add(new Platform(300, 400, 60, 20, false, false));
  blocks1.add(new Platform(400, 500, 60, 20, false, false));
  blocks1.add(new Platform(500, 600, 60, 20, false, false));
  blocks1.add(new Platform(600, 700, 60, 20, false, false));
  blocks1.add(new Platform(700, 600, 60, 20, false, false));
  blocks1.add(new Platform(800, 500, 60, 20, false, false));
  blocks1.add(new Platform(900, 400, 60, 20, false, false));
  blocks1.add(new Platform(1000, 500, 60, 20, false, false));
  blocks1.add(new Platform(1100, 600, 60, 20, false, false));
  blocks1.add(new Platform(1200, 500, 60, 20, false, false));
  blocks1.add(new Platform(100, 200, 60, 20, false, false));
  
  
  blocks2.add(new Platform(0, 200, width - 100, 20, false, false));
  blocks2.add(new Platform(1280, 200, width - 100, 20, false, false));
  blocks2.add(new Platform(width/2, 600, 100, 20, true, false));
  blocks2.add(new Platform(width/2, 400, 100, 20, true, true));
  blocks2.add(new Platform(1100, 700, 100, 20, false, false));
  
  blocks3.add(new Platform(100, 200, 300, 20, false, false));
  blocks3.add(new Platform(300, 400, 30, 20, false, false));
  blocks3.add(new Platform(200, 500, 30, 20, false, false));
  blocks3.add(new Platform(100, 600, 30, 20, false, false));
  blocks3.add(new Platform(width /2, 600, 30, 20, true, true));
  blocks3.add(new Platform(1100, 700, 100, 20, false, false));

  
  arraydoors.add(new Door(width/2,420));
  arraydoors.add(new Door(width/2 - 80, 520));
  arraydoors.add(new Door(width/2 + 80, 520));
  arraydoors.add(new Door(width/2 + 160,620));
  arraydoors.add(new Door(width/2 - 160,620));
  for (int i=0;i<arraydoors.size();i++) {
    Door d=arraydoors.get(i);
    d.doorNum = i + 1;
  }
    
  
  rectMode(CENTER);

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
  if (flash > 0){
    flash -= 1;
  }
  background(flash);
  if (openDoor == 0) {
    
    player.playerMove();
    player.display();
    particles.add(new Particles(0, 0, 2));
    
    
    for (int i=0;i<hubArea.size();i++) { 
      //displays all blocks and checks if they are colliding with the player
      Platform b=hubArea.get(i);
      platParticles.add(new PlatParticles(b.x, b.y, b.w, b.h, b.moving, b.reversed));
      for (int j = 0; j < platParticles.size(); j ++) {
        PlatParticles particle = platParticles.get(j);
        particle.display();
        randFloaty = random(0, .005);
        randFloatx = random(-.01, .01);
        particle.applyForces(randFloatx, randFloaty);
        if (particle.dead()) {
          platParticles.remove(j);
        }
      }
      player.collide(b.x, b.y, b.w, b.h);
      platParticles.get(i).display();
      b.display();
    }
    for (int i=0;i<arraydoors.size();i++) { 
      Door d=arraydoors.get(i);
      //player.collide(d.x, d.y, d.w, d.h);
      d.display();
      if (keyCode == UP && player.x <= d.x + d.w && player.x >= d.x - d.w) {
        if (keyCode == UP && player.y <= d.y + d.h && player.y >= d.y - d.h) {
          print ("Door", str(i + 1), "found");
          openDoor = d.doorNum;
          player.x = 100;
          player.y = 50;
          respawnLocationx = player.x;
          respawnLocationy = player.y;
          }
        }
      }
    for (int i = 0; i < particles.size(); i ++) {
      Particles particle = particles.get(i);
      particle.display();
      randFloaty = random(0, .01);
      randFloatx = random(-.01, .01);
      particle.applyForces(randFloatx, randFloaty);
      if (particle.dead()) {
        particles.remove(i);
      }
    }
  }
   
   
  //level 1
  if (openDoor == 1) {
    player.playerMove();
    player.display();
    particles.add(new Particles(0, 0, 2));
    
    if (player.y >= 710) {
      player.x = respawnLocationx;
      player.y = respawnLocationy;
      flash = 255;
    }
    
    
    
    for (int i=0;i<blocks1.size();i++) { //displays all blocks and checks if they are colliding with the player
    //displays all blocks and checks if they are colliding with the player
      Platform b=blocks1.get(i);
      platParticles.add(new PlatParticles(b.x, b.y, b.w, b.h, b.moving, b.reversed));
      for (int j = 0; j < platParticles.size(); j ++) {
        PlatParticles particle = platParticles.get(j);
        particle.display();
        randFloaty = random(0, .005);
        randFloatx = random(-.01, .01);
        particle.applyForces(randFloatx, randFloaty);
        if (particle.dead()) {
          platParticles.remove(j);
        }
      }
      player.collide(b.x, b.y, b.w, b.h);
      platParticles.get(i).display();
      b.display();
    }
    
    for (int i = 0; i < particles.size(); i ++) {
      Particles particle = particles.get(i);
      particle.display();
      randFloaty = random(0, .01);
      randFloatx = random(-.01, .01);
      particle.applyForces(randFloatx, randFloaty);
      if (particle.dead()) {
        particles.remove(i);
      }
    }
  }
  
  //level 2
  if (openDoor == 2) {
    
        myPort.write(""+6);


    player.playerMove();
    player.display();
    particles.add(new Particles(0, 0, 2));
    
    if (player.y >= 710) {
      player.x = respawnLocationx;
      player.y = respawnLocationy;
      flash = 255;
    }
    
    
    
    for (int i=0;i<blocks2.size();i++) { //displays all blocks and checks if they are colliding with the player
    //displays all blocks and checks if they are colliding with the player
      Platform b=blocks2.get(i);
      platParticles.add(new PlatParticles(b.x, b.y, b.w, b.h, b.moving, b.reversed));
      for (int j = 0; j < platParticles.size(); j ++) {
        PlatParticles particle = platParticles.get(j);
        particle.display();
        
        randFloaty = random(0, .005);
        randFloatx = random(-.01, .01);
        particle.applyForces(randFloatx, randFloaty);
        if (particle.dead()) {
          platParticles.remove(j);
        }
      }
      player.collide(b.x, b.y, b.w, b.h);
      platParticles.get(i).display();
      
      if (b.x > b.snapshotx + 200) {
       b.movementValue = -1;
        
      }else if (b.x < b.snapshotx - 200) {
        b.movementValue = 1;
      }
      
      b.display();
       
    }
    
    for (int i = 0; i < particles.size(); i ++) {
      Particles particle = particles.get(i);
      particle.display();
      randFloaty = random(0, .01);
      randFloatx = random(-.01, .01);
      particle.applyForces(randFloatx, randFloaty);
      if (particle.dead()) {
        particles.remove(i);
      }
    }
  }
  
  //level 3
  if (openDoor == 3) {
    
    player.playerMove();
    player.display();
    particles.add(new Particles(0, 0, 2));
    
    if (player.y >= 710) {
      player.x = respawnLocationx;
      player.y = respawnLocationy;
      flash = 255;
    }
    
    
    
    for (int i=0;i<blocks3.size();i++) { //displays all blocks and checks if they are colliding with the player
    //displays all blocks and checks if they are colliding with the player
      Platform b=blocks3.get(i);
      platParticles.add(new PlatParticles(b.x, b.y, b.w, b.h, b.moving, b.reversed));
      for (int j = 0; j < platParticles.size(); j ++) {
        PlatParticles particle = platParticles.get(j);
        particle.display();
        
        randFloaty = random(0, .005);
        randFloatx = random(-.01, .01);
        particle.applyForces(randFloatx, randFloaty);
        if (particle.dead()) {
          platParticles.remove(j);
        }
      }
      player.collide(b.x, b.y, b.w, b.h);
      platParticles.get(i).display();
      
      if (b.x > b.snapshotx + 520) {
       b.movementValue = -1;
        
      }else if (b.x < b.snapshotx - 520) {
        b.movementValue = 1;
      }
      
      b.display();
       
    }
    
    for (int i = 0; i < particles.size(); i ++) {
      Particles particle = particles.get(i);
      particle.display();
      randFloaty = random(0, .01);
      randFloatx = random(-.01, .01);
      particle.applyForces(randFloatx, randFloaty);
      if (particle.dead()) {
        particles.remove(i);
      }
    }
    
    
    
  }
  
  if (openDoor == 4) {
    
  }
  
  if (openDoor == 5) {
    
  }
    
  if (paused){
    Paused();
  }
  
  
  
}

boolean holdLeft = false, holdRight = false, holdSprint = false, holdJump = false;
int jumpMax = 500;
boolean falling = false;
/*/
boolean doorbool(){
  for (int i=0;i<arraydoors.size();i++) {
    Door d=arraydoors.get(i);
    if player.x<d;
  }
}
/*/

void setSignal (boolean setTo) { 

  if (key == 'q'){
    holdSprint = setTo;  
  }
  
}
 
void keyPressed() {
  if (key==CODED && keyCode==LEFT && paused == false) player.vx=-1*player.moveSpeed; //move left
  if (key==CODED && keyCode==RIGHT && paused == false) player.vx=player.moveSpeed; //move right
  if (key == ' ' && player.vy==0 && paused == false) { //jump
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
}