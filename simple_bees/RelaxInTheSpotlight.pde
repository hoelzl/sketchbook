/**
 * Similar behavior to SleepInTheSpotlight, but we only slow down and don't stop completely.
 */

class RelaxInTheSpotlight implements BeeBehavior {
  public float slowdown = 0.1;

  public void invoke(Bee bee) {
    if (bee.intersects(spotlight)) {
      bee.moveScaled(slowdown);
    } 
    else {
      bee.move();
    }
  }
  
  public void noteCollision(Bee bee) {
    // Do nothing.
  }  
}

class RelaxAndCenterInTheSpotlight implements BeeBehavior {
  public float slowdown = 0.1;

  public void invoke(Bee bee) {
    if (bee.intersects(spotlight)) {
      PVector direction = spotlight.directionToOriginFrom(bee.x, bee.y);
      direction.normalize();
      float v = 0.1 * bee.velocity();
      bee.changeDirection(v * direction.x, v * direction.y);
      bee.moveScaled(slowdown);
    } 
    else {
      bee.move();
    }
  }
  
  public void noteCollision(Bee bee) {
    // Do nothing.
  }  
}

