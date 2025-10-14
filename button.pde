enum ButtonState {
  INACTIVE,
  ACTIVE,
  HOVERING,
  PRESSED,
  CLICKED
}

class Button {
  // Position and size
  PVector location;
  float width, height;

  // Appearance
  float cornerRadius, padding, textSize;
  IntDict strokeColor, backColor, textColor;
  PFont font;
  String text;
  PShape sprite;

  // State
  ButtonState state;

  private boolean isHovering() {
    boolean isInWidthRange = mouseX >= location.x - width / 2 && mouseX <= location.x + width / 2;
    boolean isInHeightRange = mouseY >= location.y - height / 2 && mouseY <= location.y + height / 2;

    return (isInWidthRange && isInHeightRange);
  }

  ButtonState getState() {
    return state;
  }

    /**
   * Initializes button properties: location, size, radius, text, and colors.
   *
   * @param midX Center x-coordinate.
   * @param midY Center y-coordinate.
   * @param buttonWidth Button width.
   * @param buttonHeight Button height.
   * @param radius Corner radius.
   * @param buttonText Text displayed in the button.
   */
  Button(float midX, float midY, float buttonWidth, float buttonHeight, float radius, String buttonText) {
    // Position and size
    location = new PVector(midX, midY);
    width = buttonWidth;
    height = buttonHeight;

    // Appearance
    setDefaultColors();
    cornerRadius = radius;
    padding = 10;
    textSize = 64;
    text = buttonText;
    sprite = createButtonObject();

    // State
    state = ButtonState.INACTIVE;
  }

  PShape createButtonObject() {
    pushStyle();
    rectMode(CENTER);
    PShape button = createShape(RECT, location.x, location.y, width, height, cornerRadius);
    button.setFill(backColor.get("current"));
    button.setStroke(strokeColor.get("current"));
    popStyle();

    return button;
  }

  /**
   * Renders the button's text at its location with current color and size.
   */
  private void renderText() {
    pushStyle();
    if (font != null) textFont(font);

    if (text != null && !text.trim().isEmpty()) {
      fill(textColor.get("current"));
      textSize(textSize);

      // Reduce text size until it fits within the width
      while (textWidth(text) + (2 * padding) > width && textSize > 0) {
        textSize -= 1;
        textSize(textSize);
      }

      textAlign(CENTER, CENTER);
      text(text, location.x, location.y);
    }
    popStyle();
  }

  /**
   * Sets the button's text and renders it.
   *
   * @param bText Text string to render.
   */
  void setText(String bText) {
    text = bText;
    renderText();
  }

  void buttonPressed() {
    if (state == ButtonState.HOVERING) state = ButtonState.PRESSED;
  }

  void buttonReleased() {
    if (state == ButtonState.PRESSED && isHovering()) {
      state = ButtonState.CLICKED;
      return;
    }
    state = ButtonState.ACTIVE;
  }

  /**
   * Activates the button and adds it to activeButtons.
   */
  void activate() {
    if (state == ButtonState.INACTIVE) {
      state = ButtonState.ACTIVE;
      activeButtons.add(this);
    }
  }

  /**
   * Deactivates the button and removes it from activeButtons.
   */
  void deactivate() {
    state = ButtonState.INACTIVE;
    activeButtons.remove(this);
  }


  /**
   * Sets the current color in each IntDict based on the given state.
   *
   * @param state State key to set as current color.
   * @param dicts IntDicts holding color values.
   */
  private void setCurrentColor(String state, IntDict... dicts) {
    Arrays.stream(dicts)
      .forEach(dict -> dict.set("current", dict.get(state)));
  }

  /**
   * Sets color states for a dictionary.
   *
   * @param colors Array: [default, hovering, clicked].
   * @param dict Dictionary to store color states.
   */
  void setColorStates(color[] colors, IntDict dict) {
    dict.set("current", colors[0]);
    dict.set("default", colors[0]);
    dict.set("hovering", colors[1]);
    dict.set("clicked", colors[2]);
  }

  /**
   * Sets color configurations for stroke, background, and text.
   *
   * @param strokeColors Array: [default, hovering, clicked] for stroke.
   * @param backColors Array: [default, hovering, clicked] for background.
   * @param textColors Array: [default, hovering, clicked] for text.
   */
  void setColors(color[] strokeColors, color[] backColors, color[] textColors) {
    strokeColor = new IntDict();
    setColorStates(strokeColors, strokeColor);

    backColor = new IntDict();
    setColorStates(backColors, backColor);

    textColor = new IntDict();
    setColorStates(textColors, textColor);
  }

  /**
   * Sets default color configurations for stroke, background, and text.
   */
  private void setDefaultColors() {
    color[] strokeColors = {0, 25, 50};
    color[] backColors = {255, 225, 205};
    color[] textColors = {0, 0, 25};

    setColors(strokeColors, backColors, textColors);
  }

  /**
   * Renders the button, updating appearance based on user interaction.
   */
  void draw() {
    switch (state) {
      case INACTIVE:
        break;
      case ACTIVE:
        setCurrentColor("default", backColor, textColor);
        if (isHovering()) state = ButtonState.HOVERING;
        break;
      case HOVERING:
        setCurrentColor("hovering", backColor, textColor);
        if (!isHovering()) state = ButtonState.ACTIVE;
        break;
      case PRESSED:
        setCurrentColor("clicked", backColor, textColor);
        break;
      case CLICKED:
        setCurrentColor("clicked", backColor, textColor);
        state = isHovering() ? ButtonState.HOVERING : ButtonState.ACTIVE;
        break;
      default:
        state = ButtonState.INACTIVE;
        break;
    }

    sprite.setFill(backColor.get("current"));
    sprite.setStroke(strokeColor.get("current"));
    shape(sprite);
    renderText();
  }
}
