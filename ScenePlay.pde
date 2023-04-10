// this class defines a "Play" scene
class ScenePlay {
  PVector targetPosition = new PVector();
  ScenePlay(){
    textAlign(LEFT, TOP);
  }
  void update(){
    float time = millis()/1000.0;
    targetPosition.x =  width/2 + 100 * cos(time);
    targetPosition.y = height/2 + 100 * sin(time);
  }
  void draw(){
    background(128);
    ellipse(targetPosition.x, targetPosition.y, 10, 10);
    text("click to lose", 10, 20);
  }
  void mousePressed(){
    switchToGameOver();
  }
}