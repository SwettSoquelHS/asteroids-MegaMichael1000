//note that this class does NOT *NEED* to extend Mover but can if you like
class Star {
  float x_pos;
  float y_pos;
  float radius;
  public Star() {
    x_pos = (float)(width*Math.random());
    y_pos = (float)(height*Math.random());
    radius = (float)(3*Math.random())+1;
  }
  void show() {
    pushMatrix();
    translate(x_pos,y_pos);
    fill(255);
    noStroke();
    ellipse(0,0,radius,radius);
    popMatrix();
  }
}
