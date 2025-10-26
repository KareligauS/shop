class ParticleSource{
    private PVector startingPoint;
    private PVector endPoint;
    private PVector particleInitialSize;
    private PVector particleFinalSize;
    private float particleSpeed;
    private float spawnDelay;
    private float nearTolerance = 10;
    private boolean automatedGeneration = true;

    private ArrayList<Particle> pool = new ArrayList<Particle>();
    private ArrayList<Particle> activeParticles = new ArrayList<Particle>();

    public ParticleSource(PVector startingPoint, PVector endPoint, PVector particleInitialSize, PVector particleFinalSize, float particleSpeed, float spawnDelay, boolean automatedGeneration){
        this.startingPoint = startingPoint;
        this.endPoint = endPoint;
        this.spawnDelay = spawnDelay;
        this.particleSpeed = particleSpeed;
        this.particleInitialSize = particleInitialSize;
        this.particleFinalSize = particleFinalSize;
        this.automatedGeneration = automatedGeneration;
    }

    public void doAutomaticGeneration(boolean state){
        automatedGeneration = state;
    }

    public void clearParticles(){
        pool.clear();
        activeParticles.clear();
    }

    public void addParticles(int count, String particleSpritePath){
        for(int i = 0; i < count; i++){
            Particle particle = new Particle("particle", startingPoint.copy(), particleInitialSize.copy(), particleFinalSize.copy(), #FFFFFF, false, particleSpritePath);
            particle.isActive = false;
            pool.add(particle);
        }
    }

    private void activateRandomParticle(){
        if (pool.size() == 0) return;

        Particle randomParticle = pool.get(int(random(pool.size() - 1)));
        pool.remove(randomParticle);
        activeParticles.add(randomParticle);
        randomParticle.isActive = true;
    }

    private void deactivateParticle(Particle particle){
        particle.position = new PVector(startingPoint.x, startingPoint.y);
        pool.add(particle);
        activeParticles.remove(particle);
    }

    public void updateParticles(){
        if(frameCount % spawnDelay == 0 && automatedGeneration) activateRandomParticle();

        ArrayList<Particle> toDeactivate = new ArrayList<Particle>();

        activeParticles.stream()
            .filter(item -> item.nearPoint(endPoint, nearTolerance))
            .forEach(item -> toDeactivate.add(item));

        toDeactivate.forEach(item -> deactivateParticle(item));

        activeParticles.stream()
            .forEach(item -> {
                item.moveTowardsPoint(endPoint, particleSpeed);
                item.changeSizeTowardsPoint(endPoint);
        });
    }

    public void displayParticles(){
        activeParticles.forEach(item -> item.display());
    }

    public void displayParticlesInfo(){
        activeParticles.forEach(item -> item.displayInfo());
    }

    public void displayAll(boolean showDebug){
        updateParticles();
        displayParticles();
        if (showDebug) displayParticlesInfo();
    }
}