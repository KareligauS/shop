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
  STARING,
  STARTED,
  PAUSED,
  RUNNING
}
GameState gameState;

void setupButtons() {
  startButton = new Button(width/4, height/2-150, 400, 100, 0, "Start Game");
  optionsButton = new Button(width/4, height/2, 400, 100, 0, "Options");
  exitButton = new Button(width/4, height/2+150, 400, 100, 0, "Exit");
}

void setupDialogue() {
  dialogueLoader = new DialogueLoader("dialogue.json");
  
  startDialogue = new DialogueOverlay("intro");
}

void setup() {
  // fullScreen();
  size(1500, 1000);

  gameState = GameState.STARING;

  testChar = new Character("testChar");
  micah = new Character("micah");

  testItem = new Item(0, 0);

  setupButtons();
  setupDialogue();

  pauseMenuOpen();
}

void draw() {
  background(220);

  switch (gameState) {
    case STARTED:
      break;
    case PAUSED:
      drawStartMenu();
      break;
    case RUNNING:
      break;
    default:
      gameState = GameState.PAUSED;
      break;
  }

  if (activeDialogue != null) {
    activeDialogue.draw();
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
  activeButtons.forEach(Button::buttonReleased);
  activeItems.forEach(Item::buttonReleased);

  if (startButton.getState() == ButtonState.CLICKED) pauseMenuClose();
  if (optionsButton.getState() == ButtonState.CLICKED) return;
  if (exitButton.getState() == ButtonState.CLICKED) exit();
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
