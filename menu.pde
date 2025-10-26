class MenuManager {
  private ArrayList<Menu> menus = new ArrayList<Menu>();
  private Menu activeMenu;

  /**
   * Initializes all the menus.
   */
  public void init() {
    menus.add(
      new Menu("pause", new ArrayList<Button>() {{
        add(new Button(width / 4, height / 2 - 150, 400, 100, 10, "Start Game", () -> closeMenu()));
        add(new Button(width / 4, height / 2, 400, 100, 10, "Options", () -> menuManager.openMenu("settings")));
        add(new Button(width / 4, height / 2 + 150, 400, 100, 10, "Exit", () -> exit()));
      }})
    );

    menus.add(
      new Menu("settings", new ArrayList<Button>() {{
        add(new Button(width / 4, height / 2 - 150, 400, 100, 10, "Back", () -> closeMenu()));
        add(new Button(width / 4, height / 2, 400, 100, 10, "Show Debug", () -> showDebug()));
      }})
    );
  }

  /**
   * Displays the active menu if present.
   */
  public void displayActive() {
    if (activeMenu != null) activeMenu.draw();
  }

  /**
   * Opens a new menu, depending on the menu's name.
   *
   * @param name The name of the menu to open
   */
  public void openMenu(String name) {
    gameState = GameState.PAUSED;
    menus.stream()
      .filter(menu -> menu.getName() == name)
      .findFirst()
      .ifPresent(menu -> activeMenu = menu);
    
    activeMenu.openMenu();
  }

  /**
   * Closes the active menu.
   */
  public void closeMenu() {
    activeMenu.closeMenu();
    activeMenu = null;
    gameState = GameState.RUNNING;
  }

  /**
   * Handles mousePressed for the active menu.
   */
  public void buttonPressed() {
    if (activeMenu != null) activeMenu.buttonPressed();
  }

  /**
   * Handles mouseReleased for the active menu.
   */
  public void buttonReleased() {
    if (activeMenu != null) activeMenu.buttonReleased();
  }

  /**
   * Handles the changing of the cursor for the active menu.
   */
  public void setCursor() {
    if (activeMenu != null) activeMenu.setCursor();
    else cursor(ARROW);
  }
}

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
