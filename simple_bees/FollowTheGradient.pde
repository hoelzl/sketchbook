/**
 * A bee behavior that tries to move the bee in the direction of the light source.
 */

class FollowTheGradientConstantChange implements BeeBehavior {
  public FollowTheGradientConstantChange() {
  }
  void invoke(Bee bee) {
    PVector direction = spotlight.directionToOriginFrom(bee.x, bee.y);
    direction.normalize();
    bee.changeDirection(direction.x, direction.y);
    bee.move();
  }
  void noteCollision(Bee bee) {
    // Nothing to do.
  }
}

class FollowTheGradientVelocityDependentChange implements BeeBehavior {
  void invoke(Bee bee) {
    PVector direction = spotlight.directionToOriginFrom(bee.x, bee.y);
    direction.normalize();
    float v = 0.1 * bee.velocity();
    bee.changeDirection(direction.x * v, direction.y * v);
    bee.move();
  }
  void noteCollision(Bee bee) {
    // Nothing to do.
  }
}
