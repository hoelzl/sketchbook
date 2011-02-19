// The maximum speed.
float maxSpeed = 50.0;

color speedColor(float vx, float vy) {
  float normalizationFactor = (maxSpeed * maxSpeed) / 255.0;
  float speed = vx * vx + vy * vy;
  return color(speed/normalizationFactor, 30, 255 - speed/normalizationFactor);
}

class Bee extends Circle {
  
  // Note: we make all instance variables public since there seem to be
  // some strange problems with the applet when we don't do so, according
  // to the documentation of the controlP5 GUI library.
  
  // The time of the last update.
  public float lastUpdate;
  
  // The x and y velocities in pixels/s
  public float vx;
  public float vy;

  public CollisionBehavior collisionBehavior;

  public Bee() {
    this(random(width), random(height));
  }
  
  public Bee(float x, float y) {
    super(x, y, 10.0);
    
    lastUpdate = millis();
    vx = random(-maxSpeed, maxSpeed);
    float maxSpeedY = sqrt(maxSpeed * maxSpeed - vx * vx);
    vy = random(-maxSpeedY, maxSpeedY);
    
    strokeColor = color(0);
    backgroundColor = speedColor(vx, vy);
    
    if (transferImpulse) {
      collisionBehavior = new CollideAndTransferImpulse();
    } else {
      collisionBehavior = new CollideWithoutChangingImpulse();
    }
  }
  
  public float velocity() {
    return sqrt(vx * vx + vy * vy);
  }

  // TODO: There should also be a setVelocity(float totalVelocity) method for
  // symmetry with the velocity() accessor.  However it's not currently needed,
  // so I'm too lazy to actually implement it.  And if somebody asks I'm totally
  // going to justify this with the YAGNI principle.
  //
  public void setVelocity(float vx, float vy) {
    this.vx = vx;
    this.vy = vy;
    backgroundColor = speedColor(vx, vy);
  }
  
  public void detectCollision(Bee other) {
    // println("Possible collision: this = " + this.x + ", " + this.y + "; other = " + other.x + ", " + other.y);
    // This is the same as the computation in Circle::distanceFromCenter,
    // but since we need the intermediate results later I don't know what to
    // do about it.  Multiple return values to the rescue!
    float distanceX = this.x - other.x;
    float distanceY = this.y - other.y;
    float distance = sqrt(distanceX * distanceX + distanceY * distanceY);
    // The following test assumes that all bees have the same size.
    if (distance >= diameter)
      // No collision.
      return;
      
    // OK, we collide, now announce it to the world...
    if (logLevel > 3) {
      println("Collision: this = " + this.x + ", " + this.y + "; other = " + other.x + ", " + other.y);
    }
    // ... and behave accordingly.
    collisionBehavior.collide(this, other, distanceX, distanceY, distance);
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
