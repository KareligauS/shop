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

  public void setEmotion(Emotion emotion) {
    this.emotion = emotion;
  }

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

  public PShape getSprite() {
    return sprite;
  }
}
