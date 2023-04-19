// this class defines a "Game Over" scene
class SceneGameOver {
  SceneGameOver(){
    
  }
  void update(){
    
  }
  void draw(){
    background(255, 0, 0);
    textAlign(LEFT, TOP);
    text("Click to return to the main menu", 10, 20);
    textAlign(CENTER, CENTER);
    text("GAME OVER", width/2, height/2);
  }
  void mousePressed(){
    switchToTitle();
  }
}