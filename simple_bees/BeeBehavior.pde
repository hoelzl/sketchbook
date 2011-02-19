/**
 * The bevavior of bees.
 * When bees collide the separate CollisionBehavior is invoked.
 */
 
interface BeeBehavior {
  void invoke(Bee bee);
  void noteCollision(Bee bee);
}

class MoveStraightAhead implements BeeBehavior {
   public void invoke(Bee bee) {
     bee.move();
   }
   
   public void noteCollision(Bee bee) {
     // Nothing to do.
   }
}


