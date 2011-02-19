/**
<h1><tt>simple_bees</tt>&mdash;experiments with swarm algorithms</h1>

<p>You can use the following key commands to control the behavior:</p>
<dl>
  <dt><tt>1-8</tt></dt>
  <dd>Change the speed of the bees</dd>
  <dt><tt>gGsSrR</tt></dt>
  <dd>Change the algorithm used by the bees</dd>
  <dt><tt>i</tt></dt>
  <dd>Toggle the transferImpulse setting</dd>
  <dt><tt>+-</tt></dt>
  <dd>Change the size of the spotlight</dd>
  <dt><em>Mouse</em></dt>
  <dd>Move the spotlight around</dd>
</dl>

 */
 
Spotlight spotlight;

Bee[] allBees;
int numberOfBees = 100;

int logLevel = 1;
boolean transferImpulse = true;

PFont font;
String string;
float drawTextUntil;

void setup() {
  smooth();
  // Should be set from variables, but that causes the applet export to
  // generate a HTML file with the wrong dimensions.
  size(600, 600);
  font = loadFont("LinuxBiolinumGI-24.vlw");
  textFont(font);

  spotlight = new Spotlight(300, 300);

  allBees = new Bee[numberOfBees];
  for (int i = 0; i < numberOfBees; ++i) {
    allBees[i] = new Bee();
  }
  bubblesort(allBees);
}

void performBeeBehaviors(Bee[] bees) {
  for (Bee bee : bees) {
    bee.perform();
  }
}

void detectCollisions(Bee[] bees) {
  bubblesort(allBees);
  outer:
  for (int i = 0; i < numberOfBees; ++i) {
    Bee current = allBees[i];
    for (int j = i + 1; j < numberOfBees; ++j) {
      Bee test = allBees[j];
      if (test.x - current.x > test.diameter) {
        continue outer;
      }
      else {
        current.detectCollision(test);
      }
    }
  }
}

void paintBees(Bee[] bees) {
  for (Bee bee : bees) {
    bee.paint();
  }
}

void draw() {
  background(120);
  if (mousePressed) {
    spotlight.x = mouseX;
    spotlight.y = mouseY;
  }
  spotlight.paint();
  processKeyboardInteraction();
  performBeeBehaviors(allBees);
  detectCollisions(allBees);
  paintBees(allBees);
  if (drawTextUntil >= millis()) {
    fill(color(255));
    text(string, 20, 20, 500, 300);
  }
}

