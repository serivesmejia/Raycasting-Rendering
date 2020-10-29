class Player {
  
  PVector pos;
  ArrayList<Ray> rays;
  
  float degrees;
  
  float castRayEach = 0.2;
  
  int fov;
  
  Player(int fov) {
    
    pos = new PVector(width / 2, height / 2);
  
    setFov(fov);
    
  }

  void move(float speed, Boundary[] boundaries) {
  
    float newX = pos.x + cos(radians(degrees + fov / 2)) * speed;
    if(!blocking(newX, pos.y, boundaries)) pos.set(newX, pos.y);
    
    float newY = pos.y + sin(radians(degrees + fov / 2)) * speed;
    if(!blocking(pos.x, newY, boundaries)) pos.set(pos.x, newY);
    
  }
  
  void setFov(int fov) {
    
    rays = new ArrayList();
    this.fov = fov;
   
    for (float a = -this.fov / 2; a < this.fov / 2; a += castRayEach) {
      this.rays.add(new Ray(pos, radians(a)));
    }
    
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
    
    int i = 0;
    
    for (float a = -this.fov / 2; a < this.fov / 2; a += castRayEach) {
      this.rays.get(i).setAngle(radians(a) + radians(degrees));
      i++;
    }
    
  }

  float[] look(Boundary[] walls, boolean drawRays) {
    
   float[] scene = new float[this.rays.size()-1];
    
    for (int i = 0; i < this.rays.size()-1; i++) {
      
      Ray ray = this.rays.get(i);
      PVector closest = null;
      float record = 500000000;
      
      for (Boundary wall : walls) {
        
        PVector pt = ray.cast(wall);
        
        if (pt != null) {
          
          float d = PVector.dist(this.pos, pt);
          
          float a = ray.dir.heading() - radians(degrees);
          
          d *= cos(a);
          
          if (d < record) {
            record = d;
            closest = pt;
          }
          
        }
        
      }
      
      if (closest != null && drawRays) {
        stroke(255, 100);
        line(this.pos.x, this.pos.y, closest.x, closest.y);
      }
      
      scene[i] = record;
      
    }
    
    return scene;
    
  }

  void show() {
    fill(255);
    ellipse(this.pos.x, this.pos.y, 4, 4);
    for (Ray ray : this.rays) {
      ray.show();
    }
  }
  
}
