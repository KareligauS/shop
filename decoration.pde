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
      #333333, true, generateFullPath("top_board_back"))
    );
    decorations.add(
      new Decoration("top_board_sign_back", 
      new PVector(100, 0), new PVector(width - 200, 200), 
      #555555, true, generateFullPath("top_board_sign"))
    );
    decorations.add(
      new Decoration("logo", 
      new PVector(150, 0), new PVector(200, 200), 
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
      #FFFF33, false, generateFullPath("door"))
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

    //Bench
    decorations.add(
      new Decoration("bench", 
      new PVector(250, 730), new PVector(400, 200), 
      #FF8000, false, generateFullPath("bench"))
    );
  }

  /**
   * Displays all active Decorations.
   */
  public void displayAll() {
    decorations.stream()
      .filter(decoration -> decoration.isActive)
      .forEach(decoration -> {
        if (showDebug) decoration.displayBackground();
        decoration.display();
    });

    if (showDebug) decorations.forEach(Decoration::displayInfo);
  }

  /**
   * Handles clicking on the Decorations
   */
  public void handleMousePressed(PVector mousePosition){
    List<Decoration> clickedDecorations = decorations.stream()
      .filter(item -> item.isInside(mousePosition))
      .toList();
    
    runIfNameMatches(clickedDecorations, "logo", () -> logoDialogue.startDialogue());
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

//Actor of the scene that has a sprite.
class Decoration extends RectActor {
  private String name;
  private PShape sprite;
  private boolean showBackground;

  public Decoration(String name, PVector initialPos, PVector size, color backgroundColor, boolean showBackground, String spritePath){
    this.name = name;
    this.size = size;
    this.position = initialPos;
    this.isActive = true;
    this.backgroundColor = backgroundColor;
    this.showBackground = showBackground;
    updateSprite(spritePath);
  }

  /**
   * Updates the sprite of the Decoration.
   */
  public void updateSprite(String path) {
    try {
      sprite = loadShape(path);
    }
    catch (Exception e) {
      sprite = null;
      println("Error: Could not load sprite for \"" + name + "\" from " + path);
    }
  }

  /**
   * Displays the item.
   */
  public void display() {
    if (doStroke) stroke(0);
    else noStroke();

    if (showBackground) displayBackground();

    if (sprite != null) shape(sprite, position.x, position.y, size.x, size.y);
  }

  /**
   * Displays the (debug) info. of the Decoration.
   */
  public void displayInfo() {
    textSize(16);
    fill(#000000);
    String message = MessageFormat.format("Name: `{0}` \nPos: ({1}; {2}) \nSize: ({3}; {4})", name, position.x, position.y, size.x, size.y);
    text(message, (position.x + size.x/2) - 40, (position.y + size.y/2));
  }
}
