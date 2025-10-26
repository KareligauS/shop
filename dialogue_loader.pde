class DialogueLoader {
  private JSONObject script;
  private JSONArray partArray;
  private String currentPart;
  private String oldCharName;
  private Emotion oldEmotion;
  private Character oldChar;
  private int index;

  public DialogueLoader(String path) {
    loadScript(path);
  }

  /**
   * Loads the full script, from a given JSON file.
   *
   * @param path the path to the JSON file to load the script from
   */
  public void loadScript(String path) {
    try {
      this.script = loadJSONObject(path);
    } catch (Exception e) {
      println("Failed to load the dialogue json: " + e);
      script = null;
    }
  }

  /**
   * Loads a part from the script.
   *
   * @param partName the name of the part to load from the script
   */
  public void loadPart(String partName) {
    this.currentPart = partName;
    if (script == null) {
      partArray = new JSONArray();
      return;
    }

    if (script.hasKey(partName)) {
      partArray = script.getJSONArray(partName);
    } else {
      println("Part not found: " + partName);
      partArray = new JSONArray();
    }
    
    index = 0;
  }

  /**
   * Gets a snippet from the loaded part - character-info and text.
   *
   * @param idx the index of the entry to load
   *
   * @return a JSONObject containing all the information of the snippet
   */
  public JSONObject getEntry(int idx) {
    if (partArray == null || idx < 0 || idx >= partArray.size()) return null;
    try {
      return partArray.getJSONObject(idx);
    } catch (Exception e) {
      println("Entry at " + idx + " is not an object or couldn't be read: " + e);
      return null;
    }
  }

  /**
   * Gets the character for the current snippet.
   *
   * @returns the Character associated with the current snippet
   */
  public Character getCurrentChar() {
    JSONObject e = getEntry(index);
    if (e == null) return null;
    
    oldChar = e.hasKey("char") ? characters.get(e.getString("char")) : oldChar;
    return oldChar;
  }

  /**
   * Gets the name of the character for the current snippet.
   *
   * @return a Sting with the name of the Character associated with the current snippet
   */
  public String getCurrentCharName() {
    JSONObject e = getEntry(index);
    if (e == null) return "";
    oldCharName = e.hasKey("char") ? e.getString("char") : oldCharName;
    return oldCharName;
  }

  /**
   * Gets the emotion of the character for the current snippet.
   *
   * @return the Emotion of the Character associated with the current snippet
   */
  public Emotion getCurrentEmotion() {
    JSONObject e = getEntry(index);
    if (e == null) return null;
    
    String emotionString = e.hasKey("emotion") ? e.getString("emotion") : "";

    switch (emotionString) {
      case "happy":
        oldEmotion = Emotion.HAPPY;
        break;
      case "sad":
        oldEmotion = Emotion.SAD;
        break;
      case "angry":
        oldEmotion = Emotion.ANGRY;
        break;
      case "neutral":
        oldEmotion = Emotion.NEUTRAL;
        break;
      default:
        break;
    }

    return oldEmotion;
  }

  /**
   * Gets the text of the current snippet.
   *
   * @return a String with the text associated with the current snippet
   */
  public String getCurrentText() {
    JSONObject e = getEntry(index);
    if (e == null) return "";
    return e.hasKey("text") ? e.getString("text") : "";
  }

  /**
   * Gets the name of the current part.
   *
   * @return a String with the name of the current part
   */
  public String getCurrentPart() {
    return currentPart;
  }

  /**
   * Gets the progess of the current part.
   *
   * @return a float with the progress through the current part (0.0 - 1.0)
   */
  public float getProgress() {
    if (partArray == null || partArray.size() == 0) return 0;
    if (partArray.size() == 1) return 1.0;
    if (index == partArray.size()) return 1.0;
    return index / float((partArray.size()) - 1);
  }

  /**
   * Gets the index of the current snippet.
   *
   * an int with the current index of the current snippet (0 - inf)
   */
  public int getIndex() {
    return index;
  }

  /**
   * Increments the index by one.
   */
  public void next() {
    if (partArray == null || partArray.size() == 0) return;
    index = min(index + 1, partArray.size() - 1);
  }

  /**
   * Decrements the index by one.
   */
  public void previous() {
    if (partArray == null || partArray.size() == 0) return;
    index = max(index - 1, 0);
  }

  /**
   * Sets the index to a specified value.
   *
   * @param i the target index
   */
  public void setIndex(int i) {
    if (partArray == null) return;
    this.index = constrain(i, 0, partArray.size() - 1);
  }

  /**
   * Gets the length of the current part.
   *
   * @return an int with the length (amount of snippets) of the part.
   */
  public int size() {
    return partArray == null ? 0 : partArray.size();
  }
}
