PShape boidShape;
float shapeSize = 2.0;

void initializeBoidShape() {
  boidShape = createShape();
  boidShape.beginShape();
  boidShape.strokeWeight(1);
  boidShape.noFill();
  boidShape.stroke(0, 150);
  boidShape.vertex(-shapeSize, shapeSize * 2);
  boidShape.vertex(0, 0);
  boidShape.vertex(-shapeSize, -shapeSize * 2);
  boidShape.endShape(CLOSE);
}
