ArrayList<Boid> boids;

void setup() {
  size(500, 500);
  surface.setResizable(true);
  
  initializeBoidShape();
  
  boids = new ArrayList<Boid>();
  
  for (int i = 0; i < NUM_BOIDS_INIT; i++) {
    boids.add(new Boid(
      new PVector(random(0, width), random(0, height)),
      PVector.random2D()
    ));
  }
}
