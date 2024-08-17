PGraphics background;
int bgWidth, bgHeight;

void drawBackground() {
  if (bgWidth == width && bgHeight == height) { return; }

  background = createGraphics(width, height);
  background.beginDraw();
  background.background(100);
  color from = color(#2E4057);
  color to = color(#DBCBD8);
  
  for (float x = 0; x < width; x += 1) {
    color interA = lerpColor(from, to, x/width);
    background.stroke(interA);
    background.fill(interA);
    background.rect(x, 0, 1, height);
  }
  
  background.endDraw();
  
  bgWidth = width;
  bgHeight = height;
}
