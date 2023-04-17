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

  Enemy() 
  {
    int spawn = (int)random(0, 12);
    if(spawn == 0) gridP = new Point(1, 0);
    if(spawn == 1) gridP = new Point(10, 0);
    if(spawn == 2) gridP = new Point(19, 0);
    if(spawn == 3) gridP = new Point(19, 4);
    if(spawn == 4) gridP = new Point(19, 9);
    if(spawn == 5) gridP = new Point(19, 19);
    if(spawn == 6) gridP = new Point(19, 19);
    if(spawn == 7) gridP = new Point(15, 19);
    if(spawn == 8) gridP = new Point(11, 19);
    if(spawn == 9) gridP = new Point(7, 19);
    if(spawn == 10) gridP = new Point(3, 19);
    if(spawn == 11) gridP = new Point(19, 0);
    if(spawn == 12) gridP = new Point(6, 0);
    
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
    if (findPath == true) findPathAndTakeNextStep();
    updateMove();
  }
  
  void findPathAndTakeNextStep() 
  {
    findPath = false;
    Tile start = level.getTile(gridP);
    Tile end = level.getTile(gridT);
    if (start == end) 
    {
      path = null;
      return;
    }
    path = pathfinder.findPath(start, end);

    if (path != null && path.size() > 1) 
    { 
      Tile tile = path.get(1);
      if(tile.isPassable()) gridP = new Point(tile.X, tile.Y);
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
  }
  
  void draw() 
  {
    noStroke();
    fill(255, 0, 0);
    ellipse(pixlP.x, pixlP.y, 28, 28);
    drawPath();
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
