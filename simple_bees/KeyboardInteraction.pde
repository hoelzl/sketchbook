
void notify(String note) {
  string = note;
  drawTextUntil = millis() + 2000;
}

void processKeyboardInteraction() {
  if (keyPressed) {
    if (key == '1') {
      minSpeed = 0;
      maxSpeed = 20;
      assignNewVelocities();
    }
    else if (key == '2') {
      minSpeed = 20;
      maxSpeed = 40;
      assignNewVelocities();
    }
    else if (key == '3') {
      minSpeed = 30;
      maxSpeed = 60;
      assignNewVelocities();
    }
    else if (key == '4') {
      minSpeed = 40;
      maxSpeed = 80;
      assignNewVelocities();
    }
    else if (key == '5') {
      minSpeed = 50;
      maxSpeed = 100;
      assignNewVelocities();
    }
    else if (key == '6') {
      minSpeed = 30;
      maxSpeed = 150;
      assignNewVelocities();
    }
    else if (key == '7') {
      minSpeed = 0;
      maxSpeed = 200;
      assignNewVelocities();
    }
    else if (key == '8') {
      minSpeed = 120;
      maxSpeed = 200;
      assignNewVelocities();
    }
    else if (key == 'g') {
      assignBehaviorFollowTheGradientConstantChange();
    }
    else if (key == 'G') {
      assignBehaviorFollowTheGradientVelocityDependentChange();
    }
    else if (key == 's') {
      assignBehaviorSleepInTheSpotlight();
    }
    else if (key == 'S') {
      assignBehaviorSleepInTheSpotlightAndChangeDirection();
    }  
    else if (key == 'r') {
      assignBehaviorRelaxInTheSpotlight();
    }
    else if (key == 'R') {
      assignBehaviorRelaxAndCenterInTheSpotlight();
    }
    else if (key == 'i') {
      toggleTransferImpulse();
    }
    else if (key == '+') {
      increaseSpotlightDiameter();
    }
    else if (key == '-') {
      decreaseSpotlightDiameter();
    }
  }
}

void assignNewVelocities() {
  for (Bee bee : allBees) {
    bee.assignRandomVelocity();
  }
  notify("min speed = " + minSpeed + "\nmax speed = " + maxSpeed);
}

void assignBehaviorFollowTheGradientConstantChange() {
  notify("Changing behaviors to\n\"FollowTheGradientConstantChange\"");
  for (Bee bee : allBees) {
    bee.behavior = new FollowTheGradientConstantChange();
  }
}

void assignBehaviorFollowTheGradientVelocityDependentChange() {
  notify("Changing behaviors to\n\"FollowTheGradientVelocityDependentChange\"");
  for (Bee bee : allBees) {
    bee.behavior = new FollowTheGradientVelocityDependentChange();
  }
}

void assignBehaviorSleepInTheSpotlight() {
  notify("Changing behaviors to\n\"SleepInTheSpotlight\"");
  for (Bee bee : allBees) {
    bee.behavior = new SleepInTheSpotlight();
  }
}

void assignBehaviorSleepInTheSpotlightAndChangeDirection() {
  notify("Changing behaviors to\n\"SleepInTheSpotlightAndChangeDirection\"");
  for (Bee bee : allBees) {
    bee.behavior = new SleepInTheSpotlightAndChangeDirection();
  }
}

void assignBehaviorRelaxInTheSpotlight() {
  notify("Changing behaviors to\n\"RelaxInTheSpotlight\"");
  for (Bee bee : allBees) {
    bee.behavior = new RelaxInTheSpotlight();
  }
}

void assignBehaviorRelaxAndCenterInTheSpotlight() {
  notify("Changing behaviors to\n\"RelaxAndCenterInTheSpotlight\"");
  for (Bee bee : allBees) {
    bee.behavior = new RelaxAndCenterInTheSpotlight();
  }
}

void toggleTransferImpulse() {
  if (transferImpulse) {
    transferImpulse = false;
    notify("Transfer impulse is FALSE.");
  }
  else {
    transferImpulse = true;
    notify("Transfer impulse is TRUE.");
  }
}

void increaseSpotlightDiameter() {
  if (spotlight.diameter < 800) {
    spotlight.diameter += 2;
    notify("Increased spotlight diameter to " + spotlight.diameter);
  }
  else {
    notify("Cannot increase the spotlight diameter above 800.");
  }
}

void decreaseSpotlightDiameter() {
  if (spotlight.diameter > 20) {
    spotlight.diameter -= 2;
    notify("Decreased spotlight diameter to " + spotlight.diameter);
  }
  else {
    notify("Cannot decrease the spotlight diameter below 50.");
  }
}

    
