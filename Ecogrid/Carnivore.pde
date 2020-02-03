/*class Carnivore {
  float col;
  float shape;
  
  float foodW;
  float creatureW;
  float birthLimit;
  
  float nutrition;
  float startNutrition;
  boolean alive;
  
  float[] pos = new float[2];
  float[] tpos = new float[2];
  float[] npos = new float[2];
  
  Carnivore() {
    pos[0] = random(gs); pos[1] = random(gs);
    tpos[0] = pos[0]; tpos[1] = pos[1];
    col = random(255);
    shape = random(0.1,0.9);
    alive = true;
    nutrition = random(10,30);
    startNutrition = nutrition;
    foodW = random(-1,1);
    creatureW = random(-1,1);
    birthLimit = random(10,20);
    
    cells[getIndex(pos)].hasCarnivore++;
    
  }
  
  void selectTarget(int i) {
    float maxWeight = evaluateWeight(pos);
    float localWeight;
    
    npos[0] = max(pos[0]-i,0);
    npos[1] = max(pos[1]-i,0);
    
    tpos[0] = max(npos[0],0);
    tpos[1] = max(npos[1],0);
    
    for (int j = 0; j<2*i; j++) {
      //printArray(npos);
      localWeight = evaluateWeight(npos);
      //println(localWeight);
      if (localWeight>maxWeight) {maxWeight = localWeight;
        tpos[0] = min(npos[0],gs);
        tpos[1] = npos[1];
        //println("bling1: "+tpos);
      }
      
      npos[0] = min(npos[0]+1,gs);
    }
    for (int j = 0; j<2*i; j++) {
      //printArray(npos);
      localWeight = evaluateWeight(npos);
      //println(localWeight);
      if (localWeight>maxWeight) {maxWeight = localWeight;
        tpos[0] = npos[0];
        tpos[1] = min(npos[1],gs);
        //println("bling2: "+tpos);
      }
      
      npos[1] = min(npos[1]+1,gs);
      
    }
    for (int j = 0; j<2*i; j++) {
      //printArray(npos);
      localWeight = evaluateWeight(npos);
      //println(localWeight);
      if (localWeight>maxWeight) {maxWeight = localWeight;
        tpos[0] = max(npos[0],0);
        tpos[1] = npos[1];
        //println("bling3: "+tpos);
      }
      
      npos[0] = max(npos[0]-1,0);
      
    }
    for (int j = 0; j<2*i; j++) {
      //printArray(npos);
      localWeight = evaluateWeight(npos);
      //println(localWeight);
      if (localWeight>maxWeight) {maxWeight = localWeight;
        tpos[0] = npos[0];
        tpos[1] = max(npos[1],0);
        //println("bling4: "+tpos);
      }
      
      npos[1] = max(npos[1]-1,0);;
      nutrition -= 0.01;
    }
    /*println("max: "+maxWeight);
    println("pos: "+evaluateWeight(pos) + " "+pos);
    
    print("target: "); printArray(tpos);
    println("target niceness: "+evaluateWeight(tpos));
    
    
    if (maxWeight == evaluateWeight(pos)) {tpos[0]=pos[0];tpos[1]=pos[1];nutrition-=0.1;}
  }
  float evaluateWeight(float[] npos) {
    float weigth = 0;
    
    weigth += cells[getIndex(npos)].food * foodW;
    if (cells[getIndex(pos)].hasCreature>0) {
      weigth += creatureW;
    }
    if (cells[getIndex(pos)].hasCarnivore>0) {
      weigth -= 100;
    }
    return weigth;
  }
   void move() {
    cells[getIndex(pos)].hasCarnivore--;
    
    pos[0] = tpos[0];
    pos[1] = tpos[1];
    
    if (pos[0]>gs) {pos[0]=gs;}
    else if (pos[0]<0) {pos[0]=0;}
    if (pos[1]>gs) {pos[1]=gs;}
    else if (pos[1]<0) {pos[1]=0;}
    cells[getIndex(pos)].hasCarnivore++;
    nutrition -= 0.2;
  }
  void eat() {
    if (cells[getIndex(pos)].localCreature != null) {
      nutrition += cells[getIndex(pos)].localCreature.nutrition;
      cells[getIndex(pos)].localCreature.starve(true);
    }
  }
  void starve(boolean now) {
    if (nutrition<=0 || now) {
      
      alive = false;
      cells[getIndex(pos)].hasCarnivore--;
      deathRate++;
    }
  }
  
  void reproduce() {
    if (nutrition>birthLimit) {
      for (Carnivore c: carnivores) {
        if (c.alive != true) {
          c = new Creature(
          round(min(pos[0]+random(1),gs)),
          round(min(pos[1]+random(1),gs)),
          foodW + random(-1,1)*mRate,
          constrain(shape + random(-1,1)*mRate, 0.1,0.9),
          col + random(-1,1)*mRate*50,
          constrain(birthLimit + random(-1,1)*mRate*10,1,100),
          nutrition/3
          );
          
          c.alive = true;
          c.pos[0] = round(min(pos[0]+random(1),gs));
          c.pos[1] = round(min(pos[1]+random(1),gs));
          c.foodW = foodW + random(-1,1)*mRate;
          c.creatureW = creatureW + random(-1,1)*mRate;
          
          c.shape = constrain(shape + random(-1,1)*mRate, 0.1,0.9);
          c.col = col + random(-1,1)*mRate*200;
          c.birthLimit = max(birthLimit + random(-1,1)*mRate*10,2);
          c.nutrition = nutrition/3;
          
          birthRate++;
          cells[getIndex(pos)].hasCarnivore++;
          nutrition -= max(nutrition/2,0);
          break;
        }
      }
      
    }
  }
  void display() {
    
    fill(col,255,255);
    
    ellipse(
      pos[0]*cellsize+cellsize/2,
      pos[1]*cellsize+cellsize/2,
      
      min(1.7*cellsize*(1-shape)*2,  cellsize*1.7),
      min(1.7*cellsize*shape*2,  cellsize*1.7)
    );
  }
}*/
