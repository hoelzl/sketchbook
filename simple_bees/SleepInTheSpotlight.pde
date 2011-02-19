class SleepInTheSpotlight implements BeeBehavior {
    
  // The time when we want to go to sleep.
  public float bedtime = -1.0;
  // The time when we want to wake up from a sleep.
  public float wakeUpTime;
  // How long do we want to sleep?  This is used to set the wakeUpTime;
  public float sleepDurationInMilliseconds = 1000.0;
  // How long does it take us to get tired?
  public float timeToGetTiredInMilliseconds = 250.0;
  
  public void growTired(Bee bee) {
    // This is the first time we enter the spotlight.
    // Grow tired.
    bedtime = millis() + random(timeToGetTiredInMilliseconds);
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
    bedtime = -1.0;
    wakeUpTime = max(wakeUpTime, millis() + random(sleepDurationInMilliseconds));
  }
    
  public void sleep(float sleepDurationInMilliseconds) {
  }
  
  public void wakeUp(Bee bee) {
    wakeUpTime = -1.0;
    bedtime = -1.0;
    bee.noteUpdate(millis());
  }
  
  public void invoke(Bee bee) {
    if (bee.intersects(spotlight)) {
      if (wakeUpTime > millis()) {
        // We are still asleep.
        bee.noteUpdate();
        return;
      }
      // Not asleep and in the spotlight:
      if (bedtime < 0) {
        growTired(bee);
      } 
      else if (millis() < bedtime) {
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
  
  public void noteCollision(Bee bee) {
    wakeUp(bee);
  }
}

class SleepInTheSpotlightAndChangeDirection extends SleepInTheSpotlight {
  public void goToSleep(Bee bee) {
    super.goToSleep(bee);
    bee.assignRandomVelocity();
  }
}
