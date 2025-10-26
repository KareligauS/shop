class DecorationEventHandler{
  private DecorationManager model;
  private boolean isDoorOpened;

  public DecorationEventHandler(DecorationManager model){
    this.model = model;
  }

  /**
    * Handles clicking on the Decorations
    */
  public void handleMousePressed(PVector mousePosition){
    List<Decoration> clickedDecorations = model.decorations.stream()
    .filter(item -> item.isInside(mousePosition))
    .toList();

    switch (gameState) {
      case FINNISHED:
        model.runIfNameMatches(clickedDecorations, "door_body", () -> {
          if (isDoorOpened) closeDoor();
          else openDoor();
        });
        break;
      default:
        model.runIfNameMatches(clickedDecorations, "logo_back", () -> logoDialogue.startDialogue());
        break;
    }
  }

  /** 
    * Specific events for decorations
    */
  public void openDoor(){
    model.changeSprite("door_body", "door_opened");
    model.changeSize("door_body", new PVector(100, 530));
    isDoorOpened = true;
  }

  public void closeDoor(){
    model.changeSprite("door_body", "door_closed");
    model.changeSize("door_body", new PVector(300, 530));
    isDoorOpened = false;
  }
}