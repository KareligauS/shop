enum ItemState {
  DEFAULT,
  HOVERING,
  PRESSED,
  CLICKED,
  DRAGGING,
  INACTIVE
}

class Item {
  PVector location;
  PShape sprite;

  boolean isDragable;
  ItemState state;

  String name;

  float width, height;

  Item(float posX, float posY) {
    location = new PVector(posX, posY);
    
    state = ItemState.INACTIVE;
    activate();

    sprite = drawSprite();
  }

  ItemState getState() {
    return state;
  }

  private boolean isHovering() {
    boolean isInWidthRange = mouseX >= location.x - width / 2 && mouseX <= location.x + width / 2;
    boolean isInHeightRange = mouseY >= location.y - height / 2 && mouseY <= location.y + height / 2;

    return (isInWidthRange && isInHeightRange);
  }

    void buttonPressed() {
    if (state == ItemState.HOVERING) state = ItemState.PRESSED;
  }

  void buttonReleased() {
    if (state == ItemState.HOVERING) state = ItemState.CLICKED;
  }

  /**
   * Activates the button and adds it to activeItems.
   */
  void activate() {
    if (state == ItemState.INACTIVE) {
      state = ItemState.DEFAULT;
      activeItems.add(this);
    }
  }

  /**
   * Deactivates the item and removes it from activeItems.
   */
  void deactivate() {
    if (state != ItemState.INACTIVE) {
      state = ItemState.INACTIVE;
      activeItems.remove(this);
    }
  }

  PShape drawSprite() {
    return createShape(RECT, 0, 0, width, height);
  }

  void draw() {
    // switch (state) {
    //   case DEFAULT:
    //     println("DEFAULT");
    //     break;
    //   case HOVERING:
    //     println("HOVERING");
    //     break;
    //   case PRESSED:
    //     println("PRESSED");
    //     break;
    //   case CLICKED:
    //     println("CLICKED");
    //     break;
    //   case DRAGGING:
    //     println("DRAGGING");
    //     break;
    //   case INACTIVE:
    //     println("INACTIVE");
    //     break;
    // }

    shape(sprite, location.x, location.y);
  }
}