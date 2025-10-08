DialogueOverlay startDialogue;

DialogueLoader dialogueLoader;

Character testChar;

void setup() {
  // fullScreen();
  size(1500, 1000);

  testChar = new Character("testChar", 200, 500);

  dialogueLoader = new DialogueLoader("dialogue.json");
  
  startDialogue = new DialogueOverlay("intro");
  }

void draw() {
  startDialogue.draw();
}

void mousePressed() {
  startDialogue.nextDialogue();
}