// Setup

/**
 * Sets up all needed characters.
 */
void setupCharacters() {
  harry = new Character("harry");
  micah = new Character("micah");
}

/**
 * Sets up all needed dialogue and its loader.
 */
void setupDialogue() {
  dialogueLoader = new DialogueLoader("dialogue.json");
  
  logoDialogue = new DialogueOverlay("logo");
  startDialogue = new DialogueOverlay("intro");
  endDialogue = new DialogueOverlay("end");
}

void setupParticleSources(){
  ParticleSource testSource = new ParticleSource(new PVector(100, 100), new PVector(300, 300), new PVector(50, 50), 5, 20);
  particleSystem.register("test", testSource);
  particleSystem.fillSource("test", 10, "key");
}

/**
 * Sets up all needed items.
 */
void setupItems() {
  bookItem = new Item(300, 750, 100, 100, "books", true, 1135, 490);
  keyItem = new Item(1190, 380, 100, 100, "key", true, 960, 640);
  boxItem1 = new Item(1190, 380, 100, 100, "box", true, 1575, 730);
  boxItem2 = new Item(1520, 830, 100, 100, "box", false);
  boxItem3 = new Item(1630, 830, 100, 100, "box", false);
}

// Draw Acvtive

/**
 * Draw all active items by itterating over activeItems, and deactivating the fully
 * if they are partially inactive.
 */
void drawActiveItems() {
  activeItems.stream()
    .filter(item -> item.getState() == ItemState.INACTIVE)
    .forEach(Item::deactivate);

  activeItems.forEach(Item::draw);
}

// Utils

/**
 * Capitalizes the first letter in a string.
 *
 * @param str the string to capitalize
 *
 * @return the capitalized string
 */
String capitalize(String str) {
  if (str.length() < 1) throw new IllegalArgumentException("String to capilaize can't be shorter than 1 char.");
  return str.substring(0, 1).toUpperCase() + str.substring(1);
}

/**
 * Toggles if debug-information is shown.
 */
void showDebug() {
  showDebug = !showDebug;
}

boolean areItemsOnDestination() {
  return bookItem.isOnDestination() && keyItem.isOnDestination() && boxItem1.isOnDestination();
}
