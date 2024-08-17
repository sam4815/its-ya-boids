void draw() {
  drawBackground();
  image(background, 0, 0);

  for (Boid boid: boids) {
    boid.update();
    boid.display();
  }
}
