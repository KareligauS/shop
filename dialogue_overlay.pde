class DialogueOverlay {
  // Look
  color bgColor, textColor;
  PShape background;
  int margin, padding;
  int charBackWidth, chatBackHeight;
  int textBackWidth, textBackHeight;

  // Dialogue
  PVector dialogueLoc;

  // Character
  Character character;
  PShape characterSprite;
  String characterName;
  Emotion characterEmotion;
  String dialogue;

  DialogueOverlay(String dialoguePart) {
    dialogueLoader.loadPart(dialoguePart);

    bgColor = 30;
    textColor= 255;

    margin = 50;
    padding = 20;
    charBackWidth = 300;
    chatBackHeight = 350;
    textBackWidth = width - charBackWidth - 2*margin;
    textBackHeight = (3*chatBackHeight)/4;
    
    background = drawBackground();

    dialogueLoc = new PVector(margin + charBackWidth + padding, height - textBackHeight - margin);

    updateDialogue();
  }

  PShape drawBackground() {
    PShape back = createShape(GROUP);

    PVector charBackLoc = new PVector(margin, height-chatBackHeight-margin);
    PShape charBack = createShape(RECT, charBackLoc.x, charBackLoc.y, charBackWidth, chatBackHeight);
    charBack.setFill(bgColor+10);
    charBack.setStroke(false);
    back.addChild(charBack);

    PVector textBackLoc = new PVector(margin+charBackWidth, height-textBackHeight-margin);
    PShape textBack = createShape(RECT, textBackLoc.x, textBackLoc.y, textBackWidth, textBackHeight);
    textBack.setFill(bgColor);
    textBack.setStroke(false);
    back.addChild(textBack);

    return back;
  }

  void drawCharacter() {
    character.setEmotion(characterEmotion);
    character.updateSprite();
    characterSprite = character.drawSprite();

    PVector characterSpriteLoc = new PVector((charBackWidth/2)+margin-(character.spriteWidth/2), 
                                             height-margin-character.spriteHeight);

    shape(characterSprite, characterSpriteLoc.x, characterSpriteLoc.y);
  }

  void drawDialogue() {
    pushStyle();
    textAlign(LEFT, TOP);
    
    // Header
    textSize(30);
    text(characterName + " ("+characterEmotion+")", dialogueLoc.x, dialogueLoc.y + padding);

    // Body, wrap inside the text box
    textSize(20);
    text(dialogue, dialogueLoc.x, dialogueLoc.y + 4*padding, textBackWidth - 2*padding, textBackHeight - 2*padding - 4*padding);
    popStyle();
  }

  void startDialogue() {
    activeDialogue = this;
  }

  void stopDialogue() {
    activeDialogue = null;
  }
  
  void updateDialogue() {
    if (dialogueLoader.getProgress() == 1) {
      stopDialogue();
      return;
    }

    character = dialogueLoader.getCurrentChar();
    characterName = capitalize(dialogueLoader.getCurrentCharName());
    characterEmotion = dialogueLoader.getCurrentEmotion();
    characterSprite = character.drawSprite();
    dialogue = dialogueLoader.getCurrentText();
  }
  
  void draw() {
    shape(background);

    if (character != null) drawCharacter();

    drawDialogue();
  }

  void nextDialogue() {
    dialogueLoader.next();
    updateDialogue();
  }

  void previousDialogue() {
    dialogueLoader.previous();
    updateDialogue();
  }
}
