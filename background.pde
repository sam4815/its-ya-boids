PGraphics background;
int bgWidth, bgHeight;

void drawBackground() {
  if (bgWidth == width && bgHeight == height) { return; }

  background = createGraphics(width, height);
  background.beginDraw();
  background.background(100);
  color from = color(#96a2ba);
  color mid = color(#ac9396);
  color to = color(#907d8f);
  
  for (float y = 0; y < height/2; y += 1) {
    color interA = lerpColor(from, mid, y/(height/2));
    background.stroke(interA);
    background.fill(interA);
    background.rect(0, y, width, 1);
  }
  
  for (float y = height/2; y < height; y += 1) {
    color interB = lerpColor(mid, to, (y-height/2)/height/2);
    println(interB);
    background.stroke(interB);
    background.fill(interB);
    background.rect(0, y, width, 1);
  }
  
  background.endDraw();
  
  bgWidth = width;
  bgHeight = height;
}
