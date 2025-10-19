enum ItemState {
  INACTIVE,
  ACTIVE,
  HOVERING,
  PRESSED,
  CLICKED,
  DRAGGING
}

class Item {
  private PVector location;
  private PShape sprite;

  private boolean isDragable;
  private ItemState state;

  private String name;

  private float width, height;

  Item(float posX, float posY) {
    this.location = new PVector(posX, posY);
    
    this.state = ItemState.INACTIVE;
    activate();

    this.sprite = drawSprite();
  }

  public ItemState getState() {
    return state;
  }

  private boolean isHovering() {
    boolean isInWidthRange = mouseX >= location.x - width / 2 && mouseX <= location.x + width / 2;
    boolean isInHeightRange = mouseY >= location.y - height / 2 && mouseY <= location.y + height / 2;

    return (isInWidthRange && isInHeightRange);
  }

  public void buttonPressed() {
    if (state == ItemState.HOVERING) state = ItemState.PRESSED;
  }

  public void buttonReleased() {
    if (state == ItemState.HOVERING) state = ItemState.CLICKED;
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

  private PShape drawSprite() {
    PShape sprite = createShape(RECT, 0, 0, width, height);
    sprite.setFill(0);
    return sprite;
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