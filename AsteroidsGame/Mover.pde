/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 All objects in this world that move must implemnt the Movalbe interface.
 */
interface Movable {
  /*
    Return the x location of the Movable
   */
  float getX();

  /*
    Return the y location of the Movable
   */
  float getY();

  /*
    Return the direction of the Movable in degrees.
   */
  float getDirection();

  /*
   Return the speed of the Movable.
   The speed you use is a relative value and will
   feel different for different frame rates. For example,
   if frameRate is set to 48, then a speed of 1 would move 48 pixels 
   per second.
   */
  float getSpeed();

  /*
   Return the radius of influence. If you could draw a circle
   around your object, then what would this radius be.
   */
  float getRadius();

  /* 
   Sets the direction of the Movable
   */
  void setDirection(float newDirectionInDegrees);

  /* 
   Sets the speed of the Movable
   */
  void setSpeed(float newSpeed);

  /*
   Update the internals of the instance
   */
  void update(); 

  /*
    Display the isntance
   */
  void show();

  /*
   Return true if the instance of Movable is "colliding with" 
   the movable referred to by object.  *Note* An object should not
   be able to collide with iteself.
   */
  boolean collidingWith(Movable object);
}
//END OF Movable Interface




/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 Abstract base class Mover 
 */
abstract class Mover implements Movable {

  protected float x, y;
  protected float speed;
  protected float direction;
  protected int myColor;
  protected float radius;  

  /*
    Default Mover, not actually moving and directionless
  */
  Mover(float x, float y) {
    //The line below shows how we can 
    //link this constructor to the constructor below through "this"
    this(x, y, 0, 0);  
  }

  /*
    Mover constructor specifying x, y position along with its speed and
    direction (in degrees)
  */
  Mover(float x, float y, float speed, float direction) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.direction = direction;
    myColor = 225;
    radius = 0.0;
  }

  /*
    Most of your movalbe objects should follow this pattern.
   */
  void update() {
    x = x + speed*(float)Math.cos(radians(direction));
    y = y + speed*(float)Math.sin(radians(direction));
  }



  /*
    Save this for your subclasses to override.
    but notice how it is tagged with abstract, meaning 
    it is incomplete. (It's like an I.O.U.)
   */
  abstract void show();


  /*
    TODO: Part 4: Implement collision detection
   */
  boolean collidingWith(Movable object) {
     float distance = dist(x, y, object.getX(), object.getY());
     boolean touching = distance < (radius + object.getRadius());
     return touching; 
  }
  
  boolean nearCollidingWith(Movable object) {
     float distance = dist(x, y, object.getX(), object.getY());
     boolean touching = distance < (radius + object.getRadius())+1;
     return touching; 
  }
  
  boolean collidingWithEdgeX() {
     boolean leftedge = x + 300 <= 0;
     boolean rightedge = x - 300 >= width;
     return leftedge||rightedge;
  }
  
  boolean collidingWithEdgeY() {
     boolean topedge = y + 300 <= 0;
     boolean bottomedge = y - 300 >= height;
     return topedge||bottomedge;
  }
  
  //TODO: Part I: implement the methods of Moveable interface -leftedge||rightedge|| delete this comment
}
