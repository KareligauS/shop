String capitalize(String str) {
  if (str.length() < 1) throw new IllegalArgumentException("String to capilaize can't be shorter than 1 char.");
  return str.substring(0, 1).toUpperCase() + str.substring(1);
}

void setCursor() {
  if (activeButtons.stream().anyMatch(Button::isHovering)) {
    cursor(HAND);
  } else {
    cursor(ARROW);
  }
}

void pauseMenuOpen() {
  gameState = GameState.PAUSED;
  startButton.activate();
  optionsButton.activate();
  exitButton.activate();
}

void pauseMenuDraw() { 
  pushStyle();
  fill(220);
  rect(0, 0, width, height);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  fill(0);
  textSize(100);
  text("GAME TITLE", 2*width/3, height/2-30);
  textSize(50);
  text("subtitle", 2*width/3, height/2+30);
  popStyle();
}

void pauseMenuClose() {
  startButton.deactivate();
  optionsButton.deactivate();
  exitButton.deactivate();

  gameState = GameState.RUNNING;
}

void setupButtons() {
  startButton = new Button(width / 4, height / 2 - 150, 400, 100, 10, "Start Game", () -> pauseMenuClose());
  optionsButton = new Button(width / 4, height / 2, 400, 100, 10, "Options", () -> exit());
  exitButton = new Button(width / 4, height / 2 + 150, 400, 100, 10, "Exit", () -> exit());
}

void setupCharacters() {
  testChar = new Character("testChar");
  micah = new Character("micah");
}

void setupDialogue() {
  dialogueLoader = new DialogueLoader("dialogue.json");
  
  startDialogue = new DialogueOverlay("intro");
}

void setupItems() {
  testItem = new Item(100, 100, true);
  bestItem = new Item(300, 200, true);
}

void drawActiveButtons() {
  activeButtons.stream()
    .filter(button -> button.getState() == ButtonState.INACTIVE)
    .forEach(Button::deactivate);
  
  activeButtons.forEach(Button::draw);

  setCursor();
}

void drawActiveItems() {
  activeItems.stream()
    .filter(item -> item.getState() == ItemState.INACTIVE)
    .forEach(Item::deactivate);

  activeItems.forEach(Item::draw);
}
