// The maximum speed.
float maxSpeed = 50.0;

color speedColor(float vx, float vy) {
  float normalizationFactor = (maxSpeed * maxSpeed) / 255.0;
  float speed = vx * vx + vy * vy;
  return color(speed/normalizationFactor, 0, 255 - speed/normalizationFactor);
}

class Bee extends Circle {
  public Bee() {
    this(random(width), random(height));
  }
  
  public Bee(float x, float y) {
    super(x, y, 10.0);
    lastUpdate = millis();
    vx = random(-maxSpeed, maxSpeed);
    float maxSpeedY = sqrt(maxSpeed * maxSpeed - vx * vx);
    vy = random(-maxSpeedY, maxSpeedY);
    this.strokeColor = color(0);
    this.backgroundColor = speedColor(vx, vy);
  }
  
  // Note: we make all instance variables public since there seem to be
  // some strange problems with the applet when we don't do so, according
  // to the documentation of the controlP5 GUI library.
  
  // The time of the last update.
  public float lastUpdate;
  
  // The x and y velocities in pixels/s
  public float vx;
  public float vy;
  
  public float velocity() {
    return sqrt(vx * vx + vy * vy);
  }
  
  public void setVelocity(float vx, float vy) {
    this.vx = vx;
    this.vy = vy;
    backgroundColor = speedColor(vx, vy);
  }
  
  public void detectCollision(Bee other) {
    // println("Possible collision: this = " + this.x + ", " + this.y + "; other = " + other.x + ", " + other.y);
    float distanceX = this.x - other.x;
    float distanceY = this.y - other.y;
    float distance = sqrt(distanceX * distanceX + distanceY * distanceY);
    // The following test assumes that all bees have the same size.
    if (distance >= diameter)
      // No collision.
      return;
    if (logLevel > 3) {
      println("Collision: this = " + this.x + ", " + this.y + "; other = " + other.x + ", " + other.y);
    }
    float thisRatio = this.velocity() / distance;
    float otherRatio = other.velocity() / distance;
    if (transferImpulse) {
      setVelocity(otherRatio * distanceX, otherRatio * distanceY);
      other.setVelocity(-thisRatio * distanceX, other.vy = -thisRatio * distanceY);
    } 
    else {
      setVelocity(thisRatio * distanceX, thisRatio * distanceY);
      other.setVelocity(-otherRatio * distanceX, -otherRatio * distanceY);
    }
  }
  
  public void move() {
    float currentTime = millis();
    float dt = (currentTime - lastUpdate) / 1000.0;
    lastUpdate = currentTime;
    move(vx * dt, vy * dt);
  }
  
  public void move(float dx, float dy) {
    x += dx;
    y += dy;
    
    if (x + diameter > width && vx > 0) {
      vx = -vx;
    }
    else if (x < diameter && vx < 0) {
      vx = - vx;
    }
    if (y + diameter > height && vy > 0) {
      vy = - vy;
    }
    else if (y < diameter && vy < 0) {
      vy = - vy;
    }   
  }
}
