class Bullet extends Mover implements Movable {
  Bullet(float x, float y, float speed, float direction) {
    super(x,y,speed,direction);
    radius = 10;
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
  void show() {
    pushMatrix();
    translate(x,y);
    fill(0,255,255);
    noStroke();
    ellipse(0,0,radius*2,radius*2);
    popMatrix();
  }
  void setDirection(float newDirection) {
    direction = newDirection;
  }
  void setSpeed(float newSpeed) {
    speed = newSpeed;
  }
}
