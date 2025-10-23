class DecorationManager{
    private color defaultBackgroundColor = #777777;
    private String spriteRootPath;
    private ArrayList<Decoration> decorations = new ArrayList<Decoration>();

    public DecorationManager(String rootPath){
        spriteRootPath = rootPath;
    }

    public void init(){
        decorations.add(
            new Decoration("top_board_back", 
            new Vector2(0, 0), new Vector2(width, 200), 
            #333333, generateFullPath("None"))
        );
        decorations.add(
            new Decoration("top_board_sign_back", 
            new Vector2(100, 0), new Vector2(width - 200, 200), 
            #555555, generateFullPath("None"))
        );
        decorations.add(
            new Decoration("logo", 
            new Vector2(150, 0), new Vector2(200, 200), 
            #ADD8E6, generateFullPath("None"))
        );
        decorations.add(
            new Decoration("column_left", 
            new Vector2(0, 200), new Vector2(100, height - 200), 
            #CCCCCC, generateFullPath("None"))
        );
        decorations.add(
            new Decoration("column_right", 
            new Vector2(width-100, 200), new Vector2(100, height - 200), 
            #CCCCCC, generateFullPath("None"))
        );

        //Front Layout
        decorations.add(
            new Decoration("shop_top", 
            new Vector2(100, 200), new Vector2(width-200, 50), 
            #FFFFFF, generateFullPath("None"))
        );

        for (int i = 0; i < 5; i++){
            float sizeX = 27;
            float sizeY = 900;
            float offset = 300;

            decorations.add(
                new Decoration("window_column_" + i, 
                new Vector2(100 + sizeX*i + offset*i, 250), new Vector2(sizeX, sizeY), 
                #EEEEEE, generateFullPath("None"))
            );
        }

        decorations.add(
            new Decoration("shop_bottom", 
            new Vector2(100, height-30), new Vector2(width-200, 30), 
            #FFFFFF, generateFullPath("None"))
        );

        //Door
        decorations.add(
            new Decoration("door_top",
            new Vector2(781, 250), new Vector2(300, 150), 
            #FFFFFF, generateFullPath("None"))
        );

        decorations.add(
            new Decoration("door_body",
            new Vector2(781, 400), new Vector2(300, 530), 
            #FFFF33, generateFullPath("None"))
        );

        //Shelf
        for (int i = 0; i < 5; i++){
            float sizeX = 300;
            float sizeY = 10;
            float offset = 100;

            decorations.add(
                new Decoration("shelf_rack_horizontal_" + i, 
                new Vector2(1108, 480 + sizeY*i + offset*i), new Vector2(sizeX, sizeY), 
                #555555, generateFullPath("None"))
            );
        }

        for (int i = 0; i < 3; i++){
            float sizeX = 10;
            float sizeY = 440;
            float offset = 135;

            decorations.add(
                new Decoration("shelf_rack_vertical_" + i, 
                new Vector2(1108 + sizeX*i + offset*i, 480), new Vector2(sizeX, sizeY), 
                #555555, generateFullPath("None"))
            );
        }

        //Bench
        decorations.add(
            new Decoration("bench", 
            new Vector2(250, 730), new Vector2(400, 200), 
            #FF8000, generateFullPath("None"))
        );
    }

    public void displayAll(boolean showInfo, boolean showBackground){
        for (Decoration entry : decorations){
            if (!entry.isActive) continue;

            if (showBackground)
                entry.displayBackground();

            entry.display();
        }

        for (Decoration entry : decorations){
            if (!entry.isActive) continue;

            if (showInfo){
                entry.displayInfo();
            }
        }
    }

    public String generateFullPath(String filename){
        return spriteRootPath + filename + ".svg";
    }
}

class Decoration extends RectActor {
    private String name;
    private String spritePath;
    private PShape sprite;

    public Decoration(String _name, Vector2 _initialPos, Vector2 _size, color _backgroundColor, String _spritePath){
        name = _name;
        spritePath = _spritePath;
        size = _size;
        position = _initialPos;
        isActive = true;
        backgroundColor = _backgroundColor;
        updateSprite(spritePath);
    }

    public void updateSprite(String path) {
        try {
            sprite = loadShape(path);
        }
        catch (Exception e) {
            sprite = null;
            println("Error: Could not load sprite from " + path);
        }
    }

    void display(){
        if (doStroke)
            stroke(0);
        else 
            noStroke();
        
        if (sprite != null)
            shape(sprite, position.x, position.y, position.x + size.x, position.y + size.y);
    }

    void displayInfo(){
        textSize(16);
        fill(#000000);
        String message = MessageFormat.format("Name: `{0}` \nPos: ({1}; {2}) \nSize: ({3}; {4})", name, position.x, position.y, size.x, size.y);
        text(message, (position.x + size.x/2) - 40, (position.y + size.y/2));
    }
}
