class Character {
  String name;
  PShape sprite;
  int spriteWidth, spriteHeight;
  int maxSpriteWidth, maxSpriteHeight;

  Character(String charName, int initMaxSpriteWidth, int initMaxSpriteHeight) {
    name = charName;
    
    maxSpriteWidth = initMaxSpriteWidth;
    maxSpriteHeight = initMaxSpriteHeight;

    spriteWidth = 150;
    spriteHeight = 200;
  }

  PShape drawSprite() {
    PShape sprite = createShape(RECT, 0, 0, spriteWidth, spriteHeight);

    return sprite;
  }

  void updateSprite() {
    sprite = drawSprite();
  }
}
