class MovingBlock {
  float x, y, w, h, vx, vy;
  float moveSpeed;
  float jumpSpeed;
  
  MovingBlock(float x, float y, float w, float h) {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
  }
  void move() { //moves the player
    x+=vx;
    y+=vy;
    if (y>=height-h/2) {
      y=height-h/2;
      vy=0;  //floor
    } else if (y<height) {
      vy+=0.32;  //gravity
    }
  }
  void display() { //draws the player
    fill(255, 100, 0);
    rect(x, y, w, h);
  }
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