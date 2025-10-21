enum ButtonState {
  INACTIVE,
  ACTIVE,
  HOVERING,
  PRESSED,
  CLICKED
}

class Button {
  // Position and size
  private PVector location;
  private float buttonWidth, buttonHeight;

  // Appearance
  private float borderRadius, padding, textSize;
  private IntDict strokeColor, backColor, textColor;
  private PFont font;
  private String text;
  private PShape sprite;

  // State
  private ButtonState state;
  private Runnable action;

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
  public Button(float midX, float midY, int width, int height, int borderRadius, String text, Runnable action) {
    // Position and size
    this.location = new PVector(midX, midY);
    this.buttonWidth = width;
    this.buttonHeight = height;

    // Appearance
    setDefaultColors();
    this.borderRadius = borderRadius;
    this.padding = 10;
    this.textSize = 64;
    this.text = text;
    this.sprite = createButtonObject();

    // State
    this.state = ButtonState.INACTIVE;
    this.action = action;
  }

  private boolean isHovering() {
    boolean isInWidthRange = mouseX >= location.x - buttonWidth / 2 && mouseX <= location.x + buttonWidth / 2;
    boolean isInHeightRange = mouseY >= location.y - buttonHeight / 2 && mouseY <= location.y + buttonHeight / 2;

    return (isInWidthRange && isInHeightRange);
  }

  public ButtonState getState() {
    return state;
  }

  private PShape createButtonObject() {
    pushStyle();
    rectMode(CENTER);
    PShape button = createShape(RECT, location.x, location.y, buttonWidth, buttonHeight, borderRadius);
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
      while (textWidth(text) + (2 * padding) > buttonWidth && textSize > 0) {
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
  public void setText(String bText) {
    text = bText;
    renderText();
  }

  public void buttonPressed() {
    if (state == ButtonState.HOVERING) state = ButtonState.PRESSED;
  }

  public void buttonReleased() {
    if (state == ButtonState.PRESSED && isHovering()) {
      state = ButtonState.CLICKED;
      action.run();
      return;
    }
    if (state != ButtonState.INACTIVE) state = ButtonState.ACTIVE;
  }

  /**
   * Activates the button and adds it to activeButtons.
   */
  public void activate() {
    if (state == ButtonState.INACTIVE) {
      state = ButtonState.ACTIVE;
      activeButtons.add(this);
    }
  }

  /**
   * Deactivates the button and removes it from activeButtons.
   */
  public void deactivate() {
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
  public void setColorStates(color[] colors, IntDict dict) {
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
  public void setColors(color[] strokeColors, color[] backColors, color[] textColors) {
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
  public void draw() {
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
