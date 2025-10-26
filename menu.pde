class Menu {
  private ArrayList<Button> buttons = new ArrayList<Button>();
  private String name;

  public Menu(String name, ArrayList<Button> buttons) {
    this.name = name;
    this.buttons = buttons;
  }
  
  /**
   * Gets the name of the menu.
   * 
   * @return a string of the name of the menu
   */
  public String getName() {
    return name;
  }

  /**
   * Draws all the buttons for the menu.
   */
  private void drawButtons() {  
    buttons.forEach(Button::draw);
    menuManager.setCursor();
  }

  /**
   * Sets the cursor to HAND or ARROW depenind if the cursor is hovering on a button.
   */
  public void setCursor() {
    if (buttons.stream().anyMatch(Button::isHovering)) {
      cursor(HAND);
    } else {
      cursor(ARROW);
    }
  }

  /**
   * Opens the menu; activating all the buttons.
   */
  public void openMenu() {
    buttons.stream().forEach(Button::activate);
  }

  /**
   * Draws the menu; background, text, and buttons.
   */
  public void draw() {
    pushStyle();
    fill(220);
    rect(0, 0, width, height);
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(100);
    text("GAME TITLE", 2*width/3, height/2-30);
    textSize(50);
    text("subtitle", 2*width/3, height/2+30);
    popStyle();
    drawButtons();
  }

  /**
   * Closes the menu; deactivating all the buttons.
   */
  public void closeMenu() {
    buttons.forEach(Button::deactivate);
  }

  /**
   * Handles mousePressed by itterating over all buttons.
   */
  public void buttonPressed() {
    buttons.forEach(Button::buttonPressed);
  }

  /**
   * Hanldes mouseReleased by itterating over all buttons.
   */
  public void buttonReleased() {
    buttons.forEach(Button::buttonReleased);
  }
}
