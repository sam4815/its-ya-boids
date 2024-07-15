@FunctionalInterface
interface BoidOperation {
    void execute(PVector target, Boid otherBoid, float distance);
}

class Boid {
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  public Boid(PVector position, PVector velocity) {
    this.acceleration = new PVector();
    this.position = position;
    this.velocity = velocity;
  }
  
  void drawBoid(float x, float y, float direction) {
    pushMatrix();
    translate(x, y);
    rotate(direction);
    shape(boidShape);
    popMatrix();
  }
  
  void display() {
    drawBoid(position.x, position.y, velocity.heading());
    
    // When wrapping, draw on both sides of the display
    if (position.x < 10) {
      drawBoid(position.x + width, position.y, velocity.heading());
    }
    if (position.y < 10) {
      drawBoid(position.x, position.y + height, velocity.heading());
    }
    if (position.x > width - 10) {
      drawBoid(position.x - width, position.y, velocity.heading());
    }
    if (position.y > height - 10) {
      drawBoid(position.x, position.y - height, velocity.heading());
    }
  }
  
  void wrap() {
    if (position.x < 0) { position.x = width; }
    if (position.y < 0) { position.y = height; }
    if (position.x > width) { position.x = 0; }
    if (position.y > height) { position.y = 0; }
  }
  
  void applyForce(PVector target, float coefficient) {
    target.setMag(maxSpeed);
    
    PVector force = PVector.sub(target, velocity);
    force.limit(maxForce);
    force.mult(coefficient);

    acceleration.add(force);
  }
  
  PVector findTarget(BoidOperation boidOperation) {
    PVector target = new PVector();
    int total = 0;
    
    for (Boid otherBoid: boids) {
      float distance = dist(position.x, position.y, otherBoid.position.x, otherBoid.position.y);
      if (otherBoid == this || distance > radius) {
        continue;
      }
      
      boidOperation.execute(target, otherBoid, distance);
      total += 1;
    }
    
    if (total == 0) {
      return position;
    }
    
    target.div(total);
    return target;
  }
  
  void separate() {
    PVector target = findTarget((t, neighbour, distance) -> {
      PVector difference = PVector.sub(position, neighbour.position);
      t.add(difference.div(distance * distance));
    });
    
    applyForce(target, separation);    
  }
  
  void cohere() {
    PVector centre = findTarget((t, neighbour, distance) -> {
      t.add(neighbour.position);
    });
    
    PVector target = PVector.sub(centre, position);
    applyForce(target, cohesion);    
  }
  
  void align() {
    PVector target = findTarget((t, neighbour, distance) -> {
      t.add(neighbour.velocity);
    });
    
    applyForce(target, alignment);    
  }
      
  
  void update() {
    wrap();
    
    separate();
    cohere();
    align();
    
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    
    position.add(velocity);
  }
}
