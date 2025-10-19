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

void pauseMenudraw() { 
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
