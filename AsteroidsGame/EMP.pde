class EMP extends Mover implements Movable {
  
  EMP(float x, float y) {
    super(x,y);
    radius = 0;
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
  
  float getDirection() {
    return 0;
  }
  
  float getSpeed() {
    return 0;
  }
  
  void show() {
    pushMatrix();
    translate(x,y);
    noFill();
    stroke(0,255,255);
    strokeWeight(8);
    ellipse(0,0,radius*2,radius*2);
    popMatrix();
  }
  
  void expand() {
    radius = radius + 10;
  }
  
  void reset() {
    radius = 0;
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
