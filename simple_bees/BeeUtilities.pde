/**
 * Utility functions used by the Bee class.
 */
 
color speedColor(float vx, float vy) {
  float normalizationFactor = (maxSpeed * maxSpeed) / 255.0;
  float speed = vx * vx + vy * vy;
  return color(speed/normalizationFactor, 30, 255 - speed/normalizationFactor);
}

/**
 * Some utilities used by the main loop.
 */

void swap(Bee[] bees, int i) {
  Bee tmp = bees[i];
  bees[i] = bees[i+1];
  bees[i+1] = tmp;  
}

int findUnsortedEntry(Bee[] bees) {
  for (int i = 0; i < bees.length - 1; ++i) {
    if (bees[i].x > bees[i+1].x)
      return i;
  }
  return -1;
}

String xValuesOf(Bee[] bees) {
  return xValuesOf(bees, -1);
}

String xValuesOf(Bee[] bees, int emphasizedIndex) {
  StringBuffer result = new StringBuffer("[");
  String separator = "";
  for (int i = 0; i < bees.length; ++i) {
    result.append(separator);
    separator = ", ";
    Bee bee = bees[i];
    if (i == emphasizedIndex) {
      result.append("***");
      result.append(bee.x);
      result.append("***");
    }
    else {
      result.append(bee.x);
    }
  }
  result.append("]");
  return result.toString();
}

void assertSorted(Bee[] bees) {
  int unsortedEntry = findUnsortedEntry(bees);
  if (unsortedEntry != -1) {
    assert false : "Failed to sort " + xValuesOf(bees, unsortedEntry) + "!";    
  }
}

int numberOfBubbleCalls = 0;

int bubble(Bee[] bees, int maxIndex) {
  ++numberOfBubbleCalls;
  int result = -1;
  for (int i = 0; i < maxIndex - 1; ++i) {
    if (bees[i].x > bees[i+1].x) {
      result = i + 1;
      swap(bees, i);
    }
  }
  return result;
}

int bubble(Bee[] bees) {
  return bubble(bees, bees.length);
}

int numberOfBubblesortCalls = 0;

void bubblesort(Bee[] bees) {
  ++numberOfBubblesortCalls;
  if (logLevel >= 3 && (numberOfBubblesortCalls % (logLevel <= 3 ? 1000 : 100)) == 0) {
    println("Number of Bubblesort Calls:       " + numberOfBubblesortCalls);
    println("Number of Bubble Calls:           " + numberOfBubbleCalls);
    println("Bubble Calls per Bubblesort Call: " + numberOfBubbleCalls/numberOfBubblesortCalls);
  }
  int maxIndex = bees.length;
  while (maxIndex > 0) {
    maxIndex = bubble(bees, maxIndex);
  }
  assertSorted(bees);
}

