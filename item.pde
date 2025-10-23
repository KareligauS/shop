enum ItemState {
  INACTIVE,
  ACTIVE,
  HOVERING,
  PRESSED,
  CLICKED,
  DRAGGING
}

class Item {
  private String name;
  private PVector location;
  private PVector destination;
  private PShape sprite;

  private boolean isDragable;
  private ItemState state;

  private float spriteWidth, spriteHeight;

  Item(float posX, float posY, String name, boolean isDragable) {
    this.location = new PVector(posX, posY);

    this.name = name;

    this.state = ItemState.INACTIVE;
    activate();

    this.isDragable = isDragable;
    this.spriteWidth = this.spriteHeight = 100;
    updateSprite();
  }

  Item(float posX, float posY, String name, boolean isDragable, float destinationX, float destinationY) {
    this(posX, posY, name, isDragable);
    this.destination = new PVector(destinationX, destinationY);
  }

  public ItemState getState() {
    return state;
  }

  public boolean isDragable() {
    return isDragable;
  }

  public boolean isOnDestination() {
    if (state == ItemState.DRAGGING) return false;
    return location.equals(destination);
  }

  private boolean isHovering() {
    boolean isInWidthRange = mouseX >= location.x && mouseX <= location.x + spriteWidth;
    boolean isInHeightRange = mouseY >= location.y && mouseY <= location.y + spriteHeight;

    return (isInWidthRange && isInHeightRange);
  }

  private void snapToDestination() {
    if (destination == null) return;

    if (location.dist(destination) < 50) {
      location = destination.copy();
    }
  }

  public void buttonPressed() {
    if (state == ItemState.HOVERING) {
      state = isDragable ? ItemState.DRAGGING : ItemState.CLICKED;
    }
  }

  public void buttonReleased() {
    snapToDestination();
    if (state != ItemState.HOVERING) state = ItemState.ACTIVE;
  }

  /**
   * Activates the button and adds it to activeItems.
   */
  public void activate() {
    if (state == ItemState.INACTIVE) {
      state = ItemState.ACTIVE;
      activeItems.add(this);
    }
  }

  /**
   * Deactivates the item and removes it from activeItems.
   */
  public void deactivate() {
    if (state != ItemState.INACTIVE) {
      state = ItemState.INACTIVE;
      activeItems.remove(this);
    }
  }

  public void updateSprite() {
    String path = "./sprites/items/" + name + ".svg";

    sprite = loadShape(path);

    if (sprite == null) {
      println("Error: Could not load sprite from " + path);
    }
  }

  public void mouseDrag(float mouseX, float mouseY) {
    location.x = constrain(mouseX - spriteWidth/2, 0, width-spriteWidth);
    location.y = constrain(mouseY - spriteHeight/2, 0, height-spriteHeight);
  }

  public void draw() {
    switch (state) {
      case INACTIVE:
        break;
      case ACTIVE:
        if (isHovering()) state = ItemState.HOVERING;
        break;
      case HOVERING:
        if (!isHovering()) state = ItemState.ACTIVE;
        break;
      case PRESSED:
        break;
      case CLICKED:
        state = isHovering() ? ItemState.HOVERING : ItemState.ACTIVE;
        break;
      case DRAGGING:
        break;
      default:
        state = ItemState.INACTIVE;
        break;
    }
    
    shape(sprite, location.x, location.y);
  }
}
