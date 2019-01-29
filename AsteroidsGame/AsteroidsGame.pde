/* * * * * * * * * * * * * * * * * * * * * * *
 Class variable declarations here
 */
Spaceship player1;
Asteroid[] asteroids;
Star[] starField;


/*
  Track User keyboard input
 */
boolean ROTATE_LEFT;  //User is pressing <-
boolean ROTATE_RIGHT; //User is pressing ->
boolean MOVE_FORWARD; //User is pressing ^ arrow
boolean SPACE_BAR;    //User is pressing space bar
float playerSpeed;
float playerDirection;
float asteroidX;
float asteroidY;
float asteroidSpeed;
float asteroidDirection;

/* * * * * * * * * * * * * * * * * * * * * * *
  Initialize all of your variables and game state here
 */
public void setup() {
  size(1280, 800);
  
  //initialize your asteroid array and fill it
  asteroids = new Asteroid[10];
  for (int i=0; i<asteroids.length; i++) {
    asteroidX = (float)((width-100)*Math.random()+50);
    asteroidY = (float)((height-100)*Math.random()+50);
    asteroidSpeed = (float)(3*Math.random()+2);
    asteroidDirection = (float)(360*Math.random());
    asteroids[i] = new Asteroid(asteroidX, asteroidY, asteroidSpeed, asteroidDirection);
  }
  
  //initialize ship
  player1 = new Spaceship(width/2,height/2,0,0);
  
  //initialize starfield
  starField = new Star[50];
  for (int i=0; i<starField.length; i++) {
    starField[i] = new Star();
  }
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
  player1.show();
  
  //Check bullet collisions
  //TODO: Part III or IV - for not just leave this comment

  //TODO: Part II, Update each of the Asteroids internals
  for (int i=0; i<asteroids.length; i++) {
    asteroids[i].update();
  }
  //Check for asteroid collisions against other asteroids and alter course
  for (int i=0; i<asteroids.length; i++) {
    if (asteroids[i].collidingWithEdgeX()) {
      asteroids[i].setDirection(180-asteroids[i].getDirection());
    }
    if (asteroids[i].collidingWithEdgeY()) {
      asteroids[i].setDirection(asteroids[i].getDirection()*-1);
    }
  }

  //Draw asteroids
  for (int i=0; i<asteroids.length; i++) {
    asteroids[i].show();
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
  player1.update();
  
  //Check for ship collision agaist asteroids
  //TODO: Part II or III

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
  }
}

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
