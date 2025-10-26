class Particle extends Decoration{
    PVector initialSize;
    PVector initialPos;
    PVector finalSize;

    Particle(String name, PVector initialPos, PVector initialSize, PVector finalSize, color backgroundColor, boolean showBackground, String spritePath){
        super(name, initialPos, initialSize, backgroundColor, showBackground, spritePath);
        reset(initialPos, initialSize, finalSize);
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

    public void changeSizeTowardsPoint(PVector target){
        float totalDistance = PVector.sub(target, initialPos).mag();
        float traversed = PVector.sub(position, initialPos).mag();
        float fraction = traversed/totalDistance;
        PVector totalSize = PVector.sub(finalSize, initialSize);
        size = PVector.mult(totalSize, fraction);
    }

    public void reset(PVector initialPos, PVector initialSize, PVector finalSize){
        position = initialPos;
        size = initialSize;
        this.initialSize = initialSize.copy();
        this.initialPos = initialPos.copy();
        this.finalSize = finalSize.copy();
    }

    public void flick(){
        strokeColor = color(random(255));
    }

    public boolean nearPoint(PVector point, float tolerance){
        return position.dist(point) < tolerance;
    }
}
