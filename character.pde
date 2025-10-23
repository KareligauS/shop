enum Emotion {
  HAPPY,
  SAD,
  ANGRY,
  NEUTRAL
}

class Character {
  private String name;
  private PShape sprite;
  private int spriteWidth, spriteHeight;
  private Emotion emotion;

  public Character(String name) {
    this.name = name;
    
    this.emotion = Emotion.NEUTRAL;

    this.spriteWidth = 300 - 2*20; // activeDialogue.charBackWidth - 2*activeDialogue.padding
    this.spriteHeight = spriteWidth;

    characters.put(name, this);
  }

  public void setEmotion(Emotion emotion) {
    this.emotion = emotion;
  }

  public void updateSprite() {
    String path = "./sprites/characters/" + name + "/" + emotion.toString().toLowerCase() + ".svg";

    sprite = loadShape(path);

    if (sprite == null) {
      println("Error: Could not load sprite from " + path);
    }
  }

  public PShape getSprite() {
    return sprite;
  }
}
