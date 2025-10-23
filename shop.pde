import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.text.MessageFormat;

DecorationManager decorationManager = new DecorationManager("./sprites/decorations/");

DialogueOverlay startDialogue, endDialogue;
DialogueOverlay activeDialogue;

DialogueLoader dialogueLoader;

Button startButton, optionsButton, exitButton;
ArrayList<Button> activeButtons = new ArrayList<Button>();

Character testChar, micah;
HashMap<String, Character> characters = new HashMap<>();

Item testItem, keyItem;
ArrayList<Item> activeItems = new ArrayList<Item>();

enum GameState {
  PAUSED,
  RUNNING,
  FINNISHED
}
GameState gameState;

void setup() {
  fullScreen();
  size(1500, 1000);

  setupButtons();
  setupCharacters();
  setupDialogue();
  setupItems();

  startDialogue.startDialogue();

  pauseMenuOpen();

  decorationManager.init();
}

void draw() {
  background(220);

  decorationManager.displayAll(true, true);

  switch (gameState) {
    case PAUSED:
      pauseMenuDraw();
      drawActiveButtons();
      break;
    case RUNNING:
      drawActiveItems();
      if (activeDialogue != null) activeDialogue.draw();
      drawActiveButtons();

      if (testItem.isOnDestination() && keyItem.isOnDestination()) {
        gameState = GameState.FINNISHED;
        endDialogue.startDialogue();
      }
      break;
    case FINNISHED:
      drawActiveItems();
      if (activeDialogue != null) activeDialogue.draw();
      drawActiveButtons();
      break;
    default:
      gameState = GameState.PAUSED;
      break;
  }
}

void mousePressed() {
  activeButtons.forEach(Button::buttonPressed);

  switch (gameState) {
  case RUNNING:
  case FINNISHED:
    if (activeDialogue != null) {
      activeDialogue.nextDialogue();
    } else {
      activeItems.stream()
        .filter(item -> item.getState() == ItemState.HOVERING)
        .forEach(Item::buttonPressed);
    }
    break;
  default: break;
  }
}

void mouseDragged() {
  switch (gameState) {
  case RUNNING:
    activeItems.stream()
      .filter(item -> item.isDragable() && item.getState() == ItemState.DRAGGING)
      .findFirst()
      .ifPresent(item -> item.mouseDrag(mouseX, mouseY));
    break;
  default: break;
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
