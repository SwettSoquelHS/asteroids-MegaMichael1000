/*
  Asteroid class
    Should extend Mover class and implement show.
    
    Initially, your asteroid may just be a simple circle or square
    but the final program should use "beginShap(), vertex(), and endShape()"
    to render the asteroid.
*/
class Asteroid extends Mover implements Movable {
  
  Asteroid(float x, float y, float speed, float direction) {
    super(x,y,speed,direction);
    radius = (float)(15*Math.random()+35);
   // radius = radius * 2;
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
    fill(125);
    ellipse(0,0,radius*2,radius*2);
    popMatrix();
  }
  void setSpeed(float newSpeed) {
    speed = newSpeed;
  }
  void setDirection(float newDirection) {
    direction = newDirection;
  }
}
