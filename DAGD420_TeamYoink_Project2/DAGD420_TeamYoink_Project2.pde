// create a variable to hold each scene:
SceneTitle sceneTitle;
ScenePlay scenePlay;
SceneGameOver sceneGameOver;

// keep any global state (variables that don't belong to a specific scene) here.
// the keyboard state is global, because every scene can use it:

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

boolean keyEnter = false;
boolean canPlaceTurret = false;

float dt;
float prevTime;

float funds = 5000;

float cost = 0;

int baseHealth = 5;

// Brandon BG Sound Delay
int BGMusicWaitP = 15; // Play
int BGMusicWaitR = 232; // Rewind

Minim minim;
AudioPlayer audioBG;
AudioPlayer audioBullet;
AudioPlayer audioAlienSpawn;
AudioPlayer audioAlienDeath;

static final int FADE = 250;


void setup() {
  size(1260, 900);
  
  minim = new Minim(this);
  audioBG = minim.loadFile("ArmyMen_BGMusic.mp3");
  audioBullet = minim.loadFile("Bullet.mp3");
  audioAlienSpawn = minim.loadFile("AlienSpawn.mp3");
  audioAlienDeath = minim.loadFile("AlienDeath.mp3");
  
  // Volume Control for Sounds
  audioBG.shiftGain(audioBG.getGain(),-15,FADE);
  audioBullet.shiftGain(audioBullet.getGain(),-15,FADE);
  audioAlienSpawn.shiftGain(audioAlienSpawn.getGain(),-15,FADE);
  audioAlienDeath.shiftGain(audioAlienDeath.getGain(),-15,FADE);
  
  
  
  TileHelper.app = this;
  switchToTitle();
}
void draw() {
  calcDeltaTime();
  
  BGMusicWaitP -= dt;
  if(BGMusicWaitP <= 0){
    audioBG.play();
    BGMusicWaitR -= dt;
    if(BGMusicWaitR <= 0){
      audioBG.rewind();
      BGMusicWaitR = 232;
    }
    BGMusicWaitP = 15;
  }
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

boolean isMouseOver(int x, int y, int w, int h) { // Button - put in Main class to be accessible from ANY CLASS 
  if (mouseX >= x && mouseX <= ( x + w ) && mouseY >= y && mouseY <= ( y + h) ) { //When mouse over button:
    pushMatrix(); //just so it doesnt change the colors of stuff outside of the push Matrix (dont need push & popMatrices)
    noStroke();
    fill(255);
    rect(x, y, w, h);
    popMatrix();
    return true;
  } else { //When mouse is NOT over button 
    pushMatrix();
    noStroke();
    fill(70);
    rect(x, y, w, h);
    popMatrix();
    return false;
  }
}
