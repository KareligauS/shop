class ParticleSource{
  private PVector startPoint, endPoint;
  private PVector particleInitialSize, particleFinalSize;
  private float particleSpeed;
  private float spawnDelay;
  private float nearTolerance;
  private boolean automatedGeneration = true;

  private ArrayList<Particle> pool = new ArrayList<Particle>();
  private ArrayList<Particle> activeParticles = new ArrayList<Particle>();

  public ParticleSource(PVector startPoint, PVector endPoint, PVector particleInitialSize, PVector particleFinalSize, float particleSpeed, float spawnDelay, boolean automatedGeneration){
    this.startPoint = startPoint;
    this.endPoint = endPoint;
    this.spawnDelay = spawnDelay;
    this.particleSpeed = particleSpeed;
    this.particleInitialSize = particleInitialSize;
    this.particleFinalSize = particleFinalSize;
    this.nearTolerance = 10;
    this.automatedGeneration = automatedGeneration;
  }

  public void doAutomaticGeneration(boolean state){
    automatedGeneration = state;
  }

  /**
   * Clears all the Particles from the pool and activeParticles.
   */
  public void clearParticles(){
    pool.clear();
    activeParticles.clear();
  }

  /**
   * Adds a new particle to the pool, so it can later be used later.
   */
  public void addParticles(int count, String particleSpritePath){
    for(int i = 0; i < count; i++){
      Particle particle = new Particle("particle", startPoint.copy(), particleInitialSize.copy(), particleFinalSize.copy(), #FFFFFF, false, particleSpritePath);
      particle.isActive = false;
      pool.add(particle);
    }
  }

  /**
   * Activates a random particle by getting it from the pool.
   */
  private void activateRandomParticle(){
    if (pool.size() == 0) return;

    Particle randomParticle = pool.get(int(random(pool.size() - 1)));
    pool.remove(randomParticle);
    activeParticles.add(randomParticle);
    randomParticle.isActive = true;
  }

  /**
   * Deactivates the particle by removing it from activeParticles. 
   */
  private void deactivateParticle(Particle particle){
    particle.position = new PVector(startPoint.x, startPoint.y);
    pool.add(particle);
    activeParticles.remove(particle);
  }

  /**
   * Updates the particle - move, deactivate.
   */
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

  /**
   * Draws the particle.
   */
  public void displayParticles(){
    activeParticles.forEach(item -> item.display());
  }

  /**
   * Displays (debug) information about the particle 
   */
  public void displayParticlesInfo(){
    activeParticles.forEach(item -> item.displayInfo());
  }

  /**
   * Draws all active Particles and (if active) debugInfo.
   *
   * @param showDebug boolean - show (debug) information about the particle
   */
  public void displayAll(boolean showDebug){
    updateParticles();
    displayParticles();
    if (showDebug) displayParticlesInfo();
  }
}