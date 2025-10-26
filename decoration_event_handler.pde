class DecorationEventHandler{
  private DecorationManager model;
  private boolean isDoorOpened = false;
  private boolean isInsideMusicBoxActivated = false;

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
          model.runIfNameMatches(clickedDecorations, "musicbox_inside", () -> {
            if (isInsideMusicBoxActivated) stopMusicParticlesForInsideMusicBox();
            else startMusicParticlesForInsideMusicBox();
          });
        break;
    }
  }

  /** 
    * Specific events handling for decorations
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

  public void startMusicParticlesForInsideMusicBox(){
    particleSystem.doAutomaticGeneration("left_musicbox_inside", true);
    particleSystem.doAutomaticGeneration("right_musicbox_inside", true);
    isInsideMusicBoxActivated = true;
    musicboxOnDialogue.startDialogue();
  }

  public void stopMusicParticlesForInsideMusicBox(){
    particleSystem.doAutomaticGeneration("left_musicbox_inside", false);
    particleSystem.doAutomaticGeneration("right_musicbox_inside", false);
    isInsideMusicBoxActivated = false;
    musicboxOffDialogue.startDialogue();
  }
}