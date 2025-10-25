class DecorationManager {
  private String spriteRootPath;
  private ArrayList<Decoration> decorations = new ArrayList<Decoration>();

  public DecorationManager(String rootPath) {
    spriteRootPath = rootPath;
  }

  //Method that instantiates all decorations.
  public void init() {
    decorations.add(
      new Decoration("top_board_back", 
      new PVector(0, 0), new PVector(width, 200), 
      #333333, generateFullPath("None"))
    );
    decorations.add(
      new Decoration("top_board_sign_back", 
      new PVector(100, 0), new PVector(width - 200, 200), 
      #555555, generateFullPath("None"))
    );
    decorations.add(
      new Decoration("logo", 
      new PVector(150, 0), new PVector(200, 200), 
      #ADD8E6, generateFullPath("logo"))
    );
    decorations.add(
      new Decoration("column_left", 
      new PVector(0, 200), new PVector(100, height - 200), 
      #CCCCCC, generateFullPath("None"))
    );
    decorations.add(
      new Decoration("column_right", 
      new PVector(width-100, 200), new PVector(100, height - 200), 
      #CCCCCC, generateFullPath("None"))
    );

    //Front Layout
    decorations.add(
      new Decoration("shop_top", 
      new PVector(100, 200), new PVector(width-200, 50), 
      #FFFFFF, generateFullPath("None"))
    );

    for (int i = 0; i < 5; i++) {
      float sizeX = 27;
      float sizeY = 900;
      float offset = 300;

      decorations.add(
        new Decoration("window_column_" + i, 
        new PVector(100 + sizeX*i + offset*i, 250), new PVector(sizeX, sizeY), 
        #EEEEEE, generateFullPath("None"))
      );
    }

    decorations.add(
      new Decoration("shop_bottom", 
      new PVector(100, height-30), new PVector(width-200, 30), 
      #FFFFFF, generateFullPath("None"))
    );

    //Door
    decorations.add(
      new Decoration("door_top",
      new PVector(781, 250), new PVector(300, 150), 
      #FFFFFF, generateFullPath("None"))
    );

    decorations.add(
      new Decoration("door_body",
      new PVector(781, 400), new PVector(300, 530), 
      #FFFF33, generateFullPath("door"))
    );

    //Shelf
    for (int i = 0; i < 5; i++) {
      float sizeX = 300;
      float sizeY = 10;
      float offset = 100;

      decorations.add(
        new Decoration("shelf_rack_horizontal_" + i, 
        new PVector(1108, 480 + sizeY*i + offset*i), new PVector(sizeX, sizeY), 
        #555555, generateFullPath("None"))
      );
    }

    for (int i = 0; i < 3; i++) {
      float sizeX = 10;
      float sizeY = 440;
      float offset = 135;

      decorations.add(
        new Decoration("shelf_rack_vertical_" + i, 
        new PVector(1108 + sizeX*i + offset*i, 480), new PVector(sizeX, sizeY), 
        #555555, generateFullPath("None"))
      );
    }

    //Bench
    decorations.add(
      new Decoration("bench", 
      new PVector(250, 730), new PVector(400, 200), 
      #FF8000, generateFullPath("bench"))
    );
  }

  public void displayAll(boolean showInfo, boolean showBackground) {
    for (Decoration entry : decorations){
      if (!entry.isActive) continue;

      if (showBackground)
        entry.displayBackground();

      entry.display();
    }

    for (Decoration entry : decorations){
      if (!entry.isActive) continue;

      if (showInfo){
        entry.displayInfo();
      }
    }
  }
  
  public String generateFullPath(String filename) {
    return spriteRootPath + filename + ".svg";
  }
}

//Actor of the scene that has a sprite.
class Decoration extends RectActor {
  private String name;
  private PShape sprite;

  public Decoration(String name, PVector initialPos, PVector size, color backgroundColor, String spritePath){
    this.name = name;
    this.size = size;
    this.position = initialPos;
    this.isActive = true;
    this.backgroundColor = backgroundColor;
    updateSprite(spritePath);
  }

  public void updateSprite(String path) {
    try {
      sprite = loadShape(path);
    }
    catch (Exception e) {
      sprite = null;
      println("Error: Could not load sprite from " + path);
    }
  }

  void display() {
    if (doStroke) stroke(0);
    else noStroke();

    if (sprite != null) {
      shape(sprite, position.x, position.y, size.x, size.y);
    }
  }

  void displayInfo() {
    textSize(16);
    fill(#000000);
    String message = MessageFormat.format("Name: `{0}` \nPos: ({1}; {2}) \nSize: ({3}; {4})", name, position.x, position.y, size.x, size.y);
    text(message, (position.x + size.x/2) - 40, (position.y + size.y/2));
  }
}
