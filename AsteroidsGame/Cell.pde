class Cell extends Mover implements Movable {
  protected int value;
  
  Cell(float x, float y) {
    super(x,y);
    radius = 20;
  }
  
  float getX() {
    return x;
  }
  
  float getY() {
    return y;
  }
  
  float getRadius() {
    return radius;
  }
  
  int getValue() {
    return value;
  }
  
  float getDirection() {
    return 0;
  }
  
  float getSpeed() {
    return 0;
  }
  
  void newValue() {
    value = (int)random(10,21);
  }
  
  void show() {
    pushMatrix();
    translate(x,y);
    fill(255,255,0);
    stroke(80);
    strokeWeight(4);
    ellipse(0,0,radius*2,radius*2);
    popMatrix();
  }
  
  void setX(float newX) {
    x = newX;
  }
  
  void setY(float newY) {
    y = newY;
  }
  
  void setDirection(float direction) {}
  void setSpeed(float speed) {}
}
