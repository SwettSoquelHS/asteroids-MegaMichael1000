  /*
  Spaceship class
    Should extend Mover class and implement show.
    You may add additional methods to this class, for example "rotate" and "accelerate" 
    might be useful.
*/
class Spaceship extends Mover implements Movable {
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
  void show() {
    rectMode(CORNER);
    pushMatrix();
    translate(x,y);
    rotate(radians(direction));
    noStroke();
    fill(#8800FF);
    rect(-30,-20,55,40);
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
    if (x < 0)
      x = 0;
    if (y < 0)
      y = 0;
    if (x > width)
      x = width;
    if (y > height)
      y = height;
  }
}
