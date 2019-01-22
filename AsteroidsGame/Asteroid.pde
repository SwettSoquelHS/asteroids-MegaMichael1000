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
  
  }
  void setSpeed(float newSpeed) {
  
  }
  void setDirection(float newDirection) {
  
  }
}
