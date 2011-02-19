/**
 * The bevavior of bees.
 * When bees collide the separate CollisionBehavior is invoked.
 */
 
interface BeeBehavior {
  void invoke(Bee bee);
}

class MoveStraightAhead implements BeeBehavior {
   public void invoke(Bee bee) {
     bee.move();
   }
}

class SleepInTheSpotlight implements BeeBehavior {
  public void growTired(Bee bee) {
    // This is the first time we enter the spotlight.
    // Grow tired.
    bee.bedtime = millis() + random(250);
    // But keep moving on for now.
    bee.move();
  }
  
  public void moveWhileTired(Bee bee) {
    // We have previously decided to go to sleep, but the 
    // time is not here, yet.  Keep moving.
    bee.move();
  }
  
  public void goToSleep(Bee bee) {
    // Our bedtime has finally arrived.  Go to sleep.
    bee.bedtime = -1.0;
    bee.sleep(random(1000));
  }
  
  public void invoke(Bee bee) {
    if (bee.intersects(spotlight)) {
      if (bee.wakeUpTime > millis()) {
        // We are still asleep.
        bee.noteUpdate();
        return;
      }
      // Not asleep and in the spotlight:
      if (bee.bedtime < 0) {
        growTired(bee);
      } 
      else if (millis() < bee.bedtime) {
        moveWhileTired(bee);
      } 
      else {
        goToSleep(bee);
      }
    } 
    else {
      bee.move();
    }
  }
}

class SleepInTheSpotlightAndChangeDirection extends SleepInTheSpotlight {
  public void goToSleep(Bee bee) {
    super.goToSleep(bee);
    bee.assignRandomVelocity();
  }
}
