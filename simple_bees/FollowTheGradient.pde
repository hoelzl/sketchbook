/**
 * A bee behavior that tries to move the bee in the direction of the light source.
 */

class FollowTheGradient implements BeeBehavior {
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
