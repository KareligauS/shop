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

  public void loadScript(String path) {
    try {
      script = loadJSONObject(path);
    } catch (Exception e) {
      println("Failed to load the dialogue json: " + e);
      script = null;
    }
  }

  public void loadPart(String partName) {
    currentPart = partName;
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

  public JSONObject getEntry(int idx) {
    if (partArray == null || idx < 0 || idx >= partArray.size()) return null;
    try {
      return partArray.getJSONObject(idx);
    } catch (Exception e) {
      println("Entry at " + idx + " is not an object or couldn't be read: " + e);
      return null;
    }
  }

  public Character getCurrentChar() {
    JSONObject e = getEntry(index);
    if (e == null) return null;
    
    oldChar = e.hasKey("char") ? characters.get(e.getString("char")) : oldChar;
    return oldChar;
  }

  public String getCurrentCharName() {
    JSONObject e = getEntry(index);
    if (e == null) return "";
    oldCharName = e.hasKey("char") ? e.getString("char") : oldCharName;
    return oldCharName;
  }

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

  public String getCurrentText() {
    JSONObject e = getEntry(index);
    if (e == null) return "";
    return e.hasKey("text") ? e.getString("text") : "";
  }

  public float getProgress() {
    if (partArray == null || partArray.size() == 0) return 0;
    if (partArray.size() == 1) return 1.0;
    if (index == partArray.size()) return 1.0;
    return index / float((partArray.size()) - 1);
  }

  public void next() {
    if (partArray == null || partArray.size() == 0) return;
    index = min(index + 1, partArray.size() - 1);
  }

  public void previous() {
    if (partArray == null || partArray.size() == 0) return;
    index = max(index - 1, 0);
  }

  public void setIndex(int i) {
    if (partArray == null) return;
    index = constrain(i, 0, partArray.size() - 1);
  }

  public int size() {
    return partArray == null ? 0 : partArray.size();
  }

  public int getIndex() {
    return index;
  }
}
