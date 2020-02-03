class Linegraph {
  private FloatList values;
  private int x,y,w,h,steps, off;
  private int max;
  Linegraph(int x,int y,int w, int h,FloatList values) {
    this.values = values;
    this.steps = values.size();
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    max = 0;
  }
  void generate() {
    float maxV = values.max();
    
    float minV = values.min();
    float span = maxV-minV;
    
    FloatList newList = new FloatList();
    for (float f:values) {
      f-=minV;
      newList.append(f/span*h);
    }
    values = newList;
  }
  void display() {
    
    
    fill(128,255,125);
    
    
    for (int i = 0;i<steps;i++) {
      ellipse(
        x + (w*1.0/steps)*i,
        y + h - values.get(i),
        2,2
      );
      
    }
    stroke(0);
    line(x,y,x,y+h);
    line(x,y+h,x+w,y+h);
    noStroke();
    
    
    
  }
}
