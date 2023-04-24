class Button {

  float rectX, rectY;
  float rectSize = 90;
  color rectColor, baseColor;
  color rectHighlight;
  color currentColor;
  boolean rectOver = false;
  String name;
  int textSize;
  int xOffset, yOffset;

  Button(float rectX, int rectY, String name, int textSize, int rectSize, int xOffset, int yOffset) {
    rectColor = color(#068100);
    rectHighlight = color(#89FF9D);
    baseColor = color(255);
    currentColor = baseColor;

    this.rectX = rectX;
    this.rectY = rectY;
    this.name = name;
    this.textSize = textSize;
    this.rectSize = rectSize;
    this.xOffset = xOffset;
    this.yOffset = yOffset;
  }

  void draw() {

    if (overRect(rectX, rectY, rectSize + rectSize * 3, rectSize) ) {
      rectOver = true;
    } else rectOver = false;
    
    if (rectOver) {
      fill(#89FF9D);
    } else {
      fill(#068100);
    }
 
    stroke(255);
    rect(rectX, rectY, rectSize + rectSize * 3, rectSize);

    fill(255);
    textSize(textSize);
    text(name, rectX + xOffset, rectY + yOffset);

  }

  boolean overRect(float x, float y, float width, float height) {
    if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
}
