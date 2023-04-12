class Enemy extends RadialObject
{
  Enemy(float x, float y)
  {
    this.position.x = x;
    this.position.y = y;
  }
  
  void update()
  {
    
  }
  
  void draw()
  {
    fill(255, 0, 0);
    ellipse(position.x, position.y, radius*2, radius*2);
  }
}
