// this class defines a "Play" scene

ArrayList<Turret> turrets = new ArrayList<Turret>();
ArrayList<FreezeTurret> freezeTurret = new ArrayList<FreezeTurret>();
ArrayList<TurretAOE> turretAOE = new ArrayList<TurretAOE>();
ArrayList<TurretSlow> turretSlow = new ArrayList<TurretSlow>();
ArrayList<Enemy> enemies = new ArrayList();
ArrayList<Frost> frost = new ArrayList<Frost>(); 
ArrayList<Bullet> bullets = new ArrayList<Bullet>(); 
ArrayList<SlowBullet> slowbullets = new ArrayList<SlowBullet>(); 
ArrayList<BombBullet> bombbullets = new ArrayList<BombBullet>(); 

//Upgrade buttons
Button damageButton = new Button(1025, 575, "Damage Upgrade", 24, 55, 110, 25);
Button rangeButton = new Button(1025, 675, "Range Upgrade", 24, 55, 110, 25);
Button fireRateButton = new Button(1025, 775, "Fire Rate Upgrade", 24, 55, 110, 25);

//Turret Buttons
Button turret1Button = new Button(1025, 550, "Normal Turret", 24, 55, 110, 25);
Button turret2Button = new Button(1025, 600, "Bomb Turret", 24, 55, 110, 25);
Button turret3Button = new Button(1025, 650, "Slowing Turret", 24, 55, 110, 25);
Button turret4Button = new Button(1025, 700, "Freeze Turret", 24, 55, 110, 25);

boolean debug = false;
boolean doOnce = false;

Level level;
Player player;
Pathfinder pathfinder;
Enemy enemy;
PImage img;
PImage damageIcon;
PImage rangeIcon;
PImage fireRateIcon;
PImage logo;

float enemyTimer = 5;

float rangeUpgradeCost, damageUpgradeCost, fireRateUpgradeCost;

int wave = 1;

int enemiesKilled = 0;

//Khelben
Boolean towerSelected = false;
int turretNumber;
int tower1Cost = 100;
int tower2Cost = 200;
int tower3Cost = 150;
int tower4Cost = 175;

// Brandon
int freezeTime = 5;
int setFrozen;

class ScenePlay 
{
  //ArrayList<Enemy> enemies = new ArrayList();

  ScenePlay() 
  {
    level = new Level();
    player = new Player();
    pathfinder = new Pathfinder();
    img = loadImage("ArmyBase_TD_grid.png");
    damageIcon = loadImage("damage.png");
    damageIcon.resize(65, 65);
    rangeIcon = loadImage("range.png");
    rangeIcon.resize(65, 65);
    fireRateIcon = loadImage("fireRate.png");
    fireRateIcon.resize(65, 65);

    logo = loadImage("logo.png");
    logo.resize(250, 250);

    rangeUpgradeCost = 50;
    damageUpgradeCost = 150; 
    fireRateUpgradeCost = 250;

    wave = 1;

    enemiesKilled = 0;

    baseHealth = 5;

    funds = 500;
    
    //Brandon
    setFrozen = millis();

    colorMode(RGB);

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

    if (baseHealth <= 0) switchToGameOver();

    if (enemiesKilled >= 10) wave = 2;
    if (enemiesKilled >= 30) wave = 3;
    if (enemiesKilled >= 50) wave = 4;
    if (enemiesKilled >= 70) wave = 5;
    if (enemiesKilled >= 100) wave = 6;
    if (enemiesKilled >= 150) wave = 7;
    if (enemiesKilled >= 200) wave = 8;
    if (enemiesKilled >= 250) wave = 9;
    if (enemiesKilled >= 300) wave = 10;
    if (enemiesKilled >= 350) wave = 999;

    if (wave == 1) {
      enemyTimer -= dt;
      if (enemyTimer <= 0)
      {
        Enemy e = new Enemy(1);
        enemies.add(e);
        enemyTimer = random(3, 5);
        moveToTarget();
        println(enemies.size());
      }
    } else if (wave == 2) {
      enemyTimer -= dt;
      if (enemyTimer <= 0)
      {
        Enemy e = new Enemy(2);
        enemies.add(e);
        enemyTimer = random(2, 4);
        moveToTarget();
        println(enemies.size());
      }
    } else if (wave == 3) {
      enemyTimer -= dt;
      if (enemyTimer <= 0)
      {
        Enemy e = new Enemy(3);
        enemies.add(e);
        enemyTimer = 2;
        moveToTarget();
        println(enemies.size());
      }
    } else if (wave == 4) {
      enemyTimer -= dt;
      if (enemyTimer <= 0)
      {
        Enemy e = new Enemy(4);
        enemies.add(e);
        enemyTimer = 1.5;
        moveToTarget();
        println(enemies.size());
      }
    } else if (wave == 5) {
      enemyTimer -= dt;
      if (enemyTimer <= 0)
      {
        Enemy e = new Enemy(5);
        enemies.add(e);
        enemyTimer = 1.0;
        moveToTarget();
        println(enemies.size());
      }
    } else if (wave == 6) {
      enemyTimer -= dt;
      if (enemyTimer <= 0)
      {
        Enemy e = new Enemy(6);
        enemies.add(e);
        enemyTimer = 0.5;
        moveToTarget();
        println(enemies.size());
      }
    } else if (wave >= 7) {
      enemyTimer -= dt;
      if (enemyTimer <= 0)
      {
        Enemy e = new Enemy(7);
        enemies.add(e);
        enemyTimer = 0.25;
        moveToTarget();
        println(enemies.size());
      }
    } else if (wave >= 8) {
      enemyTimer -= dt;
      if (enemyTimer <= 0)
      {
        Enemy e = new Enemy(8);
        enemies.add(e);
        enemyTimer = 0.15;
        moveToTarget();
        println(enemies.size());
      }
    } else if (wave >= 9) {
      enemyTimer -= dt;
      if (enemyTimer <= 0)
      {
        Enemy e = new Enemy(9);
        enemies.add(e);
        enemyTimer = 0.05;
        moveToTarget();
        println(enemies.size());
      }
    } else if (wave >= 10) {
      enemyTimer -= dt;
      if (enemyTimer <= 0)
      {
        Enemy e = new Enemy(10);
        enemies.add(e);
        enemyTimer = 0;
        moveToTarget();
        println(enemies.size());
      }
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
    
    for (int i = 0; i < freezeTurret.size(); i++) {
      FreezeTurret f = freezeTurret.get(i);
      f.draw();
    } 

    for (int i = 0; i < turretAOE.size(); i++) {
      TurretAOE a = turretAOE.get(i);
      a.draw();
    } 
    for (int i = 0; i < turretSlow.size(); i++) {
      TurretSlow s = turretSlow.get(i);
      s.draw();
    } 

    //enemy.draw();

    // ADDING ENEMIES TO ARRAY?
    // Normal Bullet
    for (int i = 0; i < bullets.size(); i++) {
      Bullet b = bullets.get(i);
      if (b.isDead) bullets.remove(b);
      audioBullet.play();
      audioBullet.rewind();
      b.draw();
    }
    // Slow Bullets
    for (int i = 0; i < slowbullets.size(); i++) {
      SlowBullet sb = slowbullets.get(i);
      if (sb.isDead) slowbullets.remove(sb);
      audioBullet.play();
      audioBullet.rewind();
      sb.draw();
    }
    // Bomb Bullets
    for (int i = 0; i < bombbullets.size(); i++) {
      BombBullet bb = bombbullets.get(i);
      if (bb.isDead) bombbullets.remove(bb);
      audioBullet.play();
      audioBullet.rewind();
      bb.draw();
    }
    // Frost Bullet
    for (int i = 0; i < frost.size(); i++) {
      Frost f = frost.get(i);
      if (f.isDead) frost.remove(f);
      audioBullet.play();
      audioBullet.rewind();
      f.draw();
    }

    for (int i = 0; i < enemies.size(); i++)
    {
      Enemy e = enemies.get(i);
      if (enemies.get(i).reachedTarget) enemies.remove(e);

      for (int j = 0; j < bullets.size(); j++) { // Bullet collision with Enemy
        if (checkCollisionBulletEnemy(bullets.get(j), e)) {

          e.health -= bullets.get(j).damage;

          bullets.remove(j);

          if (e.health <= 0) { 
            enemies.remove(e);
            enemiesKilled += 1;
            println("ENEMIES DED");
            funds += 25;
            audioAlienDeath.play();
            audioAlienDeath.rewind();
          }
        }
      }
      for (int sb = 0; sb < slowbullets.size(); sb++) { // Bullet collision with Enemy
        if (checkCollisionBulletEnemy(slowbullets.get(sb), e)) {

          //e.health -= slowbullets.get(sb).damage;
          e.snapThreshold = 0.1;
          slowbullets.remove(sb);

          if (e.health <= 0) { 
            enemies.remove(e);
            enemiesKilled += 1;
            println("ENEMIES DED");
            funds += 25;
            audioAlienDeath.play();
            audioAlienDeath.rewind();
          }
        }
      }
      for (int bb = 0; bb < bombbullets.size(); bb++) { // Bullet collision with Enemy
        if (checkCollisionBulletEnemy(bombbullets.get(bb), e)) {

          e.health -= bombbullets.get(bb).damage;

          bombbullets.remove(bb);

          if (e.health <= 0) { 
            enemies.remove(e);
            enemiesKilled += 1;
            println("ENEMIES DED");
            funds += 25;
            audioAlienDeath.play();
            audioAlienDeath.rewind();
          }
        }
      }
      for (int f = 0; f < frost.size(); f++) { // Bullet collision with Enemy
        if (checkCollisionFrostEnemy(frost.get(f), e)) {

          //e.health -= frost.get(f).damage;
          e.snapThreshold = 0;
          if(e.snapThreshold == 0){
             freezeTime -= dt;
             if(freezeTime <= 0){
               e.snapThreshold = 1;
               freezeTime = 5;
             }
          }

          frost.remove(f);

          if (e.health <= 0) { 
            enemies.remove(e);
            enemiesKilled += 1;
            println("ENEMIES DED");
            funds += 25;
            audioAlienDeath.play();
            audioAlienDeath.rewind();
          }
        }
      }

      e.draw();
    }

    // TODO: using mouse position, get tile. set it's hover property to true
    Point g = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));
    Tile tile = level.getTile(g);
    tile.hover = true;
    // TODO: draw a little ellipse in the tile's center
    PVector m = tile.getCenter();
    //fill(0);
    //ellipse(m.x, m.y, 8, 8);


    // DRAW DEBUG INFO:
    //fill(255, 255, 0);
    //String s1 = (pathfinder.useManhattan) ? "(h) heuristic: manhattan" : "(h) heuristic: euclidian";
    //String s2 = (level.useDiagonals) ? "(d) diagonals: yes" : "(d) diagonals: no";
    //String s3 = (TileHelper.isHex) ? "(g) grid: hex" : "(g) grid: square";
    //String s4 = (debug) ? "(`) debug: on" : "(`) debug: off";
    //text(s1, 10, 15);
    //text(s2, 10, 30);
    //text(s3, 10, 45);
    //text(s4, 10, 60);

    //println(enemies.size());

    fill(255);
    textSize(32);

    text("Base Health: " + baseHealth, 1075, 350);
    text("Wave: " + wave, 1075, 380);
    text("Kills:" + enemiesKilled, 1075, 410);

    text("Funds: $" + funds + "0", 1075, 475);

    text("Cost: $" + cost + "0", 1075, 525);

    image(logo, 950, 50);
    //Khelben
    if(towerSelected){
      image(damageIcon, 925, 565);
      damageButton.draw();
      image(rangeIcon, 925, 665);
      rangeButton.draw();
      image(fireRateIcon, 925, 765);
      fireRateButton.draw();
    } else{
    }
    //Khelben
    if(!towerSelected){
    fill(#7F7F7F);
    rect(900, 550, 400, 300);
    image(damageIcon, 925, 565);
    turret1Button.draw();
    image(rangeIcon, 925, 665);
    turret2Button.draw();
    image(fireRateIcon, 925, 765);
    turret3Button.draw();
    turret4Button.draw();
    //image(fireRateIcon, 925, 765);
    //turret3Button.draw();
    }

    if (damageButton.rectOver && !doOnce) {
      for (int i = 0; i < turrets.size(); i++) {
        if (turrets.get(i).isSelected && !turrets.get(i).hasDamageUpgrade) {
          cost += damageUpgradeCost;
        }
      }
      doOnce = true;
    } else if (rangeButton.rectOver && !doOnce) {
      for (int i = 0; i < turrets.size(); i++) {
        if (turrets.get(i).isSelected && !turrets.get(i).hasRangeUpgrade) {
          cost += rangeUpgradeCost;
        }
      }
      doOnce = true;
    } else if (fireRateButton.rectOver && !doOnce) {
      for (int i = 0; i < turrets.size(); i++) {
        if (turrets.get(i).isSelected && !turrets.get(i).hasFireRateUpgrade) {
          cost += fireRateUpgradeCost;
        }
      }
      doOnce = true;
    } else if (turret1Button.rectOver && !doOnce) {
      for (int i = 0; i < turrets.size(); i++) {
        cost += tower1Cost;
      }
      doOnce = true;
    } else if (turret2Button.rectOver && !doOnce) {
      for (int i = 0; i < turrets.size(); i++) {
        cost += tower2Cost;
      }
      doOnce = true;
    } else if (turret3Button.rectOver && !doOnce) {
      for (int i = 0; i < turrets.size(); i++) {
        cost += tower3Cost;
      }
      doOnce = true;
    } else if (turret4Button.rectOver && !doOnce) {
      for (int i = 0; i < turrets.size(); i++) {
        cost += tower4Cost;
      }
      doOnce = true;
    } else if (!fireRateButton.rectOver && !rangeButton.rectOver && !damageButton.rectOver) {
      doOnce = false;
      cost = 0;
    }
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
    TurretAOE a = new TurretAOE();
    TurretSlow s = new TurretSlow();
    FreezeTurret f = new FreezeTurret();

    if (mouseButton == LEFT) { 
        towerSelected = false;
      if (canPlaceTurret) {
        if (!tile.hasTurret && turretNumber == 1) { // Normal Turret
          if (funds >= tower1Cost) {
            funds -= tower1Cost;
            turrets.add(t);
            t.x = pos.x;
            t.y = pos.y;
            tile.hasTurret = true;
            turretNumber = 0;
          } else println("NOT ENOUGH MONEY");
        } else if (!tile.hasTurret && turretNumber == 2) { // AOE Turret
          if (funds >= tower2Cost) {
            funds -= tower2Cost;
            turretAOE.add(a);
            a.x = pos.x;
            a.y = pos.y;
            tile.hasTurret = true;
            turretNumber = 0;
          } else println("NOT ENOUGH MONEY");
        } else if (!tile.hasTurret && turretNumber == 3) { // Slow Turret
          if (funds >= tower3Cost) {
            funds -= tower3Cost;
            turretSlow.add(s);
            s.x = pos.x;
            s.y = pos.y;
            tile.hasTurret = true;
            turretNumber = 0;
          } else println("NOT ENOUGH MONEY");
        } else if (!tile.hasTurret && turretNumber == 4) { // Freeze Turret
          if (funds >= tower4Cost) {
            funds -= tower4Cost;
            freezeTurret.add(f);
            f.x = pos.x;
            f.y = pos.y;
            tile.hasTurret = true;
            turretNumber = 0;
          } else println("NOT ENOUGH MONEY");
        } else { 
          //println("A turret is already on this tile!!!");
          for (int i = 0; i < turrets.size(); i++) {
            //Khelben
            turrets.get(i).isSelected = false;
            //towerSelected = false;
            if (!turrets.get(i).isSelected) {
              if (turrets.get(i).isHover) { 
                turrets.get(i).isSelected = true;
                //Khelben
                towerSelected = true;
                println("A turret is selected");
              }
            } else {
              if (turrets.get(i).isHover) {
                turrets.get(i).isSelected = false;
                //Khelben
                towerSelected = false;
              }
            }
          }
        }
      } else if (fireRateButton.rectOver) {
        for (int i = 0; i < turrets.size(); i++) {
          if (turrets.get(i).isSelected && !turrets.get(i).hasFireRateUpgrade) { 
            if (funds >= fireRateUpgradeCost) {
              funds -= fireRateUpgradeCost;
              turrets.get(i).hasFireRateUpgrade = true;
              turrets.get(i).fireRate = 0.5;
              //turrets.get(i).isSelected = false;
              cost = 0;
            }
          }
        }
      } else if (rangeButton.rectOver) {
        for (int i = 0; i < turrets.size(); i++) {
          if (turrets.get(i).isSelected && !turrets.get(i).hasRangeUpgrade) { 
            if (funds >= rangeUpgradeCost) {
              funds -= rangeUpgradeCost;
              turrets.get(i).hasRangeUpgrade = true;
              turrets.get(i).range = 1.0;
              //turrets.get(i).isSelected = false;
              cost = 0;
            }
          }
        }
      } else if (damageButton.rectOver) {
        for (int i = 0; i < turrets.size(); i++) {
          if (funds >= damageUpgradeCost) {
            if (turrets.get(i).isSelected && !turrets.get(i).hasDamageUpgrade) { 
              funds -= damageUpgradeCost;
              turrets.get(i).hasDamageUpgrade = true;
              turrets.get(i).damage = 5.0;
              //turrets.get(i).isSelected = false;
              cost = 0;
            }
          }
        }
      } else if (turret1Button.rectOver) {
        turretNumber = 1;
        cost = tower1Cost;
      } else if (turret2Button.rectOver) {
        turretNumber = 2;
        cost = tower2Cost;
      } else if (turret3Button.rectOver) {
        turretNumber = 3;
        cost = tower3Cost;
      } else if (turret4Button.rectOver) {
        turretNumber = 4;
        cost = tower4Cost;
      }
      // When nothing is selected
      else {
        for (int i = 0; i < turrets.size(); i++) {
          if (!turrets.get(i).isHover) {
            turrets.get(i).isSelected = false;
            cost = 0;
          }
        }
      }
    } else if (mouseButton == RIGHT) {
      if (tile.hasTurret) {

        for (int i = 0; i < turrets.size(); i++) { // Normal Turret
          if (turrets.get(i).isHover) { 
            funds += 25;
            turrets.remove(i);
          }
        }
        for (int i = 0; i < turretAOE.size(); i++) { // AOE Turret
          if (turretAOE.get(i).isHover) { 
            funds += 100;
            turretAOE.remove(i);
          }
        }
        for (int i = 0; i < turretSlow.size(); i++) { // Slow Turret
          if (turretSlow.get(i).isHover) { 
            funds += 75;
            turretSlow.remove(i);
          }
        }
        for (int i = 0; i < freezeTurret.size(); i++) { // Freeze Turret
          if (freezeTurret.get(i).isHover) { 
            funds += 75;
            freezeTurret.remove(i);
          }
        }
        tile.hasTurret = false;
      }
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

boolean checkCollisionBulletEnemy(Bullet b, Enemy e) {
  float dx = e.pixlP.x - b.x;
  float dy = e.pixlP.y - b.y;
  float dis = sqrt(dx * dx + dy * dy);
  if (dis <= b.radius + e.radius) return true;
  return false;
}
boolean checkCollisionBulletEnemy(BombBullet bb, Enemy e) {
  float dx = e.pixlP.x - bb.x;
  float dy = e.pixlP.y - bb.y;
  float dis = sqrt(dx * dx + dy * dy);
  if (dis <= bb.radius + e.radius) return true;
  return false;
}
boolean checkCollisionBulletEnemy(SlowBullet sb, Enemy e) {
  float dx = e.pixlP.x - sb.x;
  float dy = e.pixlP.y - sb.y;
  float dis = sqrt(dx * dx + dy * dy);
  if (dis <= sb.radius + e.radius) return true;
  return false;
}
boolean checkCollisionFrostEnemy(Frost f, Enemy e) {
  float dx = e.pixlP.x - f.x;
  float dy = e.pixlP.y - f.y;
  float dis = sqrt(dx * dx + dy * dy);
  if (dis <=  f.radius + e.radius) return true;
  return false;
}
