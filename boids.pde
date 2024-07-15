float separation;
float alignment;
float cohesion;

int numBoids;
int radius;

float maxSpeed;
float maxForce;

PShape boidShape;

Boid[] boids;

void setup() {
  fullScreen();
  frameRate(60);
  numBoids = 500;
  radius = 100;
  separation = 0.3;
  alignment = 0.4;
  cohesion = 0.2;
  maxSpeed = 5;
  maxForce = 0.1;
  
  boids = new Boid[numBoids];
  
  for (int i = 0; i < numBoids; i++) {
    boids[i] = new Boid(
      new PVector(random(0, width), random(0, height)),
      PVector.random2D()
    );
  }
  
  float shapeSize = 1;
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
