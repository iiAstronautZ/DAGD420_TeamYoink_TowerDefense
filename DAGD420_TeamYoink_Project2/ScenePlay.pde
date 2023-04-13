// this class defines a "Play" scene

boolean debug = false;
Level level;
Player player;
Pathfinder pathfinder;
PImage img;

class ScenePlay {
  ScenePlay() {
    level = new Level();
    player = new Player();
    pathfinder = new Pathfinder();
    img = loadImage("background.png");
  }

  void update() {
  }

  void draw() {
    // UPDATE:
    player.update();

    // DRAW:
    background(TileHelper.isHex ? 0 : 127);
    //image(img, 0, 0);

    level.draw();
    player.draw();

    // TODO: using mouse position, get tile. set it's hover property to true
    Point g = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));
    Tile tile = level.getTile(g);
    tile.hover = true;
    // TODO: draw a little ellipse in the tile's center
    PVector m = tile.getCenter();
    fill(0);
    ellipse(m.x, m.y, 8, 8);


    // DRAW DEBUG INFO:
    fill(255, 255, 0);
    //String s1 = (pathfinder.useManhattan) ? "(h) heuristic: manhattan" : "(h) heuristic: euclidian";
    //String s2 = (level.useDiagonals) ? "(d) diagonals: yes" : "(d) diagonals: no";
    //String s3 = (TileHelper.isHex) ? "(g) grid: hex" : "(g) grid: square";
    //String s4 = (debug) ? "(`) debug: on" : "(`) debug: off";
    //text(s1, 10, 15);
    //text(s2, 10, 30);
    //text(s3, 10, 45);
    //text(s4, 10, 60);
  }

  void mousePressed() {
    player.setTargetPosition(TileHelper.pixelToGrid(new PVector(mouseX, mouseY)));
  }
}
