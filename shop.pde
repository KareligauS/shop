import java.util.Arrays;
import java.util.HashMap;

DialogueOverlay startDialogue;
DialogueOverlay activeDialogue;

DialogueLoader dialogueLoader;

Button startButton, optionsButton, exitButton;
ArrayList<Button> activeButtons = new ArrayList<Button>();

Item testItem;
ArrayList<Item> activeItems = new ArrayList<Item>();

Character testChar, micah;
HashMap<String, Character> characters = new HashMap<>();

enum GameState {
  PAUSED,
  RUNNING
}
GameState gameState;

void setupButtons() {
  startButton = new Button(width / 4, height / 2 - 150, 400, 100, 10, "Start Game", () -> pauseMenuClose());
  optionsButton = new Button(width / 4, height / 2, 400, 100, 10, "Options", () -> exit());
  exitButton = new Button(width / 4, height / 2 + 150, 400, 100, 10, "Exit", () -> exit());
}

void setupDialogue() {
  dialogueLoader = new DialogueLoader("dialogue.json");
  
  startDialogue = new DialogueOverlay("intro");
}

void setup() {
  // fullScreen();
  size(1500, 1000);

  testChar = new Character("testChar");
  micah = new Character("micah");

  testItem = new Item(0, 0);

  setupButtons();
  setupDialogue();

  startDialogue.startDialogue();

  pauseMenuOpen();
}

void draw() {
  background(220);

  switch (gameState) {
    case PAUSED:
      pauseMenudraw();
      break;
    case RUNNING:
      if (activeDialogue != null) activeDialogue.draw();
      break;
    default:
      gameState = GameState.PAUSED;
      break;
  }

  activeButtons.stream()
    .filter(button -> button.getState() == ButtonState.INACTIVE)
    .forEach(Button::deactivate);
  
  activeButtons.forEach(Button::draw);

  setCursor();

  activeItems.stream()
    .filter(item -> item.getState() == ItemState.INACTIVE)
    .forEach(Item::deactivate);

  activeItems.forEach(Item::draw);
}

void mousePressed() {
  if (gameState != GameState.PAUSED && activeDialogue != null) {
    activeDialogue.nextDialogue();
  }

  startButton.buttonPressed();

  activeButtons.forEach(Button::buttonPressed);
  activeItems.forEach(Item::buttonPressed);
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
