// this class defines a "Play" scene

ArrayList<Turret> turrets = new ArrayList<Turret>();
ArrayList<Enemy> enemies = new ArrayList();

boolean debug = false;
Level level;
Player player;
Pathfinder pathfinder;
Enemy enemy;
PImage img;

float enemyTimer = 5;

int money = 0;

class ScenePlay 
{
  //ArrayList<Enemy> enemies = new ArrayList();

  ScenePlay() 
  {
    level = new Level();
    player = new Player();
    //enemy = new Enemy();
    pathfinder = new Pathfinder();
    img = loadImage("ArmyBase_TD.png");

    /*
    for(int i = 0; i < 3; i++)
     {
     Player p = new Player();
     enemies.add(p);
     }
     */
  }

  void update() 
  {
  }

  void draw() 
  {
    // UPDATE:

    enemyTimer -= dt;
    if (enemyTimer <= 0)
    {
      Enemy e = new Enemy();
      enemies.add(e);
      enemyTimer = 1;
      moveToTarget();
      println(enemies.size());
    }

    player.update();
    //enemy.update();

    for (int i = 0; i < enemies.size(); i++)
    {
      Enemy e = enemies.get(i);
      e.update();
    }


    // DRAW:
    background(TileHelper.isHex ? 0 : 127);
    image(img, 0, 0);

    level.draw();
    player.draw();

    for (int i = 0; i < turrets.size(); i++) {
      Turret t = turrets.get(i);
      t.draw();
    }   

    //enemy.draw();

    // ADDING ENEMIES TO ARRAY?

    for (int i = 0; i < enemies.size(); i++)
    {
      Enemy e = enemies.get(i);
      e.draw();
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

    //println(enemies.size());
    
    money += 1;
    textSize(24);
    text("$  " + money, 950, 20);
    
    isMouseOver(width/2 +350, height/2 + 150, 200, 50);//powerup 1
    isMouseOver(width/2 +350, height/2 + 250, 200, 50);//powerup 2
    isMouseOver(width/2 +350, height/2 + 350, 200, 50);//powerup 3
  }

  void mousePressed() 
  {
    //player.setTargetPosition(TileHelper.pixelToGrid(new PVector(mouseX, mouseY)));
    //enemy.setTargetPosition(TileHelper.pixelToGrid(new PVector(300, 300)));

    /*
     for(int i = 0; i < enemies.size(); i++)
     {
     Enemy e = enemies.get(i);
     e.setTargetPosition(TileHelper.pixelToGrid(new PVector(300, 300)));
     }
     */

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

        //for (int i = 0; i < turrets.size(); i++) {
        //  turrets.remove(i);
        //}

        tile.hasTurret = false;
      }
    }
    if ((isMouseOver(width/2 +350, height/2 + 150, 200, 50)) & money >= 50) { //powerup 1
      money -= 50;
    }
    if ((isMouseOver(width/2 +350, height/2 + 250, 200, 50)) & money >= 70) { //powerup 2
      money -= 70;
    }
    if ((isMouseOver(width/2 +350, height/2 + 350, 200, 50)) & money >= 100) { //powerup 3
      money -= 100;
    }
  }
}

void moveToTarget()
{
  for (int i = 0; i < enemies.size(); i++)
  {
    Enemy e = enemies.get(i);
    e.setTargetPosition(TileHelper.pixelToGrid(new PVector(450, 450)));
  }
}
