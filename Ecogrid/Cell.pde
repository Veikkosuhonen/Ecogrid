class Cell {
  float food;
  int terrain;
  float[] pos = new float[2];
  float max;
  
  ArrayList<Creature> creatures;
  
  Cell(float[] p,float foodLevel,int terrainLevel) {
    pos = p;
    pos[0] *= cellsize;
    pos[1] *= cellsize;
    food = foodLevel;
    max = foodLevel;
    terrain = terrainLevel;
    creatures = new ArrayList();
  }
  
  
  void display() {
    noStroke();
    if (terrain == 0) {fill(180,190,200);}
    else if (terrain == 1) {fill(150,190,240);}
    else {fill(100,255,food*255);}
    rect(pos[0],pos[1],cellsize,cellsize);
  }
  
  void grow() {
    if (food<max) {
      food += 0.006;
      
    }

  }
}
