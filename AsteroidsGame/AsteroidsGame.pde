import java.util.ArrayList;

/* * * * * * * * * * * * * * * * * * * * * * *
 Class variable declarations here
 */
Spaceship player1;
Star[] starField;
ArrayList<Bullet> bullets;
ArrayList<Asteroid> asteroids;

/*
  Track User keyboard input
 */
boolean ROTATE_LEFT;  //User is pressing <-
boolean ROTATE_RIGHT; //User is pressing ->
boolean MOVE_FORWARD; //User is pressing ^ arrow
boolean SPACE_BAR;    //User is pressing space bar
boolean FIRE;
float playerSpeed;
float playerDirection;
float asteroidX;
float asteroidY;
float asteroidSpeed;
float asteroidDirection;
float s1;
float s2;
float d1;
float d2;
int fireDelay;
int asteroidsMissing = 0;
int asteroidCap = 10;

/* * * * * * * * * * * * * * * * * * * * * * *
  Initialize all of your variables and game state here
 */
public void setup() {
  size(1280, 800);
  
  bullets = new ArrayList<Bullet>();
  asteroids = new ArrayList<Asteroid>();
  
  //initialize your asteroid array and fill it
  asteroids = new ArrayList<Asteroid>();
  for (int i=0; i<asteroidCap; i++) {
    asteroidX = (float)((width-100)*Math.random()+50);
    asteroidY = (float)((height-100)*Math.random()+50);
    asteroidSpeed = (float)(3*Math.random()+2);
    asteroidDirection = (float)(360*Math.random());
    Asteroid asteroid = new Asteroid(asteroidX, asteroidY, asteroidSpeed, asteroidDirection);
    asteroids.add(asteroid);
  }
  
  //initialize ship
  player1 = new Spaceship(width/2,height/2,0,0);
  
  //initialize starfield
  starField = new Star[50];
  for (int i=0; i<starField.length; i++) {
    starField[i] = new Star();
  }
  fireDelay = 0;
}


/* * * * * * * * * * * * * * * * * * * * * * *
  Drawing work here
 */
public void draw() {
  //your code here
  background(0);
  for (int i=0; i<starField.length; i++) {
    starField[i].show();
  }
  for (Object o: bullets) {
    Bullet b = (Bullet)o;
    b.show();
    b.update();
  }
  player1.show();
  
  //Check bullet collisions
  hitCheck();

  //TODO: Part II, Update each of the Asteroids internals
  for (Object o: asteroids) {
    Asteroid a = (Asteroid)o;
    a.show();
    a.update();
  }
  //Check for asteroid collisions against other asteroids and alter course
  for (Object o: asteroids) {
    Asteroid a = (Asteroid)o;
    if (a.collidingWithEdgeX()) {
      a.setDirection(180-a.getDirection());
    }
    if (a.collidingWithEdgeY()) {
      a.setDirection(a.getDirection()*-1);
    }
  }

  //Update spaceship
  playerSpeed = player1.getSpeed();
  playerDirection = player1.getDirection();
  if (MOVE_FORWARD) {
    if (player1.getSpeed() < 5) {
      player1.setSpeed(playerSpeed += 1);
    }
  } else {
    if (player1.getSpeed() > 0) {
      player1.setSpeed(playerSpeed -= 1);
    }
  }
  if (ROTATE_LEFT) {
    player1.setDirection(playerDirection -= 5);
  }
  if (ROTATE_RIGHT) {
    player1.setDirection(playerDirection += 5);
  }
  if (SPACE_BAR) {
    if (!FIRE && fireDelay == 0) {
      fire();
      FIRE = true;
      fireDelay = 0;
    }
  }
  player1.update();
  if (fireDelay > 0) {
    fireDelay--;
  }
  bulletCheck();
  //Check for ship collision agaist asteroids
  
  //Draw spaceship & and its bullets
  //TODO: Part I, for now just render ship
  //TODO: Part IV - we will use a new feature in Java called an ArrayList, 
  //so for now we'll just leave this comment and come back to it in a bit. 
  
  //Update score
  //TODO: Keep track of a score and output the score at the top right
}



/* * * * * * * * * * * * * * * * * * * * * * *
  Record relevent key presses for our game
 */
void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      ROTATE_LEFT = true;
    } else if ( keyCode == RIGHT ) {
      ROTATE_RIGHT = true;
    } else if (keyCode == UP) {
      MOVE_FORWARD = true;
    }
  }

  //32 is spacebar
  if (keyCode == 32) {  
    SPACE_BAR = true;
  }
}



/* * * * * * * * * * * * * * * * * * * * * * *
  Record relevant key releases for our game.
 */
void keyReleased() {  
  if (key == CODED) { 
    if (keyCode == LEFT) {
      ROTATE_LEFT = false;
    } else if ( keyCode == RIGHT ) {
      ROTATE_RIGHT = false;
    } else if (keyCode == UP) {
      MOVE_FORWARD = false;
    }
  }
  if (keyCode == 32) {
    SPACE_BAR = false;
    FIRE = false;
  }
}

void fire() {
  bullets.add(new Bullet(player1.getX(),player1.getY(),10,player1.getDirection()));
}

void bulletCheck() {
  for (int i=0; i<bullets.size(); i++) {
    Bullet b = (Bullet)bullets.get(i);
    if (b.getX()<-100 || b.getX()>width+100) {
      bullets.remove(i);
    }
    if (b.getY()<-100 || b.getY()>height+100) {
      bullets.remove(i);
    }
  }
}

void hitCheck() {
  for (int i=0; i<bullets.size(); i++) {
    Bullet b = (Bullet)bullets.get(i);
    for(int j=0; j<asteroids.size(); j++) {
      Asteroid a = (Asteroid)asteroids.get(j);
      if (b.collidingWith(a)) {
        asteroids.remove(j);
        bullets.remove(i);
        asteroidsMissing++;
      }
    }
  }
}
/*
void checkOnAsteroids() {
  for (int i=0; i<asteroids.length; i++) {
    Asteroid a1 = asteroids[i];
    for (int j=1; j<asteroids.length; j++) {
      Asteroid a2 = asteroids[j];
      if (a1 != a2 && a1.collidingWith(a2)) {

      }
    }
  }
}
*/
