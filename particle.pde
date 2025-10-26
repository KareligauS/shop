class Particle extends Decoration{
  private PVector initialSize;
  private PVector initialPos;
  private PVector finalSize;

  public Particle(String name, PVector initialPos, PVector initialSize, PVector finalSize, color backgroundColor, boolean showBackground, String spritePath){
    super(name, initialPos, initialSize, backgroundColor, showBackground, spritePath);
    reset(initialPos, initialSize, finalSize);
  }

  /**
   * Moves the particle to its target.
   *
   * @param target The PVector of the position to move to
   * @param speed The speed at which to move to the target
   */
  public void moveTowardsPoint(PVector target, float speed) {
    PVector direction = PVector.sub(target, position);
    float distance = direction.mag();

    if (distance == 0) return;

    direction.normalize();
    float step = Math.min(speed, distance);
    PVector movement = PVector.mult(direction, step);
    position.add(movement);
  }

  /**
   * Changes the particles size depending on the distance to the target
   *
   * @param target The PVector of the position to move to
   */
  public void changeSizeTowardsPoint(PVector target){
    float totalDistance = PVector.sub(target, initialPos).mag();
    float traversed = PVector.sub(position, initialPos).mag();
    float fraction = traversed/totalDistance;
    PVector totalSize = PVector.sub(finalSize, initialSize);
    size = PVector.mult(totalSize, fraction);
  }

  /**
   * Reset all information (position, and (final)size) of the particle.
   *
   * @param initialPos The initial position of the Particle
   * @param initialSize The Initial size of the Particle
   * @param finalSize The final size of the Particle when it reaches its target
   */
  public void reset(PVector initialPos, PVector initialSize, PVector finalSize){
    position = initialPos;
    size = initialSize;
    this.initialSize = initialSize.copy();
    this.initialPos = initialPos.copy();
    this.finalSize = finalSize.copy();
  }

  /**
   * 
   */
  public void flick(){
    strokeColor = color(random(255));
  }

  /**
   * Checks if the Particle is close to a given point.
   *
   * @param point a PVector with the location of the point to check
   * @param tolerence the max. difference between the point and the Particle
   *
   * @return a boolean - true if the distance to the given point is maller than
   *         the tolerance
   */
  public boolean nearPoint(PVector point, float tolerance){
    return position.dist(point) < tolerance;
  }
}
