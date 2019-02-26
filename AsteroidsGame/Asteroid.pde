/*
  Asteroid class
    Should extend Mover class and implement show.
    
    Initially, your asteroid may just be a simple circle or square
    but the final program should use "beginShap(), vertex(), and endShape()"
    to render the asteroid.
*/
class Asteroid extends Mover implements Movable {
  protected float rot = random(TWO_PI);
  protected boolean noCollide = false;
  protected boolean frag;
  
  Asteroid(float x, float y, float speed, float direction, boolean frag) {
    super(x,y,speed,direction);
    radius = (float)(10*Math.random()+30);
    this.frag = frag;
    if (frag) {
      radius = radius / 2;
      noCollide = true;
    }
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
  
  boolean isNoCollide() {
    return noCollide;
  }
  
  boolean isFrag() {
    return frag;
  }
  
  void show() {
    pushMatrix();
    translate(x,y);
    rotate(rot);
    fill(255,0,0);
    noStroke();
    //ellipse(0,0,radius*2,radius*2);
    fill(125);
    stroke(80);
    strokeWeight(3);
    beginShape();
    vertex(0,1*radius);
    vertex(.707*radius,.707*radius);
    vertex(1*radius,0);
    vertex(.968*radius,-.25*radius);
    vertex(.707*radius,-.707*radius);
    vertex(0,-1*radius);
    vertex(-.707*radius,-.707*radius);
    vertex(-1*radius,0);
    vertex(-.866*radius,.5*radius);
    endShape(CLOSE);
    popMatrix();
  }
  void setSpeed(float newSpeed) {
    speed = newSpeed;
  }
  void setDirection(float newDirection) {
    direction = newDirection;
  }
  void allowCollisions() {
    noCollide = false;
  }
}
