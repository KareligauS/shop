enum Emotion {
  HAPPY,
  SAD,
  ANGRY,
  NEUTRAL
}

class Character {
  String name;
  PShape sprite;
  int spriteWidth, spriteHeight;
  float maxSpriteWidth, maxSpriteHeight;
  Emotion emotion;

  Character(String charName) {
    name = charName;
    
    emotion = Emotion.NEUTRAL;
    drawSprite();

    spriteWidth = 150;
    spriteHeight = 200;

    characters.put(name, this);
  }

  PShape drawSprite() {
    PShape sprite = createShape(GROUP);

    switch (emotion) {
      case HAPPY:
      case SAD:
      case ANGRY:
      case NEUTRAL:
        PShape body = createShape(RECT, 0, 0, 150, 200);
        PShape head = createShape(ELLIPSE, 75, 0, 175, 200);

        sprite.addChild(body);
        sprite.addChild(head);
        break;
    }

    return sprite;
  }

  void setEmotion(Emotion newEmotion) {
    emotion = newEmotion;
  }

  void updateSprite() {
    sprite = drawSprite();
  }
}
