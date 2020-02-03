class Creature {
  
  float col;
  float shape;
  
  float foodW;
  float biggerCreatureW;
  float smallerCreatureW;
  
  float birthLimit;
  
  float eatRate0;
  float eatEff0;
  float moveEff0;
  float powerLevel0;
  
  float eatRate;
  float eatEff;
  float moveEff;
  float powerLevel;
  
  float nutrition;
  float startNutrition;
  boolean alive;
  boolean reproducing;
  
  float[] pos = new float[2];
  float[] tpos = new float[2];
  float[] npos = new float[2];
  
  Creature() {
      pos[0] = random(gs); pos[1] = random(gs);
      tpos[0] = pos[0]; tpos[1] = pos[1];
      col = random(255);
      shape = random(-1,1);
      alive = true;
      
      
      foodW = random(0,1);
      biggerCreatureW = random(-1,1);
      smallerCreatureW = random(-1,1);
      
      birthLimit = random(5,30);
      nutrition = random(5,15);
      startNutrition = 1;
      reproducing = false;
      
      eatRate0 = random(1);;
      eatEff0 = random(1);
      moveEff0 = random(1);
      powerLevel0 = random(1);
      float sum = eatRate0+eatEff0+moveEff0+powerLevel0;
      
      eatRate = eatRate0/sum;
      eatEff = eatEff0/sum;
      moveEff = moveEff0/sum;
      powerLevel = powerLevel0/sum;
      
      cells[getIndex(pos)].creatures.add(this);
  }
  Creature(int x, int y, float c, float s, float f, float bcw, float scw, float bl, float n, float sn, float er, float ef, float me, float pl) {
      pos[0] = x; pos[1] = y;
      tpos[0] = x; tpos[1] = y;
      col = c;
      shape = s;
      alive = true;
      
      
      foodW = f;
      biggerCreatureW = bcw;
      smallerCreatureW = scw;
      
      birthLimit = bl;
      nutrition = n;
      startNutrition = 1;
      reproducing = false;
      
      eatRate0 = er;
      eatEff0 = ef;
      moveEff0 = me;
      powerLevel0 = pl;
      float sum = eatRate0+eatEff0+moveEff0+powerLevel0;
    
      eatRate = max(eatRate0/sum,0.06);
      eatEff = max(eatEff0/sum,0.06);
      moveEff = moveEff0/sum;
      powerLevel = powerLevel0/sum;
      
      cells[getIndex(pos)].creatures.add(this);
  }
  
  void selectTarget(int i) {
    if (!reproducing) {
      
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
      
    }
    /*println("max: "+maxWeight);
    println("pos: "+evaluateWeight(pos) + " "+pos);
    
    print("target: "); printArray(tpos);
    println("target niceness: "+evaluateWeight(tpos));*/
    
    
    }
  }
  
  
  float evaluateWeight(float[] npos) {
    float weigth = 0;
    float creatureWeight = 0;
    weigth += cells[getIndex(npos)].food * foodW;
    
    if (!cells[getIndex(npos)].creatures.isEmpty()) {
      for (Creature c : cells[getIndex(npos)].creatures) {
        if (c.nutrition>nutrition) {
          creatureWeight += biggerCreatureW;
        } else if (c.nutrition<nutrition) {
          creatureWeight += smallerCreatureW;
        }
      }
      weigth += creatureWeight/cells[getIndex(npos)].creatures.size();
    }
    
    return weigth;
  }
  
  
  void move() {
    
      
    cells[getIndex(pos)].creatures.remove(this);
    
    pos[0] = tpos[0];
    pos[1] = tpos[1];
    
    if (pos[0]>gs) {pos[0]=gs;}
    else if (pos[0]<0) {pos[0]=0;}
    if (pos[1]>gs) {pos[1]=gs;}
    else if (pos[1]<0) {pos[1]=0;}
    
    cells[getIndex(pos)].creatures.add(this);
    
    nutrition -= 1/(moveEff*6)+0.04;
    
    
  }
  
  void eat() {
    
      
    if (cells[getIndex(pos)].food>0.3) {
      float newfood = (eatRate*0.15)*cells[getIndex(pos)].food;
      cells[getIndex(pos)].food = max(cells[getIndex(pos)].food-newfood-0.05,0);
      
      nutrition += newfood*eatEff*70;
    }
    
  }
  void attack() {
    
      
    Creature target = null;
    float maxNutrition = 0;
    for(Creature c:cells[getIndex(pos)].creatures) {
      if (c.getStrength()<getStrength()) {
        if (c.nutrition>maxNutrition) {
          maxNutrition=c.nutrition;
          target = c;
        }
      }
    }
    if (target!=null) {
      target.starve(false);
      nutrition+=target.nutrition*1;
    }
  
  }
  
  void starve(boolean now) {
    if (nutrition<=0 || now) {
      cells[getIndex(pos)].creatures.remove(this);
      alive = false;
      creaturesR.add(this);
      //cells[getIndex(pos)].food += 0.1;
      
    }
  }
  
  void reproduce() {
    if (nutrition>birthLimit) {
      
      /*for (Creature c: creatures) {
        if (c.alive != true) {
          /*c = new Creature(
          round(min(pos[0]+random(1),gs)),
          round(min(pos[1]+random(1),gs)),
          foodW + random(-1,1)*mRate,
          constrain(shape + random(-1,1)*mRate, 0.1,0.9),
          col + random(-1,1)*mRate*50,
          constrain(birthLimit + random(-1,1)*mRate*10,1,100),
          nutrition/3
          );
          if (random(200)>199) {mRate *= 20;}
          c.alive = true;
          c.pos[0] = round(min(pos[0]+random(1),gs));
          c.pos[1] = round(min(pos[1]+random(1),gs));
          c.foodW = foodW + random(-1,1)*mRate;
          c.biggerCreatureW = biggerCreatureW + random(-1,1)*mRate;
          c.smallerCreatureW = smallerCreatureW + random(-1,1)*mRate;
          c.eatRate = eatRate + random(-1,1)*mRate;
          c.shape = constrain(shape + random(-1,1)*mRate, 0.1,0.9);
          c.col = col + random(-1,1)*mRate*200;
          c.birthLimit = constrain(birthLimit + random(-1,1)*mRate*10,1,100);
          c.eatEff = (1+random(-1,1)*mRate)-eatRate+0.1;
          c.moveEff = max(moveEff + random(-1,1)*mRate*0.1,0);
          c.nutrition = nutrition/3;
          cells[getIndex(c.pos)].creatures.add(c);
          birthRate++;
          nutrition -= nutrition/2;
          mRate = 0.01;
          break;
          
          
        }
      } */
      creaturesN.add(new Creature(
        round(constrain(pos[0]+random(1)*6-3,0,gs)),
        round(constrain(pos[1]+random(1)*6-3,0,gs)),
        col + random(-1,1)*mRate*200,
        constrain(shape + random(-1,1)*mRate, 0.1,0.9),
        constrain(foodW + random(-1,1)*mRate,0,1),
        biggerCreatureW + random(-1,1)*mRate,
        smallerCreatureW + random(-1,1)*mRate,
        constrain(birthLimit + random(-1,1)*mRate*10,1,100),
        nutrition/4,
        1,
        constrain(eatRate0 + random(-1,1)*mRate,0,1),
        constrain(eatEff0 + random(-1,1)*mRate,0,1),
        constrain(moveEff0 + random(-1,1)*mRate*0.1,0,1),
        constrain(powerLevel0 +random(-1,1)*mRate,0,1)
      ));
      this.nutrition *= 3/4;

    }
  }
  
  void display() {
    
    float m = sqrt(nutrition);
    
    fill(col,255-155*powerLevel,255);
    
    ellipse(
      pos[0]*cellsize+cellsize/2,
      pos[1]*cellsize+cellsize/2,
      
      min(cellsize*(1-shape)*2*m,  cellsize*m),
      min(cellsize*shape*2*m,  cellsize*m)
    );
  }
  float getStrength() {
    return nutrition*(1+powerLevel*8);
  }
  
}
