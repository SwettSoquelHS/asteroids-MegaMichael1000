  /*
  Spaceship class
    Should extend Mover class and implement show.
    You may add additional methods to this class, for example "rotate" and "accelerate" 
    might be useful.
*/
class Spaceship extends Mover implements Movable {
  protected int shield;
  protected boolean OVERDRIVE;
  protected boolean MAX_OVERDRIVE;
  protected int shieldTime;
  
  Spaceship(float x, float y, float speed, float direction) {
    super(x,y,speed,direction);
    radius = 30;
  }
  float getX() {
    return x;
  }
  float getY() {
    return y;
  }
  float getDirection() {
    return direction;
  }
  float getRadius() {
    return radius;
  }
  float getSpeed() {
    return speed;
  }
  boolean overdrive() {
    return OVERDRIVE;
  }
  boolean maxOverdrive() {
    return MAX_OVERDRIVE;
  }
  int shieldLevel() {
    return shield;
  }
  void show() {
    rectMode(CORNER);
    pushMatrix();
    translate(x,y);
    rotate(radians(direction));
    if (shield > 0) {
      noFill();
      switch (shield) {
        case 1:
          stroke(0,125,255,85);
          break;
        case 2:
          stroke(0,125,255,170);
          break;
        case 3:
          stroke(0,125,255);
          break;
      }
      strokeWeight(5);
      ellipse(0,0,radius*2,radius*2);
    }
    noStroke();
    fill(#8800FF);
    rect(-30,-20,55,40);
    if (OVERDRIVE)
      fill(0,0,255);
    else if (MAX_OVERDRIVE)
      fill(0,255,255);
    else
      fill(100);
    rect(20,-20,10,40,0,10,10,0);
    rect(5,-5,10,10);
    fill(#5500AA);
    rect(-25,-15,25,30);
    popMatrix();
  }
  void setSpeed(float newSpeed) {
    speed = newSpeed;
  }
  void setDirection(float newDirection) {
    direction = newDirection;
  }
  void update() {
    x = x + speed*(float)Math.cos(radians(direction));
    y = y + speed*(float)Math.sin(radians(direction));
    if (shield > 0 && millis() - shieldTime >= 60000) {
      shield--;
      shieldTime = millis();
      if (shield == 0)
        radius = 30;
    }
    if (x < 0)
      x = 0;
    if (y < 0)
      y = 0;
    if (x > width)
      x = width;
    if (y > height)
      y = height;
  }
  void overdriveOn() {
    OVERDRIVE = true;
  }
  void overdriveOff() {
    OVERDRIVE = false;
    MAX_OVERDRIVE = false;
  }
  void maxOverdriveOn() {
    MAX_OVERDRIVE = true;
  }
  void shieldUp() {
    if (shield < 3) {
      shield++;
      shieldTime = millis();
      radius = 40;
    }
  }
  void shieldDown() {
    if (shield > 0) {
      shield--;
      if (shield == 0) {
        radius = 30;
      }
    }
  }
}
