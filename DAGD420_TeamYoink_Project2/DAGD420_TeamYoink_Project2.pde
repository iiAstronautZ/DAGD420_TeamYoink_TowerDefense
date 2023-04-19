// create a variable to hold each scene:
SceneTitle sceneTitle;
ScenePlay scenePlay;
SceneGameOver sceneGameOver;

// keep any global state (variables that don't belong to a specific scene) here.
// the keyboard state is global, because every scene can use it:
boolean keyEnter = false;
boolean canPlaceTurret = false;

float dt;
float prevTime;

void setup() {
  size(720, 720);
  TileHelper.app = this;
  switchToTitle();
}
void draw() {
  calcDeltaTime();

  // update and draw any active scenes:

  if (sceneTitle != null) {
    sceneTitle.update();
    if (sceneTitle != null) sceneTitle.draw(); // this extra if statement exists because the sceneTitle.update() might result in the scene switching...
  } else if (scenePlay != null) {
    scenePlay.update();
    if (scenePlay != null) scenePlay.draw(); // this extra if statement exists because the scenePlay.update() might result in the scene switching...
  } else if (sceneGameOver != null) {
    sceneGameOver.update();
    if (sceneGameOver != null) sceneGameOver.draw(); // this extra if statement exists because the sceneGameOver.update() might result in the scene switching...
  }
}
void mousePressed() {

  // tell any active scenes that the mouse was clicked:

  if (sceneTitle != null) sceneTitle.mousePressed();
  else if (scenePlay != null) scenePlay.mousePressed();
  else if (sceneGameOver != null) sceneGameOver.mousePressed();
}
void switchToTitle() {
  sceneTitle = new SceneTitle();
  scenePlay = null;
  sceneGameOver = null;
}
void switchToPlay() {
  scenePlay = new ScenePlay();
  sceneTitle = null;
  sceneGameOver = null;
}
void switchToGameOver() {
  sceneGameOver = new SceneGameOver();
  scenePlay = null;
  sceneTitle = null;
}
void keyPressed() {
  //println(keyCode);
  if (keyCode == 10) keyEnter = true;


  if (keyCode == 49) level.loadLevel(LevelDefs.LEVEL1);
  if (keyCode == 50) level.loadLevel(LevelDefs.LEVEL2);
  if (keyCode == 51) level.loadLevel(LevelDefs.LEVEL3);
  if (keyCode == 52) level.loadLevel(LevelDefs.LEVEL4);
  if (keyCode == 53) level.loadLevel(LevelDefs.LEVEL5);

  if (keyCode == 68) {
    level.toggleDiagonals();
    level.reloadLevel();
  }
  if (keyCode == 71) {
    TileHelper.isHex = !TileHelper.isHex;
    level.reloadLevel();
  }
  if (keyCode == 72) pathfinder.toggleHeuristic();
  if (keyCode == 222) debug = !debug;
}

void keyReleased() {
  if (keyCode == 10) keyEnter = false;
}

void calcDeltaTime()
{
  float currTime = millis()/1000.0;
  dt = currTime - prevTime;
  prevTime = currTime;
}
