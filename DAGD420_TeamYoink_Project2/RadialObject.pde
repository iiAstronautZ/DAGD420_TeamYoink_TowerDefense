class RadialObject
{
  PVector position;
  float radius, angle;
  boolean isDead;
  PImage img;
  PImage[] imgs;
  
  RadialObject()
  {
    
  }
  
  void update()
  {
    
  }
  
  void draw()
  {
    
  }
  
  boolean checkCollision(RadialObject other)
  {
    float dx = other.position.x - position.x;
    float dy = other.position.y - position.y;
    float dis = sqrt(dx * dx + dy * dy);
    return dis <= radius + other.radius;
  }
}
