void draw() {
  background(100);
  
  for (Boid boid: boids) {
    boid.update();
    boid.display();
  }
}
