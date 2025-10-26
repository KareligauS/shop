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

  public Item(float posX, float posY, float sizeX, float sizeY, String name, boolean isDragable) {
    this.position = new PVector(posX, posY);

    this.name = name;

    this.state = ItemState.INACTIVE;
    activate();

    this.isDragable = isDragable;
    this.size = new PVector(sizeX, sizeY);
    updateSprite();
  }

  public Item(float posX, float posY, float sizeX, float sizeY, String name, boolean isDragable, float destinationX, float destinationY) {
    this(posX, posY, sizeX, sizeY, name, isDragable);
    this.destination = new PVector(destinationX, destinationY);
  }

  /**
   * Gets the state of the item.
   *
   * @return an ItemState with the state of the item
   */
  public ItemState getState() {
    return state;
  }

  /**
   * Checks if the item is dragable.
   *
   * @return a boolean true if dragable 
   */
  public boolean isDragable() {
    return isDragable;
  }

  /**
   * Checks if the item is close to its target location.
   *
   * @return a boolean true if position == destination
   */
  public boolean isOnDestination() {
    if (state == ItemState.DRAGGING) return false;
    return position.equals(destination);
  }

  /**
   * Checks if the mousepointer is hovering the item.
   *
   * @return a boolean true if the mouse is hovering over the item
   */
  private boolean isHovering() {
    boolean isInWidthRange = mouseX >= position.x && mouseX <= position.x + size.x;
    boolean isInHeightRange = mouseY >= position.y && mouseY <= position.y + size.y;

    return (isInWidthRange && isInHeightRange);
  }

  /**
   * Sets the position to the destination if close to to the destination-position.
   */
  private void snapToDestination() {
    if (destination == null) return;

    if (position.dist(destination) < 50) {
      position = destination.copy();
    }
  }

  /**
   * Sets the state of the item to DRAGGING if isHovering and isDragable, if only
   * isHovering, it sets it to CLICKED.
   */
  public void buttonPressed() {
    if (state == ItemState.HOVERING) {
      state = isDragable ? ItemState.DRAGGING : ItemState.CLICKED;
    }
  }

  /**
   * Sets the state of the item to ACTIVE and tries to snap it to it's destination.
   */
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

  /**
   * Updates the sprite by getting it from an SVG-file.
   */
  public void updateSprite() {
    String path = "./sprites/items/" + name + ".svg";

    sprite = loadShape(path);

    if (sprite == null) {
      println("Error: Could not load sprite from " + path);
    }
  }

  /**
   * Handles the dragging of the item.
   */
  public void mouseDrag(float mouseX, float mouseY) {
    position.x = constrain(mouseX - size.x/2, 0, width-size.x);
    position.y = constrain(mouseY - size.y/2, 0, height-size.y);
  }

  /**
   * Draws the item, depending on its state.
   */
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

  /**
   * Displays the (debug) info. of the Item.
   */
  public void displayInfo() {
    textSize(16);
    fill(#000000);
    String message = MessageFormat.format("Name: `{0}` \nPos: ({1}; {2}) \nSize: ({3}; {4})\nState:{5}", name, position.x, position.y, size.x, size.y, state);
    text(message, (position.x + size.x/2) - 40, (position.y + size.y/2));
  }
}
