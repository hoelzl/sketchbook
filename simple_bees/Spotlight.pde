/**
 * Spotlights are circles of light on the floor.
 */
class Spotlight extends Circle {
  public Spotlight(float x, float y) {
    super(x, y, 150.0);
    backgroundColor = color(250, 242, 0);
  }
  
  public void setStroke() {
    noStroke();
  }
}
