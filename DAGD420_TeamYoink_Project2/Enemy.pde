class Enemy extends RadialObject
{
  // GRID-SPACE COORDINATES:
  Point gridP = new Point(); // current position
  Point gridT = new Point(); // target position (pathfinding goal)
  Point testStart = new Point(200, 200);

  // PIXEL-SPACE COORDINATES:
  PVector pixlP = new PVector(); // current pixel position

  ArrayList<Tile> path;    // the path to follow to get to the target position
  boolean findPath = false;

  boolean reachedTarget;

  int health;

  PImage alien;

  float angle;

  float PixlTx, PixlTy;

  Enemy(int health) 
  {
    int spawn = (int)random(0, 13);
    if (spawn == 0) gridP = new Point(1, 0);
    if (spawn == 1) gridP = new Point(10, 0);
    if (spawn == 2) gridP = new Point(19, 0);
    if (spawn == 3) gridP = new Point(24, 3);
    if (spawn == 4) gridP = new Point(0, 6);
    if (spawn == 5) gridP = new Point(24, 8);
    if (spawn == 6) gridP = new Point(24, 18);
    if (spawn == 7) gridP = new Point(0, 22);
    if (spawn == 8) gridP = new Point(2, 24);
    if (spawn == 9) gridP = new Point(6, 24);
    if (spawn == 10) gridP = new Point(10, 24);
    if (spawn == 11) gridP = new Point(14, 24);
    if (spawn == 12) gridP = new Point(18, 24);

    alien = loadImage("alien.png");
    alien.resize(65, 65);
    
    audioAlienSpawn.play();
    audioAlienSpawn.rewind();

    this.health = health;

    teleportTo(gridP);
  }

  void teleportTo(Point gridP) 
  {
    Tile tile = level.getTile(gridP);
    if (tile != null) 
    {
      this.gridP = gridP.get();
      this.gridT = gridP.get();
      this.pixlP = tile.getCenter();
    }
  }

  void setTargetPosition(Point gridT) 
  {
    this.gridT = gridT.get();
    findPath = true;
  }

  void update() 
  {
    if (findPath == true && health > 0) findPathAndTakeNextStep();
    updateMove();
  }

  void findPathAndTakeNextStep() 
  {
    findPath = false;
    Tile start = level.getTile(gridP);
    Tile end = level.getTile(gridT);
    if (start == end) // When the enemy reaches the end point
    {
      baseHealth -= 1;
      reachedTarget = true;
      path = null;
      return;
    }
    path = pathfinder.findPath(start, end);

    if (path != null && path.size() > 1) 
    { 
      Tile tile = path.get(1);
      if (tile.isPassable()) gridP = new Point(tile.X, tile.Y);
    }
  }

  void updateMove() 
  {

    float snapThreshold = 1;
    PVector pixlT = level.getTileCenterAt(gridP);
    PVector diff = PVector.sub(pixlT, pixlP);

    pixlP.x += diff.x * .2;
    pixlP.y += diff.y * .2;

    if (abs(diff.x) < snapThreshold) pixlP.x = pixlT.x;
    if (abs(diff.y) < snapThreshold) pixlP.y = pixlT.y;

    if (pixlT.x == pixlP.x && pixlT.y == pixlP.y) findPath = true;

    PixlTx = pixlT.x;
    PixlTy = pixlT.y;
  }

  void draw() 
  {
    noStroke();
    fill(255, 0, 0);
    //ellipse(pixlP.x, pixlP.y, 28, 28);

    float dx = PixlTx - pixlP.x;
    float dy = PixlTy - pixlP.y;
    angle = atan2(dy, dx);

    pushMatrix();
    translate(pixlP.x, pixlP.y);
    rotate(angle);
    image(alien, -25, -30);
    popMatrix();

    fill(255);
    textSize(24);
    text(health, pixlP.x, pixlP.y - 30);

    //drawPath();
  }

  void drawPath() 
  {
    if (path != null && path.size() > 1) 
    {
      stroke(0);
      PVector prevP = pixlP.get();
      for (int i = 1; i < path.size (); i++) 
      {
        PVector currP = path.get(i).getCenter();
        line(prevP.x, prevP.y, currP.x, currP.y);
        prevP = currP;
      }
      noStroke();
      ellipse(prevP.x, prevP.y, 8, 8);
    }
  }
}
