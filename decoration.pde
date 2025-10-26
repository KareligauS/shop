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
    this.sprite = null;
    updateSprite(spritePath);
  }

  /**
   * Updates the sprite of the Decoration.
   */
  public void updateSprite(String path) {
    if (path == null) {
      println("Notice: " + path + " for " + name + " is null. Change if not intended.");
      return;
    }

    try {
      sprite = loadShape(path);
    }
    catch (Exception e) {
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
