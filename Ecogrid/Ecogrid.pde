
int s = 1440;
int cellsize = 4;
int gs = s/cellsize;

float mRate  = 0.03;

float[] foodMap = new float[(gs) * (gs)];
color[] cMap = new color[(gs) * (gs)];

FloatList births;
FloatList deaths;
FloatList population;

boolean pause = false;

ArrayList<Creature> creaturesA = new ArrayList();
ArrayList<Creature> creaturesN = new ArrayList();
ArrayList<Creature> creaturesR = new ArrayList();
Cell[] cells = new Cell[gs*gs];

void setup() {
  size(1440,1440);
  background(255);
  
  colorMode(HSB);
  //frameRate(3);
  
  foodMap = noisemap(foodMap,0.02,1);
  cMap = colorMap(foodMap,0,255);
  foodMap = limitIt(foodMap);
  
  births = new FloatList();
  deaths = new FloatList();
  population = new FloatList();
  
  for (int i = 0; i < gs*gs;i++) {
    cells[i] = new Cell(getCord(i),foodMap[i],cMap[i]);
  }

  for (int i = 0;i<2000;i++) {
    creaturesA.add(new Creature());
  }
}


void draw() {

  for (Cell c:cells) {
    c.grow();
    c.display();
  }

  for (Creature c:creaturesA) {
    if (c.alive) {
      if (true) {
        c.reproduce();
        c.selectTarget(1);
        c.move();
        c.attack();
        c.eat();
        c.starve(false);
        
      }
      c.display();
    }
  }
  births = updateStatList(births,countBirths(),400);
  deaths = updateStatList(deaths,countDeaths(),400);
  population = updateStatList(population,countAlive(),400);
  
  creaturesA.removeAll(creaturesR);
  creaturesA.addAll(creaturesN);
  creaturesR.clear();
  creaturesN.clear();
}

float[] noisemap(float[] map, float i,float mult) {
  noiseDetail(12);
  for (int y = 0; y<gs; y++) {
    for (int x = 0; x<gs; x++) {
      map[x+y*gs] = noise(i*x,i*y)*mult;
    }  
  }
  return map;
}


int[] colorMap(float[] map,float min,float max) {
  color[] cmap = new color[gs*gs];
  for (int y = 0; y<gs; y++) {
    for (int x = 0; x<gs; x++) {
      if (map[x+y*gs]>1) {
        cmap[x+y*gs] = 0;
      } else if (map[x+y*gs]>1) {
        cmap[x+y*gs] = 1;
      } else {cmap[x+y*gs] = 2;}
    }
  }
  return cmap;
}


float[] getCord(int i) {
  float[] pos = new float[2];
  pos[0] = i % gs;
  pos[1] = ceil(i/gs);
  return pos;
}


int getIndex(float[] pos) {
  int i = min(floor(gs*pos[1]+pos[0]),gs*gs-1);
  i = max(i,0);
  return i;
}


float[] limitIt(float[] map) {
  for (int y = 0; y<gs; y++) {
    for (int x = 0; x<gs; x++) {
      if (map[x+y*gs] < 0.35) {map[x+y*gs]=0;} else if (map[x+y*gs] > 1) {map[x+y*gs]=0;}
      else {map[x+y*gs]=min(map[x+y*gs]*2-0.6,1);}
    }
  }
  return map;
}

void printArray(float[] a) {
  print("[");
  for (int i = 0;i<a.length; i++) {
    print(a[i]+", ");
  }
  print("]\n");
}
int countAlive() {
  return creaturesA.size();
}
int countDeaths() {
  return creaturesR.size();
}
int countBirths() {
  return creaturesN.size();
}
FloatList updateStatList(FloatList list,float value, int length) {
  list.append(value);
  if (list.size()>length) {
    list.remove(0);
  }
  return list;
}

void mousePressed() {
  if (pause) {pause = false; loop();} else {pause = true; noLoop();
    rectMode(CORNERS);
    fill(255);
    rect(130,50,1200,1200);
    
    float[] avgs = getAverages();
    String info = " foodW: "+avgs[0]+
    "\n biggerCreatureW: "+avgs[1]+
    "\n smallerCreatureW: "+avgs[2]+
    "\n birthlimit: "+avgs[3]+
    "\n eatRate: "+avgs[4]+
    "\n eatEff: "+avgs[5]+
    "\n moveEff: "+avgs[6]+
    "\n powerLevel: "+avgs[7]+
    "\n count: "+avgs[8];
    fill(0);
    textSize(15);
    text(info, 140, 100);
    
    FloatList nutritions = new FloatList();
    FloatList birthlimits = new FloatList();
    FloatList eatRates = new FloatList();
    FloatList eatEffs = new FloatList();
    FloatList moveEffs = new FloatList();
    FloatList powerLevels = new FloatList();
    FloatList foodWeigths = new FloatList();
    FloatList bcWeigths = new FloatList();
    FloatList scWeigths = new FloatList();
    
    
    for (Creature c:creaturesA) {
      nutritions.append(c.nutrition);
      birthlimits.append(c.birthLimit);
      eatRates.append(c.eatRate);
      eatEffs.append(c.eatEff);
      moveEffs.append(c.moveEff);
      powerLevels.append(c.powerLevel);
      foodWeigths.append(c.foodW);
      bcWeigths.append(c.biggerCreatureW);
      scWeigths.append(c.smallerCreatureW);
    }
    ArrayList<Graph> graphs = new ArrayList();
    graphs.add(new Graph(140,400,300,100,nutritions,40));
    graphs.add(new Graph(140,520,300,100,birthlimits,40));
    graphs.add(new Graph(140,640,300,100,eatRates,40));
    graphs.add(new Graph(140,760,300,100,eatEffs,40));
    graphs.add(new Graph(140,880,300,100,moveEffs,40));
    
    graphs.add(new Graph(455,400,300,100,powerLevels,40));
    graphs.add(new Graph(455,520,300,100,foodWeigths,40));
    graphs.add(new Graph(455,640,300,100,bcWeigths,40));
    graphs.add(new Graph(455,760,300,100,scWeigths,40));
    for(Graph g:graphs) {
      g.generate();
      g.display();
    }
    ArrayList<Linegraph> linegraphs = new ArrayList();
    linegraphs.add(new Linegraph(750,100,400,200,population));
    linegraphs.add(new Linegraph(750,300,400,200,births));
    linegraphs.add(new Linegraph(750,500,400,200,deaths));
    for (Linegraph g:linegraphs) {
      g.generate();
      g.display();
    }
    rectMode(0);
  }
}
float[] getAverages() {
  int n = 0;
  float[] averages = new float[9];
  float foodW=0;
  float biggerCreatureW=0;
  float smallerCreatureW=0;
 
  float birthLimit=0;
  float eatRate=0;
  float eatEff=0;
  float moveEff=0;
  float powerLevel=0;
  for (Creature c: creaturesA) {if (c.alive) {n++;
    foodW += c.foodW;
    biggerCreatureW+=c.biggerCreatureW;
    smallerCreatureW+=c.smallerCreatureW;
    birthLimit+=c.birthLimit;
    eatRate+=c.eatRate;
    eatEff+=c.eatEff;
    moveEff+=c.moveEff;
    powerLevel+=c.powerLevel;
  }}
  averages[0] = foodW/n;
  averages[1] = biggerCreatureW/n;
  averages[2] = smallerCreatureW/n;
  averages[3] = birthLimit/n;
  averages[4] = eatRate/n;
  averages[5] = eatEff/n;
  averages[6] = moveEff/n;
  averages[7] = powerLevel/n;
  averages[8] = n;
  return averages;
}
