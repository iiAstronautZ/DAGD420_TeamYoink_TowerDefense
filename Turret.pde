class Turret {
  
  float x, y;
  
  boolean isDeleted;
  
  // Upgrades variables
  float fireRate;
  float damage;
  float range;
  
  Turret() {
  }
  
  void update() {

  }

  void draw() {
    fill(0, 255, 0);
    ellipse(x, y, 30, 30);
  }
}
