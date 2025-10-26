class ParticleSystem {
  private String spriteRootPath;
  HashMap<String, ParticleSource> sources = new HashMap<String, ParticleSource>();

  public ParticleSystem(String spriteRootPath) {
    this.spriteRootPath = spriteRootPath;
  }

  /**
   * Registers a ParticleSource from the active list.
   *
   * @param id The ID of the ParticleSource to register
   * @param source The Source to add
   */
  public void register(String id, ParticleSource source) {
    sources.put(id, source);
  }

  /**
   * Deregisters a ParticleSource from the active list.
   *
   * @param id The ID of the ParticleSource to deregister
   */
  public void deregister(String id) {
    sources.remove(id);
  }

  public void doAutomaticGeneration(String id, boolean state){
    sources.get(id).doAutomaticGeneration(state);
  }

  /**
   * Adds Particles to the pool and activeParticles for a given ParticleSource.
   *
   * @param id The ID of the ParticleSource to add Particles to 
   * @param count The amount of particles to add
   * @param particleSpritePath The path to the sprite of the particle SVG
   */
  public void fillSource(String id, int count, String particleSpritePath) {
    sources.get(id).addParticles(count, generateFullPath(particleSpritePath));
  }

  /**
   * Clears all the Particles from the pool and activeParticles for a given ParticleSource.
   *
   * @param id The ID of the ParticleSource to clear
   */
  public void clearSource(String id){
    sources.get(id).clearParticles();
  }

  /**
   * Draws all active Particles and (if active) debugInfo.
   *
   * @param showDebug boolean - show (debug) information about the particle
   */
  public void display(boolean showDebug) {
    sources.entrySet().forEach(entry -> entry.getValue().displayAll(showDebug));
  }

  /**
   * Generates the full path of the sprite
   *
   * @param filename the name of the file to get the full path for
   *
   * @return a String with the full path to the SVG-file for the sprite
   */
  public String generateFullPath(String filename) {
    return spriteRootPath + filename + ".svg";
  }
}
