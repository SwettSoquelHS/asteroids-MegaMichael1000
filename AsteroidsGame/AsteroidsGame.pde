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
boolean FIRE_READY;
boolean VALID_SPAWN;
boolean GAME;
boolean STARTUP;
boolean MENU;
boolean COLLISION;
boolean WAITING = false;
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
float startupTime;
int fireDelay;
int asteroidCap = 30;
int respawnCooldown;
int spawnZone;
int score;
int time;
int energy;
int power;

/* * * * * * * * * * * * * * * * * * * * * * *
  Initialize all of your variables and game state here
 */
public void setup() {
  MENU = true;
  GAME = true;
  respawnCooldown = (int)random(5)+5;
  startupTime = 180;
  score = 0;
  energy = 0;
  size(986, 655);
  bullets = new ArrayList<Bullet>();
  asteroids = new ArrayList<Asteroid>();
  //initialize your asteroid array and fill it
  asteroids = new ArrayList<Asteroid>();
  spawnZone = (int)random(4);
  switch (spawnZone) {
    case 0:
      asteroidX = (float)(width*Math.random());
      asteroidY = (float)(-200*Math.random()-100);
      asteroidDirection = (float)(45*Math.random()+45);
      break;
    case 1:
      asteroidX = (float)(width*Math.random());
      asteroidY = height+((float)(300*Math.random()+150));
      asteroidDirection = (float)(255*Math.random()+45);
      break;
    case 2:
      asteroidX = (float)(-200*Math.random()-100);
      asteroidY = (float)(height*Math.random());
      asteroidDirection = 180-(float)(135*Math.random()+45);
      break;
    case 3:
      asteroidX = width+((float)(200*Math.random()+150));
      asteroidY = (float)((height)*Math.random());
      asteroidDirection = (float)(135*Math.random()+45);
      break;
  }
  asteroidSpeed = (float)(2*Math.random()+1);
  Asteroid asteroid = new Asteroid(asteroidX, asteroidY, asteroidSpeed, asteroidDirection, false);
  asteroids.add(asteroid);
  
  //initialize ship
  player1 = new Spaceship(width/2,height/2,0,0);
  
  //initialize starfield
  starField = new Star[100];
  for (int i=0; i<starField.length; i++) {
    starField[i] = new Star();
  }
  fireDelay = 0;
}


/* * * * * * * * * * * * * * * * * * * * * * *
  Drawing work here
 */
public void draw() {
  if (!GAME) {
    sleep(3000);
    setup();
  }
  background(0);
  if (MENU) {
    fill(255);
    rectMode(CENTER);
    textAlign(CENTER);
    textSize(100);
    text("Asteroids",width/2,120);
    textSize(40);
    text("AP Computer Science - Michael Vollmer",width/2,220);
    fill(50);
    noStroke();
    rect(width/2,350,600,120);
    fill(0,255,0);
    textSize(100);
    text("Start Game",width/2,385);
    fill(255);
    textSize(40);
    text("Controls:",width/2,515);
    textSize(30);
    text("Up - Move        Left/Right - Steer        Space - Fire",width/2,575);
  } else if (STARTUP) {
    for (int i=0; i<starField.length; i++) {
      starField[i].show();
    }
    textSize(100);
    if (startupTime > 60) {
      fill(255,0,0);
      text("Get Ready!",width/2,height/2);
    } else {
      fill(0,255,0);
      text("GO!",width/2,height/2);
    }
    if (startupTime == 0) {
      STARTUP = false;
    } else {
      startupTime--;
    }
  } else {
    for (int i=0; i<starField.length; i++) {
      starField[i].show();
    }
    for (Object o: bullets) {
      Bullet b = (Bullet)o;
      b.show();
      b.update();
    }
    rectMode(CORNER);
    player1.show();
    
    //Check bullet collisions
    hitCheck();
  
    //TODO: Part II, Update each of the Asteroids internals
    for (Asteroid a1: asteroids) {
      a1.show();
      a1.update();
      COLLISION = false;
      for (Asteroid a2: asteroids) {
        if (a1 != a2 && a1.collidingWith(a2)) {
          COLLISION = true;
          if (!a1.isNoCollide() && !a2.isNoCollide()) {
            s1 = a1.getSpeed();
            s2 = a2.getSpeed();
            d1 = a1.getDirection();
            d2 = a2.getDirection();
            a1.setSpeed(s2);
            a1.setDirection(d2);
            a2.setSpeed(s1);
            a2.setDirection(d1);
          }
        }
      }
      if (!COLLISION && a1.isNoCollide()) {
        a1.allowCollisions();
      }
    }
    
    
    //Check for asteroid collisions against other asteroids and alter course
    for (int i=0; i<asteroids.size(); i++) {
      Asteroid a = asteroids.get(i);
      if (a.collidingWithEdgeX()) {
        asteroids.remove(i);
      }
      if (a.collidingWithEdgeY()) {
        asteroids.remove(i);
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
      if (FIRE_READY && fireDelay == 0) {
        fire();
        FIRE_READY = false;
        fireDelay = 15;
      }
    }
    player1.update();
    if (fireDelay > 0) {
      fireDelay--;
    }
    bulletCheck();
    if (respawnCooldown == 0 && asteroids.size() < asteroidCap) {
      asteroidRespawn();
      respawnCooldown = (int)random(5)+5;
    }
    if (respawnCooldown > 0)
      respawnCooldown--;
    //Check for ship collision agaist asteroids
    for (int i=0; i<asteroids.size(); i++) {
      Asteroid a = asteroids.get(i);
      if (player1.collidingWith(a)) {
        GAME = false;
      }
    }
    
    if (!GAME) {
      fill(255,0,0);
      rectMode(CENTER);
      textAlign(CENTER);
      textSize(100);
      text("GAME OVER",width/2,height/2);
    }
    //Draw spaceship & and its bullets
    //TODO: Part I, for now just render ship
    //TODO: Part IV - we will use a new feature in Java called an ArrayList, 
    //so for now we'll just leave this comment and come back to it in a bit. 
    
    //Update score
    noStroke();
    fill(0,255,0);
    rectMode(CENTER);
    textAlign(RIGHT);
    textSize(50);
    text("Score: "+score,977,50);
    fill(130);
    rectMode(CORNER);
    rect(10,10,210,40);
    fill(0);
    rect(15,15,200,30);
    fill(255,255,0);
  }
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
    } else if (keyCode == RIGHT) {
      ROTATE_RIGHT = false;
    } else if (keyCode == UP) {
      MOVE_FORWARD = false;
    }
  }
  if (keyCode == 32) {
    SPACE_BAR = false;
    FIRE_READY = true;
  }
}

void mouseClicked() {
  if (mouseX>=193 && mouseX<=793 && mouseY>=290 && mouseY<=410 && MENU) {
    MENU = false;
    STARTUP = true;
  }
}

void fire() {
  bullets.add(new Bullet(player1.getX(),player1.getY(),20,player1.getDirection()));
}

void asteroidRespawn() {
  VALID_SPAWN = false;
  while (!VALID_SPAWN) {
    spawnZone = (int)random(4);
    switch (spawnZone) {
      case 0:
        asteroidX = (float)(width*Math.random());
        asteroidY = (float)(-200*Math.random()-100);
        asteroidDirection = (float)(45*Math.random()+45);
        break;
      case 1:
        asteroidX = (float)(width*Math.random());
        asteroidY = height+((float)(300*Math.random()+150));
        asteroidDirection = (float)(225*Math.random()+45);
        break;
      case 2:
        asteroidX = (float)(-200*Math.random()-100);
        asteroidY = (float)(height*Math.random());
        asteroidDirection = 180-(float)(135*Math.random()+45);
        break;
      case 3:
        asteroidX = width+((float)(200*Math.random()+150));
        asteroidY = (float)((height)*Math.random());
        asteroidDirection = (float)(135*Math.random()+45);
        break;
    }
    asteroidSpeed = (float)(2*Math.random()+1);
    Asteroid asteroid = new Asteroid(asteroidX, asteroidY, asteroidSpeed, asteroidDirection, false);
    VALID_SPAWN = true;
    for (Asteroid a: asteroids) {
      if (a.nearCollidingWith(asteroid)) {
        VALID_SPAWN = false;
      }
    }
    if (VALID_SPAWN) {
      asteroids.add(asteroid);
    }
  }
}

void bulletCheck() {
  for (int i=0; i<bullets.size(); i++) {
    Bullet b = (Bullet)bullets.get(i);
    if (b.getX()<-100 || b.getX()>width+100) {
      bullets.remove(i);
    } else if (b.getY()<-100 || b.getY()>height+100) {
      bullets.remove(i);
    }
  }
}

void hitCheck() {
  for (int i=0; i<asteroids.size(); i++) {
    Asteroid a = (Asteroid)asteroids.get(i);
    for(int j=0; j<bullets.size(); j++) {
      Bullet b = (Bullet)bullets.get(j);
      if (b.collidingWith(a)) {
        if (!a.isFrag()) {
          Asteroid frag1 = new Asteroid(a.getX(), a.getY(), a.getSpeed(), a.getDirection()+30, true);
          Asteroid frag2 = new Asteroid(a.getX(), a.getY(), a.getSpeed(), a.getDirection()-30, true);
          asteroids.add(frag1);
          asteroids.add(frag2);
        }
        asteroids.remove(i);
        bullets.remove(j);
        score++;
      }
    }
  }
}

void sleep(int wait) {
  time = millis();
  WAITING = true;
  while (WAITING) {
    if(millis() - time >= wait) {
      WAITING = false;
    }
  }
}
