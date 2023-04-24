// this class defines a "Game Over" scene

Button returnButton = new Button(530, 500, "RETURN", 24, 55, 110, 25);

class SceneGameOver {
  SceneGameOver() {
  }
  void update() {
  }
  void draw() {
    background(255, 0, 0);
    textAlign(LEFT, TOP);
    //text("Click to return to the main menu", 10, 20);
    textAlign(CENTER, CENTER);
    textSize(64);
    text("GAME OVER", width/2, height/2 - 100);

    for (int i = 0; i < enemies.size(); i++)
    {
      enemies.remove(i);
    }

    for (int i = 0; i < turrets.size(); i++) {
      turrets.remove(i);
    }
    
    returnButton.draw();
  }
  void mousePressed() {
    if(returnButton.rectOver) {
      switchToTitle();
    }
  }
}
