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

  /**
   * Draws the background for the dialogue-overlay - character-back, and text-back.
   *
   * @return a PShape of the background
   */
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

  /**
   * Draws the character associated with the dialogue. 
   */
  private void drawCharacter() {
    character.setEmotion(characterEmotion);
    character.updateSprite();
    characterSprite = character.getSprite();

    PVector characterSpriteLoc = new PVector((charBackWidth/2)+margin-(character.size.x/2), 
                                             height-margin-character.size.y);

    shape(characterSprite, characterSpriteLoc.x, characterSpriteLoc.y, character.size.x, character.size.y);
  }

  /**
   * Draws the text for the dialogue - header-text and dialogue-text.
   */
  private void drawDialogue() {
    pushStyle();
    textAlign(LEFT, TOP);
    fill(textColor);
    
    // Header
    textSize(30);
    String headerText = MessageFormat.format("{0} ({1})", characterName, characterEmotion);
    text(headerText, dialogueLoc.x, dialogueLoc.y + padding);

    // Body, wrap inside the text box
    textSize(20);
    text(dialogue, dialogueLoc.x, dialogueLoc.y + 4*padding, textBackWidth - 2*padding, textBackHeight - 2*padding - 4*padding);
    popStyle();
  }

  /**
   * Starts the dialogue if no other dialogue is currently active.
   */
  public void startDialogue() {
    if (activeDialogue != null) return;

    dialogueLoader.loadPart(dialoguePart);
    updateDialogue();
    activeDialogue = this;
  }

  /**
   * Stops all active dialogue.
   */
  public void stopDialogue() {
    activeDialogue = null;
  }

  /**
   * Updates the active dialogue to the next snippet - character, text. 
   * Stops if all dialogue has been played.
   */
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

  /**
   * Draws the active dialogue - character, text.
   */
  public void draw() {
    shape(background);

    if (character != null) drawCharacter();

    drawDialogue();
  }

  /**
   * Advances dialogue to the next snippet.
   */
  public void nextDialogue() {
    dialogueLoader.next();
    updateDialogue();
  }

  /**
   * Gos back to previous dialogue snippet.
   */
  public void previousDialogue() {
    dialogueLoader.previous();
    updateDialogue();
  }
}
