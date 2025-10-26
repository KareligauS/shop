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

  musicboxOnDialogue = new DialogueOverlay("musicbox_on");
  musicboxOffDialogue = new DialogueOverlay("musicbox_off");
}

void setupParticleSources(){
  ParticleSource musicBoxInsideLeftSource = new ParticleSource(new PVector(525, 600), new PVector(350, 350), new PVector(40, 40), new PVector(75, 75), 2, 50, false);
  particleSystem.register("left_musicbox_inside", musicBoxInsideLeftSource);
  particleSystem.fillSource("left_musicbox_inside", 5, "noteA");
  particleSystem.fillSource("left_musicbox_inside", 5, "noteB");
  particleSystem.fillSource("left_musicbox_inside", 5, "noteC");

  ParticleSource musicBoxInsideRightSource = new ParticleSource(new PVector(700, 600), new PVector(825, 350), new PVector(40, 40), new PVector(75, 75), 2, 50, false);
  particleSystem.register("right_musicbox_inside", musicBoxInsideRightSource);
  particleSystem.fillSource("right_musicbox_inside", 5, "noteA");
  particleSystem.fillSource("right_musicbox_inside", 5, "noteB");
  particleSystem.fillSource("right_musicbox_inside", 5, "noteC");
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
