class Player {
  
  PVector pos;
  Ray[] rays;
  
  float degrees;
  
  Player() {
    this.pos = new PVector(width / 2, height / 2);
    this.rays = new Ray[65];
    for (int a = 0; a < this.rays.length; a += 1) {
      this.rays[a] = new Ray(pos, radians(a));
    }
  }

  void move(float speed, Boundary[] boundaries) {
  
    float newX = pos.x + cos(radians(degrees)) * speed;
    if(!blocking(newX, pos.y, boundaries)) pos.set(newX, pos.y);
    
    float newY = pos.y + sin(radians(degrees)) * speed;
    if(!blocking(pos.x, newY, boundaries)) pos.set(pos.x, newY);
    
  }
  
  boolean blocking(float x, float y, Boundary[] boundaries) {
  
    PVector[] points = {new PVector(x, y), new PVector(x, y+1), new PVector(x+1, y+1), new PVector(x+1, y)};
    
    for(Boundary boundary : boundaries) {   
         
      if(boundary.getPoly().isIntersecting(new Polygon(points))) return true;
      
    }
    
    return false;
    
  }
  
  Polygon getPoly() {
   
    PVector[] points = {new PVector(pos.x, pos.y), new PVector(pos.x, pos.y), new PVector(pos.x, pos.y), new PVector(pos.x, pos.y)};
    
    return new Polygon(points);
    
  }
  
  void rotate(float byDegrees) {
    
    degrees += byDegrees;
    
    if(degrees >= 360 || degrees <= -360) {
      degrees = 0;
    }
    
    for (int a = 0; a < this.rays.length; a += 1) {
      this.rays[a].setAngle(radians(a) + radians(degrees));
    }
    
  }

  void look(Boundary[] walls) {
    for (int i = 0; i < this.rays.length; i++) {
      Ray ray = this.rays[i];
      PVector closest = null;
      float record = 500000000;
      for (Boundary wall : walls) {
        PVector pt = ray.cast(wall);
        if (pt != null) {
          float d = PVector.dist(this.pos, pt);
          if (d < record) {
            record = d;
            closest = pt;
          }
        }
      }
      if (closest != null) {
        stroke(255, 100);
        line(this.pos.x, this.pos.y, closest.x, closest.y);
      }
    }
  }

  void show() {
    fill(255);
    ellipse(this.pos.x, this.pos.y, 4, 4);
    for (Ray ray : this.rays) {
      ray.show();
    }
  }
  
}
