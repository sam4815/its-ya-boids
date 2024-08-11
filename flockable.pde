float separation = 0.2;
float alignment = 0.3;
float cohesion = 0.1;

@FunctionalInterface
interface BoidOperation {
    void execute(PVector target, Boid otherBoid, float distance);
}

class Flockable {
  PVector position = new PVector();
  PVector velocity = new PVector();
  PVector acceleration = new PVector();
  
  PVector findTarget(BoidOperation boidOperation) {
    PVector target = new PVector();
    int total = 0;
    
    for (Boid otherBoid: boids) {
      float distance = dist(position.x, position.y, otherBoid.position.x, otherBoid.position.y);
      if (otherBoid == this || distance > RADIUS) {
        continue;
      }
      
      boidOperation.execute(target, otherBoid, distance);
      total += 1;
    }
    
    if (total == 0) {
      return null;
    }
    
    target.div(total);
    return target;
  }
  
  void applyForce(PVector target, float coefficient) {
    target.setMag(MAX_SPEED);
    
    PVector force = PVector.sub(target, velocity);
    force.mult(coefficient);
    force.limit(MAX_FORCE);
    acceleration.add(force);
  } 
  
  void separate() {
    PVector target = findTarget((t, neighbour, distance) -> {
      PVector difference = PVector.sub(position, neighbour.position);
      t.add(difference.div(distance * distance));
    });
    
    if (target != null) { applyForce(target, separation); }    
  }
  
  void cohere() {
    PVector centre = findTarget((t, neighbour, distance) -> {
      t.add(neighbour.position);
    });
    
    if (centre != null) {
      PVector target = PVector.sub(centre, position);
      applyForce(target, cohesion);
    }    
  }
  
  void align() {
    PVector target = findTarget((t, neighbour, distance) -> {
      t.add(neighbour.velocity);
    });
    
    if (target != null) { applyForce(target, alignment); }    
  }
}
