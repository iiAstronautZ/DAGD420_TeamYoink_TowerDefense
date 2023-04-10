// create a variable to hold each scene:
SceneTitle sceneTitle;
ScenePlay scenePlay;
SceneGameOver sceneGameOver;

// keep any global state (variables that don't belong to a specific scene) here.
// the keyboard state is global, because every scene can use it:
boolean keyEnter = false;

void setup() {
  size(500, 500);
  switchToTitle();
}
void draw() {
  
  // update and draw any active scenes:
  
  if(sceneTitle != null){
    sceneTitle.update();
    if(sceneTitle != null) sceneTitle.draw(); // this extra if statement exists because the sceneTitle.update() might result in the scene switching...
  }
  else if(scenePlay != null){
    scenePlay.update();
    if(scenePlay != null) scenePlay.draw(); // this extra if statement exists because the scenePlay.update() might result in the scene switching...
  }
  else if(sceneGameOver != null){
    sceneGameOver.update();
    if(sceneGameOver != null) sceneGameOver.draw(); // this extra if statement exists because the sceneGameOver.update() might result in the scene switching...
  }
}
void mousePressed(){
  
  // tell any active scenes that the mouse was clicked:
  
  if(sceneTitle != null) sceneTitle.mousePressed();
  else if(scenePlay != null) scenePlay.mousePressed();
  else if(sceneGameOver != null) sceneGameOver.mousePressed();
}
void switchToTitle(){
  sceneTitle = new SceneTitle();
  scenePlay = null;
  sceneGameOver = null;
}
void switchToPlay(){
  scenePlay = new ScenePlay();
  sceneTitle = null;
  sceneGameOver = null;
}
void switchToGameOver(){
  sceneGameOver = new SceneGameOver();
  scenePlay = null;
  sceneTitle = null;
}
void keyPressed(){
  //println(keyCode);
  if(keyCode == 10) keyEnter = true;
}
void keyReleased(){
  if(keyCode == 10) keyEnter = false;
}
