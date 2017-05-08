
RectButton [] pbutton = new RectButton[3];
RectButton [] mbutton = new RectButton[2];
boolean locked = false;
color currentcolor, buttoncolor, highlight;
boolean paused = false;

void p_update() {
  if (locked == false) {
    pbutton[0].update();
    pbutton[1].update();
    pbutton[2].update();
  } else {
    locked = false;
  }
  if (mousePressed && state == PAUSE) {
    if (pbutton[0].pressed()) {
      paused = false;
      state = GAME;
    } else if (pbutton[1].pressed()) {
      paused = true;
      state = MAIN_MENU;
      delay(500);
    } else if (pbutton[2].pressed()) {
      exit();
    }
    
  }
}

void m_update(){
   if (locked == false) {
    mbutton[0].update();
    mbutton[1].update();
  } else {
    locked = false;
  }
  if (mousePressed && state == MAIN_MENU) {
    
    if (mbutton[0].pressed()) {
      
      paused = false;
      state = GAME;
      player.x = 100;
      player.y = 50;
      respawnLocationx = player.x;
      respawnLocationy = player.y;
      
    } else if (mbutton[1].pressed()) {
      exit();
    }
  }
}

void Paused() {
  p_update();
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  stroke(255);
  fill(currentcolor);
  rect(640, 200, 150, 60);
  fill(255);
  text("Paused", 640, 200);
  pbutton[0].display();
  pbutton[1].display();
  pbutton[2].display(); 
  rectMode(CORNER);
  textAlign(BASELINE);
}

void menu(){ 
  m_update();
  fill(0);
  rect(0,0,width,height);
  rectMode(CENTER);

  textAlign(CENTER, CENTER);
  stroke(255);
  fill(255);
  textSize(60);
  text("TITLE",width/2,200);
  textSize(20);
  text("Use LEFT ARROW and RIGHT ARROW keys to move.",width/2,500);
  text("Use UP ARROW key to move to enter portals.",width/2,525);
  text("Use SPACE BAR to jump.",width/2,550);
  text("Use 'm' to toggle mute and 'p' to toggle the pause menu. ",width/2,475);
  
  
  //rect(640, 200, 150, 60);
  //fill(255);
  //text("Paused", 640, 200);
  mbutton[0].display();
  mbutton[1].display();
  rectMode(CORNER);
  textAlign(BASELINE);
  player.playerMove();
  player.display();
  particles.add(new Particles(0, 0, 3));
  
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