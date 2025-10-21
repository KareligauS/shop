import java.util.Arrays;
import java.util.HashMap;

DialogueOverlay startDialogue;
DialogueOverlay activeDialogue;

DialogueLoader dialogueLoader;

Button startButton, optionsButton, exitButton;
ArrayList<Button> activeButtons = new ArrayList<Button>();

Item testItem, bestItem;
ArrayList<Item> activeItems = new ArrayList<Item>();

Character testChar, micah;
HashMap<String, Character> characters = new HashMap<>();

enum GameState {
  PAUSED,
  RUNNING
}
GameState gameState;

void setup() {
  // fullScreen();
  size(1500, 1000);

  testChar = new Character("testChar");
  micah = new Character("micah");

  testItem = new Item(100, 100, true);
  bestItem = new Item(300, 200, true);

  setupButtons();
  setupDialogue();

  startDialogue.startDialogue();

  pauseMenuOpen();
}

void draw() {
  background(220);

  switch (gameState) {
    case PAUSED:
      pauseMenuDraw();
      drawActiveButtons();
      break;
    case RUNNING:
      if (activeDialogue != null) activeDialogue.draw();
      drawActiveButtons();
      drawActiveItems();
      break;
    default:
      gameState = GameState.PAUSED;
      break;
  }
}

void mousePressed() {
  startButton.buttonPressed();

  activeButtons.forEach(Button::buttonPressed);

  switch (gameState) {
  case PAUSED:
    break;
  case RUNNING:
    if (activeDialogue != null) activeDialogue.nextDialogue();
    activeItems.stream()
      .filter(item -> item.getState() == ItemState.HOVERING)
      .forEach(Item::buttonPressed);
    break;
  }
}

void mouseDragged() {
  switch (gameState) {
  case PAUSED:
    break;
  case RUNNING:
    activeItems.stream()
      .filter(item -> item.getState() == ItemState.DRAGGING)
      .forEach(item -> item.mouseDrag(mouseX, mouseY));
    break;
  }
}

void mouseReleased() {
  // activeButtons.forEach(Button::buttonReleased);
  startButton.buttonReleased();
  optionsButton.buttonReleased();
  exitButton.buttonReleased();

  activeItems.forEach(Item::buttonReleased);
}

void keyPressed() {
  switch (key) {
    case ' ':
      if (gameState != GameState.PAUSED && activeDialogue != null) {
        activeDialogue.nextDialogue();
      }
      break;
    case 'p':
    case 'P':
    case ESC:
      key = 0;
      if (gameState == GameState.PAUSED) {
        pauseMenuClose();
      } else {
        pauseMenuOpen();
      }
      break;
  }
}
