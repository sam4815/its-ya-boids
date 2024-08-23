float separation = 0.003;
float alignment = 0.006;
float cohesion = 0.007;

class Flockable {
  PVector position = new PVector();
  PVector velocity = new PVector();
  PVector acceleration = new PVector();
  
  void applyForce(PVector target, float coefficient) {
    target.setMag(MAX_SPEED);
    
    PVector force = PVector.sub(target, velocity);
    force.mult(coefficient);
    force.limit(MAX_FORCE);
    acceleration.add(force);
  } 
  
  void flock() {
    PVector separationTarget = new PVector();
    PVector alignmentTarget = new PVector();
    PVector cohesionTarget = new PVector();
    int total = 0;
    
    for (Boid otherBoid: boids) {
      float distance = dist(position.x, position.y, otherBoid.position.x, otherBoid.position.y);
      if (otherBoid == this || distance > RADIUS) { continue; }
      
      PVector difference = PVector.sub(position, otherBoid.position);
      separationTarget.add(difference.div(distance * distance));
      
      
      cohesionTarget.add(otherBoid.position);
      
      alignmentTarget.add(otherBoid.velocity);
      
      total += 1;
    }
    
    if (total == 0) { return; }
    
    separationTarget.div(total);
    applyForce(separationTarget, separation);
    
    cohesionTarget.div(total);
    applyForce(PVector.sub(cohesionTarget, position), cohesion);
    
    alignmentTarget.div(total);
    applyForce(alignmentTarget, alignment);
  }
}
