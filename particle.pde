class Particle extends Decoration{
    private boolean bounce;

    Particle(String name, PVector initialPos, PVector size, color backgroundColor, boolean showBackground, String spritePath, color spriteColor){
        super(name, initialPos, size, backgroundColor, showBackground, spritePath);

        getSprite().setFill(spriteColor);
    }

    public void moveTowardsPoint(PVector target, float speed) {
        PVector direction = PVector.sub(target, position);
        float distance = direction.mag();

        if (distance == 0) return;

        direction.normalize();
        float step = Math.min(speed, distance);
        PVector movement = PVector.mult(direction, step);
        position.add(movement);
    }

    public boolean nearPoint(PVector point, float tolerance){
        return position.dist(point) < tolerance;
    }
}