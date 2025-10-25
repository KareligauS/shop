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
  private PVector position, destination, size;
  private PShape sprite;

  private boolean isDragable;
  private ItemState state;

  Item(float posX, float posY, float sizeX, float sizeY, String name, boolean isDragable) {
    this.position = new PVector(posX, posY);

    this.name = name;

    this.state = ItemState.INACTIVE;
    activate();

    this.isDragable = isDragable;
    this.size = new PVector(sizeX, sizeY);
    updateSprite();
  }

  Item(float posX, float posY, float sizeX, float sizeY, String name, boolean isDragable, float destinationX, float destinationY) {
    this(posX, posY, sizeX, sizeY, name, isDragable);
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
    return position.equals(destination);
  }

  private boolean isHovering() {
    boolean isInWidthRange = mouseX >= position.x && mouseX <= position.x + size.x;
    boolean isInHeightRange = mouseY >= position.y && mouseY <= position.y + size.y;

    return (isInWidthRange && isInHeightRange);
  }

  private void snapToDestination() {
    if (destination == null) return;

    if (position.dist(destination) < 50) {
      position = destination.copy();
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
    println(position);
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
    position.x = constrain(mouseX - size.x/2, 0, width-size.x);
    position.y = constrain(mouseY - size.y/2, 0, height-size.y);
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
    
    shape(sprite, position.x, position.y);
  }
}
