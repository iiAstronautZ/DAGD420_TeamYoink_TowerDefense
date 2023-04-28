class Bullet {
  float x, y;
  float speed = 1000;
  float damage = 1;
  float angle;
  float range = 0.1;
  PVector target = new PVector();
  boolean isDead = false;

  float radius = 20;

  Bullet(float xPos, float yPos, float range, float damage) {
    x = xPos;
    y = yPos;
    this.range = range;
    this.damage = damage;
  }

  void update() {
  }

  void draw() {
    float dx = target.x - x;
    float dy = target.y - y;
    angle = atan2(dy, dx);
    float dis = sqrt(dx * dx + dy * dy);
    
    range -= dt;
    
    if (range <= 0) {
      isDead = true;
    }
    
    if (dis > 5) {
      x +=  speed * cos(angle) * dt; // x = x + dx * friction;
      y +=  speed * sin(angle) * dt;
    } else {
      isDead = true;
    } // If we reach the target


    pushMatrix();
    noStroke();
    fill(255, 255, 255);
    ellipse(x, y, 10, 10);
    popMatrix();
  }
}
