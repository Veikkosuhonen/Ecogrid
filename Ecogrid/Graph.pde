class Graph {
  private FloatList values;
  private int x,y,w,h,steps;
  private float offset,maxV;
  private float Xaxis;
  private int[] histogram;
  private int max;
  Graph(int x,int y,int w, int h,FloatList values, int steps) {
    this.values = values;
    this.steps = steps;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    histogram = new int[steps];
    max = 0;
  }
  void generate() {
    maxV = values.max();
    
    float minV = values.min();
    float span = maxV-minV;
    offset = 0;
    if (minV<0) {offset-=minV;maxV+=offset;max+=offset;}
    for (float f:values) {
      f+=offset;
      
      histogram[round(f/maxV*(steps-1))]++;
    }
    Xaxis = round(offset/maxV*(steps-1))*(w/steps);
    
    for (int i = 0;i<histogram.length;i++) {
      if (histogram[i]>max) max = histogram[i];
    }
  }
  void display() {
    
    stroke(0);
    rectMode(CORNERS);
    line(x+Xaxis,y-5,x+Xaxis,y+h+5);
    line(x,y+h,x+w,y+h);
    fill(200);
    
    for (int i = 0;i<steps;i++) {
      rect(
        x+(w/steps)*i,
        y+h,
        x+(w/steps)*i+w/steps,
        y+h-(histogram[i]*1.0)/max*h
      );
      
    }
    
    strokeWeight(2);
    line(x+Xaxis,y-5,x+Xaxis,y+h+5);
    line(x,y+h,x+w,y+h);
    fill(200);
    
    strokeWeight(1);
    rectMode(0);
    noStroke();
  }
}
