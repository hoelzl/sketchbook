class Circle {
  // The x and y position of the center.
  public float x;
  public float y;
  public float diameter;
  
  public color backgroundColor;
  public color strokeColor;
  
  public Circle(float x, float y, float diameter) {
    this.x = x;
    this.y = y;
    this.diameter = diameter;
    this.backgroundColor = color(128);
    this.strokeColor = color(0);
  }

  // Set the fill color.  Defined as a method so that subclasses can
  // override it if they don't want to be filled.
  public void setFill() {
    fill(backgroundColor);
  }
  
  // Set the stroke color.  Defined as a method so that subclasses can
  // override it if they don't want a border.
  public void setStroke() {
    stroke(strokeColor);
  }
   
  public void paint() {
    setFill();   
    setStroke();      
    ellipse(x, y, diameter, diameter);
  }
  
  
  // Compute the distance of point (x, y) from the center of this circle.
  public float distanceFromCenter(float x, float y) {
    float distanceX = this.x - x;
    float distanceY = this.y - y;
    return sqrt(distanceX * distanceX + distanceY * distanceY);
  }
  
  public boolean intersects(Circle other) {
    float distance = distanceFromCenter(other.x, other.y);
    return 2.0 * distance >= this.diameter + other.diameter;
  }
}
