// this class defines a "Title" scene

Button startButton = new Button(530, 500, "PLAY", 24, 55, 110, 25);

class SceneTitle {
  SceneTitle() {
    
  }
  void update() {
    if (keyEnter) {
      switchToPlay();
    }
  }
  void draw() {
    background(0);
    fill(255);
    textSize(64);
    textAlign(CENTER, CENTER);
    text("ARMY MEN VS ALIENS", width/2, height/2 - 60);
    //textSize(12);
    //text("Press ENTER to play!", width/2, height/2);
    
    startButton.draw();
  }
  void mousePressed() {
    if(mouseButton == LEFT) {
      if(startButton.rectOver) {
        switchToPlay();
      }
    }
  }
}
