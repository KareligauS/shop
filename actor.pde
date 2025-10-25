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

  public void AddOffset(PVector offset){
    position.add(offset);
  }

  abstract void display();
}

/**
  * Actor that has rect as a base 
  */
abstract class RectActor extends Actor {
  public boolean doStroke = false;
  public color backgroundColor = #000000;
  public PVector size = new PVector(0, 0);

  public void displayBackground(){
    if (doStroke) stroke(0);
    else noStroke();
    
    fill(backgroundColor);
    rect(position.x, position.y, size.x, size.y);
  }

  abstract void display();
}
