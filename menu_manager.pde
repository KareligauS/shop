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
