class BloodParticle {
  float x, y;
  PVector velocity = new PVector();
  float size, alpha, angle;
  float rateOfDepletion;
  float r, g, b;
  boolean isDead = false;
  float friction = 0.9;

  BloodParticle(float xPos, float yPos) {
    x = xPos;
    y = yPos;
    size = random(5, 10);
    alpha = random(100, 200);
    angle = radians(random(360));
    r = random(155, 255);
    g = 0;
    b = 0;
    rateOfDepletion = random(10, 15);
    velocity.x = velocity.y = random(500, 1000);
  }

  void update() {
    x += velocity.x * cos(angle) * dt;
    y += velocity.y * sin(angle) * dt;

    velocity.x *= friction;
    velocity.y *= friction;

    alpha -= rateOfDepletion * dt;

    if (alpha <= 0) isDead = true;

    // bounderies
    if (x > 1200) x = 1200;
    if (x < 90) x = 90; 

    if (y > 650) y = 650;
    if (y < 80) y = 80;
  }

  void draw() {
    pushMatrix();
    noStroke();
    fill(r, g, b);
    translate(x, y);
    rotate(angle);
    rect(-size/2, -size/2, size, size);
    popMatrix();
  }
}
