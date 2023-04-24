class TurretAOE {

  float x, y;

  float angle;

  boolean isDeleted;

  boolean isHover;

  boolean isSelected;

  boolean hasRangeUpgrade, hasDamageUpgrade, hasFireRateUpgrade;

  // Upgrades variables
  float fireRateCD;
  float fireRate = 1;
  float damage = 1;
  float range = 0.15;

  PImage soldier;
  PImage soldierTint;

  TurretAOE() {
    fireRateCD = fireRate;

    soldier = loadImage("soldier.png");
    soldier.resize(65, 65);
    soldierTint = loadImage("soldierTinted.png");
    soldierTint.resize(65, 65);
  }

  void update() {
  }

  void draw() {
    if (isSelected) {
      //fill(255, 255, 0);
      pushMatrix();
      translate(x, y);
      rotate(angle);
      image(soldierTint, -25, -30);
      popMatrix();
    } else { 
      //fill(0, 255, 0);
      pushMatrix();
      translate(x, y);
      rotate(angle);
      image(soldier, -25, -30);
      popMatrix();
    }

    //ellipse(x, y, 30, 30);

    if (hasRangeUpgrade) {
      fill(0, 255, 255);
      rect(x - 12, y - 20, 5, 5);
    }

    if (hasDamageUpgrade) { 
      fill(255, 0, 0);
      rect(x - 2, y - 20, 5, 5);
    }
    if (hasFireRateUpgrade) {
      fill(255, 255, 0);
      rect(x + 8, y - 20, 5, 5);
    }

    if (isHovering(x-15, y-15, 40, 40)) {
      isHover = true;
    } else {
      isHover = false;
    }

    fireRateCD -= dt;

    if (fireRateCD <= 0) {

      Bullet b = new Bullet(x, y, range, damage);

      for (int i = 0; i < enemies.size(); i++)
      {
        Enemy e = enemies.get(i);

        float dx = enemies.get(i).pixlP.x - x;
        float dy = enemies.get(i).pixlP.y - y;
        float dis = sqrt(dx * dx + dy * dy);

        if (dis < 350) {
          b.target = new PVector(e.pixlP.x, e.pixlP.y);
          angle = atan2(dy, dx);
          bullets.add(b);
        }
      }

      fireRateCD = fireRate;
    }
  }

  boolean isHovering(float x, float y, float width, float height) {
    if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
      //println("Turret Hovered");
      return true;
    } else {
      return false;
    }
  }
}
