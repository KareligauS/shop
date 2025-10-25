class DialogueOverlay {
  // Look
  private color bgColor, textColor;
  private PShape background;
  private int margin, padding;
  private int charBackWidth, chatBackHeight;
  private int textBackWidth, textBackHeight;

  // Dialogue
  private PVector dialogueLoc;
  private String dialoguePart;

  // Character
  private Character character;
  private PShape characterSprite;
  private String characterName;
  private Emotion characterEmotion;
  private String dialogue;

  public DialogueOverlay(String dialoguePart) {
    dialogueLoader.loadPart(dialoguePart);

    this.dialoguePart = dialoguePart;

    this.bgColor = 30;
    this.textColor= 255;

    this.margin = 50;
    this.padding = 20;
    this.charBackWidth = 300;
    this.chatBackHeight = 350;
    this.textBackWidth = width - charBackWidth - 2*margin;
    this.textBackHeight = (3*chatBackHeight)/4;
    
    this.background = drawBackground();

    this.dialogueLoc = new PVector(margin + charBackWidth + padding, height - textBackHeight - margin);

    updateDialogue();
  }

  private PShape drawBackground() {
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

  private void drawCharacter() {
    character.setEmotion(characterEmotion);
    character.updateSprite();
    characterSprite = character.getSprite();

    PVector characterSpriteLoc = new PVector((charBackWidth/2)+margin-(character.size.x/2), 
                                             height-margin-character.size.y);

    shape(characterSprite, characterSpriteLoc.x, characterSpriteLoc.y, character.size.x, character.size.y);
  }

  private void drawDialogue() {
    pushStyle();
    textAlign(LEFT, TOP);
    fill(textColor);
    
    // Header
    textSize(30);
    text(characterName + " ("+characterEmotion+")", dialogueLoc.x, dialogueLoc.y + padding);

    // Body, wrap inside the text box
    textSize(20);
    text(dialogue, dialogueLoc.x, dialogueLoc.y + 4*padding, textBackWidth - 2*padding, textBackHeight - 2*padding - 4*padding);
    popStyle();
  }

  public void startDialogue() {
    if (activeDialogue != null) return;

    dialogueLoader.loadPart(dialoguePart);
    updateDialogue();
    activeDialogue = this;
  }

  public void stopDialogue() {
    activeDialogue = null;
  }
  
  public void updateDialogue() {
    if (dialogueLoader.getProgress() == 1) {
      stopDialogue();
      return;
    }

    character = dialogueLoader.getCurrentChar();
    characterName = capitalize(dialogueLoader.getCurrentCharName());
    characterEmotion = dialogueLoader.getCurrentEmotion();
    characterSprite = character.getSprite();
    dialogue = dialogueLoader.getCurrentText();
  }
  
  public void draw() {
    shape(background);

    if (character != null) drawCharacter();

    drawDialogue();
  }

  public void nextDialogue() {
    dialogueLoader.next();
    updateDialogue();
  }

  public void previousDialogue() {
    dialogueLoader.previous();
    updateDialogue();
  }
}
