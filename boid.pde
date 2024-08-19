class Boid extends Flockable {
  public Boid(PVector position, PVector velocity) {
    this.acceleration = new PVector();
    this.position = position;
    this.velocity = velocity;
  }
  
  void display() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(velocity.heading());
    shape(boidShape);
    popMatrix();
  }
  
  void turn() {
    if (position.x < MARGIN) { velocity.x += TURN * (MARGIN - position.x); }
    if (position.y < MARGIN) { velocity.y += TURN * (MARGIN - position.y); }
    if (position.x > width - MARGIN) { velocity.x -= TURN * (position.x - width + MARGIN); }
    if (position.y > height - MARGIN) { velocity.y -= TURN * (position.y - height + MARGIN); }
  }  
  
  void update() {
    flock();
    
    turn();
    
    velocity.add(acceleration);
    velocity.limit(MAX_SPEED);

    if (velocity.mag() < 1) { velocity.setMag(1); }
    
    position.add(velocity);
  }
}
