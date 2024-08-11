PShape boidShape;
float shapeSize = 1;

void initializeBoidShape() {
  boidShape = createShape();
  boidShape.beginShape();
  boidShape.strokeWeight(1);
  boidShape.noFill();
  boidShape.stroke(255);
  boidShape.vertex(shapeSize * 4, 0);
  boidShape.vertex(-shapeSize, shapeSize * 2);
  boidShape.vertex(0, 0);
  boidShape.vertex(-shapeSize, -shapeSize * 2);
  boidShape.endShape(CLOSE);
}
