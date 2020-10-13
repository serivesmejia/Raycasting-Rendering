class Polygon {
 
   PVector[] points;
  
   Polygon(PVector[] points) {
     this.points = points;
   }
  
   PVector[] getPoints() {
      
     return points;
     
   }
   
   
  boolean isIntersecting(Polygon a) {
    
    Polygon b = this;
    
    for (int x=0; x<2; x++) {
        Polygon polygon = (x==0) ? a : b;

        for (int i1=0; i1<polygon.getPoints().length; i1++) {
            int   i2 = (i1 + 1) % polygon.getPoints().length;
            PVector p1 = polygon.getPoints()[i1];
            PVector p2 = polygon.getPoints()[i2];

            PVector normal = new PVector(p2.y - p1.y, p1.x - p2.x);

            double minA = Double.POSITIVE_INFINITY;
            double maxA = Double.NEGATIVE_INFINITY;

            for (PVector p : a.getPoints()) {
                double projected = normal.x * p.x + normal.y * p.y;

                if (projected < minA)
                    minA = projected;
                if (projected > maxA)
                    maxA = projected;
            }

            double minB = Double.POSITIVE_INFINITY;
            double maxB = Double.NEGATIVE_INFINITY;

            for (PVector p : b.getPoints()) {
                double projected = normal.x * p.x + normal.y * p.y;

                if (projected < minB)
                    minB = projected;
                if (projected > maxB)
                    maxB = projected;
            }

            if (maxA < minB || maxB < minA)
                return false;
        }
        
    }

    return true;
  }
  
}
