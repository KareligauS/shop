import java.util.HashMap;

DialogueOverlay startDialogue;
DialogueOverlay activeDialogue;

DialogueLoader dialogueLoader;

Item testItem;
ArrayList<Item> activeItems = new ArrayList<Item>();

Character testChar, micah;
HashMap<String, Character> characters = new HashMap<>();

void setup() {
  // fullScreen();
  size(1500, 1000);

  testChar = new Character("testChar");
  micah = new Character("micah");

  testItem = new Item(0, 0);

  dialogueLoader = new DialogueLoader("dialogue.json");
  
  startDialogue = new DialogueOverlay("intro");
}

void draw() {
  background(220);

  if (activeDialogue != null) {
    activeDialogue.draw();
  }

  activeItems.stream()
    .filter(item -> item.getState() == ItemState.INACTIVE)
    .forEach(Item::deactivate);

  activeItems.forEach(Item::draw);
}

void mousePressed() {
  if (activeDialogue != null) {
    activeDialogue.nextDialogue();
  }

  activeItems.forEach(Item::buttonPressed);
}

void mouseReleased() {
  activeItems.forEach(Item::buttonReleased);
}

void keyPressed() {
  switch (key) {
    case 'q':
    case 'Q':
      startDialogue.startDialogue();
      break;
  }
}