import java.text.MessageFormat;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

DecorationManager decorationManager = new DecorationManager("./sprites/decorations/");
MenuManager menuManager = new MenuManager();

DialogueLoader dialogueLoader;

DialogueOverlay startDialogue, endDialogue, logoDialogue;
DialogueOverlay activeDialogue;

Character harry, micah;
HashMap<String, Character> characters = new HashMap<>();

Item testItem, keyItem;
ArrayList<Item> activeItems = new ArrayList<Item>();

enum GameState {
  PAUSED,
  RUNNING,
  FINNISHED
}
GameState gameState;

boolean showDebug;

void setup() {
  fullScreen();
  size(1500, 1000);

  setupCharacters();
  setupDialogue();
  setupItems();

  decorationManager.init();
  menuManager.init();
  menuManager.openMenu("pause");

  startDialogue.startDialogue();
}

void draw() {
  background(220);

  menuManager.setCursor();

  switch (gameState) {
    case PAUSED:
      menuManager.displayActive();
      break;
    case RUNNING:
      decorationManager.displayAll();
      drawActiveItems();
      if (activeDialogue != null) activeDialogue.draw();

      if (testItem.isOnDestination() && keyItem.isOnDestination()) {
        endDialogue.startDialogue();
        gameState = GameState.FINNISHED;
      }
      if (showDebug) activeItems.forEach(Item::displayInfo);
      break;
    case FINNISHED:
      decorationManager.displayAll();
      drawActiveItems();
      if (activeDialogue != null) activeDialogue.draw();
      break;
    default:
      gameState = GameState.PAUSED;
      break;
  }
}

void mousePressed() {
  menuManager.buttonPressed();

  switch (gameState) {
  case RUNNING:
  case FINNISHED:
    if (activeDialogue != null) {
      activeDialogue.nextDialogue();
    } else {
      decorationManager.handleMousePressed(new PVector(mouseX, mouseY));
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
  menuManager.buttonReleased();

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
        menuManager.closeMenu();
      } else {
        menuManager.openMenu("pause");
      }
      break;
  }
}
