/**
 * The behavior invoked by bees when they collide.
 * (distanceX, distanceY) is the vector from bee2 to bee1;
 * distance is its magnitude.
 */
interface CollisionBehavior {
  public void collide(Bee bee1, Bee bee2, float distanceX, float distanceY, float distance);
}

class CollideAndTransferImpulse implements CollisionBehavior {
  public void collide(Bee bee1, Bee bee2, float distanceX, float distanceY, float distance) {
    float bee1Ratio = bee1.velocity() / distance;
    float bee2Ratio = bee2.velocity() / distance;
    bee1.setVelocity(bee2Ratio * distanceX, bee2Ratio * distanceY);
    bee2.setVelocity(-bee1Ratio * distanceX, -bee1Ratio * distanceY);
  }
}

class CollideWithoutChangingImpulse implements CollisionBehavior {
  public void collide(Bee bee1, Bee bee2, float distanceX, float distanceY, float distance) {
    float bee1Ratio = bee1.velocity() / distance;
    float bee2Ratio = bee2.velocity() / distance;
    bee1.setVelocity(bee1Ratio * distanceX, bee1Ratio * distanceY);
    bee2.setVelocity(-bee2Ratio * distanceX, -bee2Ratio * distanceY);
  }
}
