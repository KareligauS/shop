/**
 * Interface that defines basic elements that can be displayed.
 */
abstract class IDisplayable {
  boolean isActive;
  abstract void display();
}

/**
 * A displayable element of the scene that can perform basic actions. 
 */
abstract class Actor extends IDisplayable {
  public PVector position;
  abstract void display();
}

/**
 * Actor that has rect as a base 
 */
abstract class RectActor extends Actor {
  public boolean doStroke = false;
  public color strokeColor = #FFFFFF;
  public float strokeWeight = 2f;
  public color backgroundColor = #000000;
  public PVector size = new PVector(0, 0);

  /**
   * Displays the (debug) background of the Actor.
   */
  public void displayBackground(){
    setupStroke();
    fill(backgroundColor);
    rect(position.x, position.y, size.x, size.y);
  }

  /**
   * Setups the stroke according to stroke params.
   */
  public void setupStroke(){
    if (doStroke) {
      strokeWeight(strokeWeight);
      stroke(strokeColor);
    }
    else noStroke();
  }

  /**
   * Determines if position is inside rect body of actor.
   */
  public boolean isInside(PVector pointerPosition){
    if (pointerPosition.x > minX() && pointerPosition.x < maxX() && pointerPosition.y > minY() && pointerPosition.y < maxY()) 
      return true;
    else
      return false;
  }

  /**
   * Changes size of the actor.
   */
  public void changeSize(PVector size){
    this.size = new PVector(size.x, size.y);
  }

  /**
   * Gets the x-coordinates of the left side.
   *
   * @return a float representing the x-coordinates of the left side
   */
  public float minX() {
    return position.x;
  }

  /**
   * Gets the x-coordinates of the right side.
   *
   * @return a float representing the x-coordinates of the right side
   */
  public float maxX() {
    return position.x + size.x;
  }

  /**
   * Gets the y-coordinates of the top side.
   *
   * @return a float representing the y-coordinates of the top side
   */
  public float minY() {
    return position.y;
  }

  /**
   * Gets the y-coordinates of the bottom side.
   *
   * @return a float representing the y-coordinates of the bottom side
   */
  public float maxY() {
    return position.y + size.y;
  }

  /**
   * Display the Actor.
   */
  abstract void display();
}
