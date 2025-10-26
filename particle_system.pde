class ParticleSystem {
  private String spriteRootPath;
  HashMap<String, ParticleSource> sources = new HashMap<String, ParticleSource>();

  ParticleSystem(String spriteRootPath) {
    this.spriteRootPath = spriteRootPath;
  }

  public void register(String id, ParticleSource source) {
    sources.put(id, source);
  }

  public void deregister(String id) {
    sources.remove(id);
  }

  public void doAutomaticGeneration(String id, boolean state){
    sources.get(id).doAutomaticGeneration(state);
  }

  public void fillSource(String id, int count, String particleSpritePath) {
    sources.get(id).addParticles(count, generateFullPath(particleSpritePath));
  }

  public void clearSource(String id){
    sources.get(id).clearParticles();
  }

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
