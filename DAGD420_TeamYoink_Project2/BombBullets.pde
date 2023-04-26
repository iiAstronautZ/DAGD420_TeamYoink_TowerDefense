class BombBullet {
  float x, y;
  float speed = 300;
  float damage = 0;
  float angle;
  float lifeTime = 1;
  PVector target = new PVector();
  boolean isDead = false;

  float radius = 10;

  BombBullet(float xPos, float yPos, float range, float damage) {
    x = xPos;
    y = yPos;
    lifeTime = range;
    this.damage = damage;
  }

  void update() {
  }

  void draw() {
    float dx = target.x - x;
    float dy = target.y - y;
    angle = atan2(dy, dx);
    float dis = sqrt(dx * dx + dy * dy);

    lifeTime -= dt;

    if (lifeTime <= 0) {
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
    fill(155, 155, 155);
    ellipse(x, y, 10, 10);
    popMatrix();
  }
}

class Bomb {

  float x, y;
  float damage = 5;
  boolean isDead = false;

  float radius = 100;
  float alpha = 255;

  Bomb(float xPos, float yPos) {
    x = xPos;
    y = yPos;

    for (int i = 0; i < enemies.size(); i++) {
      if(checkCollisionBombEnemy(this, enemies.get(i))) {
        enemies.get(i).health -= damage;
      }
    }
  }

  void update() {
  }

  void draw() {

    alpha -= 255 * dt;
    if (alpha <= 0) isDead = true;

    noFill();
    stroke(255, alpha);
    strokeWeight(2);
    ellipse(x, y, radius*2, radius*2);
    noStroke();
  }

  boolean checkCollisionBombEnemy(Bomb b, Enemy e) {
    float dx = e.pixlP.x - b.x;
    float dy = e.pixlP.y - b.y;
    float dis = sqrt(dx * dx + dy * dy);
    if (dis <= b.radius + e.radius) return true;
    return false;
  }
}
