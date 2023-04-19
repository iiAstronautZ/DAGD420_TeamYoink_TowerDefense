// this class defines a "Play" scene

ArrayList<Turret> turrets = new ArrayList<Turret>();

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
    image(img, 0, 0);

    level.draw();
    player.draw();

    for (int i = 0; i < turrets.size(); i++) {
      Turret t = turrets.get(i);
      t.draw();
    }

    // TODO: using mouse position, get tile. set it's hover property to true
    Point g = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));
    Tile tile = level.getTile(g);
    tile.hover = true;


    // TODO: draw a little ellipse in the tile's center
    PVector m = tile.getCenter();
    fill(0);
    //ellipse(m.x, m.y, 8, 8);


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
    //player.setTargetPosition(TileHelper.pixelToGrid(new PVector(mouseX, mouseY)));
    Point point = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));
    Tile tile = level.getTile(point);

    PVector pos = tile.getCenter();

    Turret t = new Turret();

    if (mouseButton == LEFT) {
      if (canPlaceTurret) {

        if (!tile.hasTurret) {
          turrets.add(t);
          t.x = pos.x;
          t.y = pos.y;
        } else println("A turret is already on this tile!!!");
        tile.hasTurret = true;
      }
    } else if (mouseButton == RIGHT) {
      if (tile.hasTurret) {

        //turrets.remove(t);

        tile.hasTurret = false;
      }
    }
  }
}
