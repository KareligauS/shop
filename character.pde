enum Emotion {
  HAPPY,
  SAD,
  ANGRY,
  NEUTRAL
}

class Character {
  private String name;
  private PShape sprite;
  private PVector size;
  private Emotion emotion;

  public Character(String name) {
    this.name = name;
    
    this.emotion = Emotion.NEUTRAL;

    this.size = new PVector(300 - 2*20, 300 - 2*20);

    characters.put(name, this);
  }

  /**
   * Sets the emotion of the character.
   */
  public void setEmotion(Emotion emotion) {
    this.emotion = emotion;
  }

  /**
   * Updates the sprite of the character.
   */
  public void updateSprite() {
    String path = "./sprites/characters/" + name + "/" + emotion.toString().toLowerCase() + ".svg";

    try {
      sprite = loadShape(path);
    }
    catch (Exception e) {
      sprite = null;
      println("Error: Could not load sprite from " + path);
    }
  }

  /**
   * Gets the sprite of the character.
   *
   * @return a PShape of the sprite
   */
  public PShape getSprite() {
    return sprite;
  }
}
