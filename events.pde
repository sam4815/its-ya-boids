void mouseDragged() {
  boids.add(new Boid(new PVector(mouseX, mouseY), PVector.random2D()));
}

void mouseClicked() {
  boids.add(new Boid(new PVector(mouseX, mouseY), PVector.random2D()));
}
