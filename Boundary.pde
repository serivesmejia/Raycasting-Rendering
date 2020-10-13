class Boundary {
  
  PVector a, b;
  
  Boundary(float x1, float y1, float x2, float  y2) {
    this.a = new PVector(x1, y1);
    this.b = new PVector(x2, y2);
  }

  void show() {
    stroke(255);
    line(this.a.x, this.a.y, this.b.x, this.b.y);
  }
  
  Polygon getPoly() {
   
    PVector[] points = { new PVector(a.x, a.y), new PVector(a.x, a.y+1), new PVector(b.x, b.y+1), new PVector(b.x, b.y) };
    
    return new Polygon(points);
    
  }
  
}
