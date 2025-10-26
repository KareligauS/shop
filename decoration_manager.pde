class DecorationManager {
  private String spriteRootPath;
  private ArrayList<Decoration> decorations = new ArrayList<Decoration>();

  public DecorationManager(String rootPath) {
    spriteRootPath = rootPath;
  }

  /**
   * Initiates all decorations.
   */
  public void init() {
    decorations.add(
      new Decoration("top_board_back", 
      new PVector(0, 0), new PVector(width, 200), 
      #999999, true, generateFullPath("top_board_back"))
    );
    decorations.add(
      new Decoration("top_board_sign_back", 
      new PVector(100, 0), new PVector(width - 200, 200), 
      #999999, true, null)
    );
    decorations.add(
      new Decoration("top_board_sign_text", 
      new PVector(350, 0), new PVector(width - 550, 200), 
      #999999, true, generateFullPath("top_board_sign"))
    );
    decorations.add(
      new Decoration("logo_back", 
      new PVector(150, 0), new PVector(200, 200), 
      #555555, true, null)
    );
    decorations.add(
      new Decoration("logo", 
      new PVector(250, 100), new PVector(200, 200), 
      #ADD8E6, false, generateFullPath("logo"))
    );
    decorations.add(
      new Decoration("column_left", 
      new PVector(0, 200), new PVector(100, height - 200), 
      #CCCCCC, true, generateFullPath("column"))
    );
    decorations.add(
      new Decoration("column_right", 
      new PVector(width-100, 200), new PVector(100, height - 200), 
      #CCCCCC, true, generateFullPath("column"))
    );

    //Inside Shop
    decorations.add(
      new Decoration("table", 
      new PVector(135, 650), new PVector(600, 350), 
      #FFFFFF, false, generateFullPath("table"))
    );

    decorations.add(
      new Decoration("picture_left", 
      new PVector(150, 300), new PVector(250, 250), 
      #FFFFFF, false, generateFullPath("picture_4"))
    );

    decorations.add(
      new Decoration("musicbox_inside", 
      new PVector(475, 500), new PVector(250, 150), 
      #FFFFFF, false, generateFullPath("musicbox"))
    );

    //Shelf
    for (int i = 0; i < 5; i++) {
      float sizeX = 300;
      float sizeY = 10;
      float offset = 100;

      decorations.add(
        new Decoration("shelf_rack_horizontal_" + i, 
        new PVector(1108, 480 + sizeY*i + offset*i), new PVector(sizeX, sizeY), 
        #555555, true, generateFullPath("shelf_rack_horizontal"))
      );
    }

    for (int i = 0; i < 3; i++) {
      float sizeX = 10;
      float sizeY = 440;
      float offset = 135;

      decorations.add(
        new Decoration("shelf_rack_vertical_" + i, 
        new PVector(1108 + sizeX*i + offset*i, 480), new PVector(sizeX, sizeY), 
        #555555, true, generateFullPath("shelf_rack_vertical"))
      );
    }

    //Front Layout
    decorations.add(
      new Decoration("shop_top", 
      new PVector(100, 200), new PVector(width-200, 50), 
      #FFFFFF, true, generateFullPath("shop_top"))
    );

    for (int i = 0; i < 5; i++) {
      float sizeX = 27;
      float sizeY = 900;
      float offset = 300;

      decorations.add(
        new Decoration("window_column_" + i, 
        new PVector(100 + sizeX*i + offset*i, 250), new PVector(sizeX, sizeY), 
        #EEEEEE, true, generateFullPath("window_column"))
      );
    }

    for (int i = 0; i < 4; i++) {
      float sizeX = 300;
      float sizeY = 900;
      float offset = 27;

      if (i == 2) continue;

      decorations.add(
        new Decoration("window_glass_" + i, 
        new PVector(127 + sizeX*i + offset*i, 250), new PVector(sizeX, sizeY), 
        #FFFFFF, false, generateFullPath("glass"))
      );
    }

    decorations.add(
      new Decoration("shop_bottom", 
      new PVector(100, height-30), new PVector(width-200, 30), 
      #FFFFFF, true, generateFullPath("shop_bottom"))
    );

    //Door
    decorations.add(
      new Decoration("door_top",
      new PVector(781, 250), new PVector(300, 150), 
      #FFFFFF, true, generateFullPath("door_top"))
    );

    decorations.add(
      new Decoration("door_body",
      new PVector(781, 400), new PVector(300, 530), 
      #FFFF33, false, generateFullPath("door_closed"))
    );

    //Bench
    decorations.add(
      new Decoration("bench", 
      new PVector(270, 730), new PVector(400, 200), 
      #FF8000, false, generateFullPath("bench"))
    );
  }

  /**
   * Displays all active Decorations.
   */
  public void displayAll() {
    decorations.stream()
      .filter(item -> item.name == "logo")
      .forEach(item -> item.sprite.rotate(.05));

    decorations.stream()
      .filter(decoration -> decoration.isActive)
      .forEach(decoration -> {
        if (showDebug) decoration.displayBackground();
        decoration.display();
    });

    if (showDebug) decorations.forEach(Decoration::displayInfo);
  }

  /**
   * Changes size of decoration with matched name.
   */
  public void changeSize(String name, PVector size){
    decorations.stream()
      .filter(item -> item.name == name)
      .findFirst()
      .ifPresent(item -> item.changeSize(size));
  }

  /**
   * Changes sprite of decoration with matched name.
   */
  public void changeSprite(String name, String spritePath){
    decorations.stream()
      .filter(item -> item.name == name)
      .findFirst()
      .ifPresent(item -> item.updateSprite(generateFullPath(spritePath)));
  }

  /**
   * Runs the action associated with the Decoration pressed.
   */
  public void runIfNameMatches(List<Decoration> collection, String name, Runnable action){
    if (collection.stream().anyMatch(item -> item.name == name)) action.run();
  }
  
  /**
   * Generates the full path of the sprite
   *
   * @param filename the name of the file to get the full path for
   *
   * @return a String with the full path to the SVG-file for the sprite
   */
  public String generateFullPath(String filename) {
    return spriteRootPath + filename + ".svg";
  }
}