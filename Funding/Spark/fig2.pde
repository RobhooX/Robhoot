import processing.pdf.*;
import org.gicentre.utils.colour.*;

int pagewidth = 1500;
int pageheight = 2700;
float distance_between_shapes = pagewidth*2/5;

void settings(){
  size(pagewidth, pageheight, PDF, "fig2_beforeInkScape.pdf");
}

void setup(){
  background(255, 255, 255);
  PFont f;
  f = createFont("Arial",16,true); // Arial, 16 point, anti-aliasing on
  textFont(f,72);
  float[] ys = new float[4];
  String[] layernames = {"Gene network", "Individuals", "Populations", "Communities"};
  float w1 = ((width-80)/5)*3;
  float h = distance_between_shapes-150;
  float x1 = (width/5) + 10;
  for (float i=1; i<5; i++) {
    float y1 = height-(distance_between_shapes * i)-(1*(i-1));
    Plane p1 = new Plane(x1, y1, w1, width-80, h/1.3);
    p1.display();
    ys[int(i)-1] = y1;
    
    fill(0);
    text(layernames[int(i)-1], x1,y1-19);
  }
  // genes network
  Network ng = new Network((width/7) + w1/2.5, ys[0]-(ys[0]*0.055) + h/2, 70.0);
  ng.display();
  // individual networks
  Individual nt = new Individual((width/7) + w1/4.5, ys[1]-85 + h/2, 76.0);
  nt.display();
  Individual nt2 = new Individual((width/7) + w1/1.65, ys[1]-85 + h/2, 80.0);
  nt2.display();
  Individual nt3 = new Individual((width/7) + w1/1.0, ys[1]-85 + h/2, 88.0);
  nt3.display();
  // population networks
  Population p1 = new Population((width/7) + w1/4.5, ys[2]-85 + h/2, 30.0);
  p1.display();
  Population p2 = new Population((width/7) + w1/1.65, ys[2]-85 + h/2, 30.0);
  p2.display();
  Population p3 = new Population((width/7) + w1/1.0, ys[2]-85 + h/2, 30.0);
  p3.display();
  // community networks
  Community c1 = new Community((width/7) + w1/4.5, ys[3]-85 + h/2, 30.0);
  c1.display();
  Community c2 = new Community((width/7) + w1/1.65, ys[3]-85 + h/2, 30.0);
  c2.display();
  Community c3 = new Community((width/7) + w1/1.0, ys[3]-85 + h/2, 30.0);
  c3.display();
}

class Plane {
  float x1;
  float x2;
  float x3;
  float x4;
  float y1;
  float y2;
  float y3;
  float y4;
  
  Plane(float x1c, float y1c, float widthtop, float widthbottom, float h) {
    x1 = x1c;
    y1 = y1c;
    x2 = x1 + widthtop;
    y2 = y1;
    float dtemp = ((widthbottom - widthtop)/2);
    x3 = x2 + dtemp;
    y3 = y1 + h;
    x4 = x1 - dtemp;
    y4 = y3;
  }
   
  void display() {
    stroke(0.0, 0.0, 0.0, 180);
    strokeWeight(2);
    beginShape();
    fill(250, 50, 50, 10);
    vertex(x1,y1);
    vertex(x2,y2);
    fill(255, 150, 50, 20);
    vertex(x3,y3);
    vertex(x4,y4);
    //vertex(x1, y1);
    endShape(CLOSE);
  }
}

class Network {
  float x;
  float y;
  float size;
  ColourTable myCTable;
  
  Network(float x_, float y_, float size_){
    x = x_;
    y = y_;
    size = size_;
    myCTable = ColourTable.getPresetColourTable(ColourTable.YL_OR_RD,0.05, size/5);

  }
  
  void display(){
    fill(150, 150, 255);
    float x1 = x+(size*2);
    float y1 = y-(size/2);
    float x2 = x1+(size*2);
    float y2 = y1;
    float x3 = x2+(size*2);
    float y3 = y;
    float x4 = x3;
    float y4 = y + (size*2);
    float x5 = x2;
    float y5 = y4 + (size/2);
    float x6 = x1;
    float y6 = y5;
    float x7 = x;
    float y7 = y5 - (size/2);
    stroke(20, 20, 255, 255);
    float[] xs = {x, x1, x2, x3, x4, x5, x6, x7};
    float[] ys = {y, y1, y2, y3, y4, y5, y6, y7};
    for (int i=0; i<7; i++){
      for (int j=i+1; j<8; j++){
        float weight = random(0.05, size/5);
        strokeWeight(weight);
        stroke(myCTable.findColour(weight));
        line(xs[i],ys[i],xs[j],ys[j]);
      }
    }
    noStroke();
    ellipse(x, y, size, size);
    ellipse(x1, y1, size, size);
    ellipse(x2, y2, size, size);
    ellipse(x3, y3, size, size);
    ellipse(x4, y4, size, size);
    ellipse(x5, y5, size, size);
    ellipse(x6, y6, size, size);
    ellipse(x7, y7, size, size);
  }
}


class Individual{
  float x;
  float y;
  float size;
  ColourTable myCTable;
  float fitness = random(2.5, 5);
  
  Individual (float x_, float y_, float size_){
    x = x_;
    y = y_;
    size = size_;
    myCTable = ColourTable.getPresetColourTable(ColourTable.GN_BU,1, 5);
  }
  
  void display(){
    stroke(myCTable.findColour(fitness));
    strokeWeight(fitness);
    noFill();
    float w = size*3.5;
    float h = size*2.5;
    ellipse(x, y, w, h);
    Network nt = new Network(x-w/3.0, y-h/4.8, size/2.5);
    nt.display();
  }
}

class Population{
  float x;
  float y;
  float size;
  ColourTable myCTable;
  float fitness = random(2.5, 5);
  
  Population (float x_, float y_, float size_){
    x = x_;
    y = y_;
    size = size_;
    myCTable = ColourTable.getPresetColourTable(ColourTable.GN_BU,1, 5);
  }
  
  void display(){
    stroke(myCTable.findColour(fitness));
    strokeWeight(fitness*1.5);
    noFill();
    float w = size*9;
    float h = size*7;
    ellipse(x, y, w, h);
    Individual nt1 = new Individual(x-w/4.5, y-h/6, size);
    nt1.display();
    Individual nt3 = new Individual(x+w/4.5, y-h*0.1, size);
    nt3.display();
    Individual nt4 = new Individual(x-w*0.07, y+h/4.5, size);
    nt4.display();
  }
}


class Community{
  float x;
  float y;
  float size;
  ColourTable myCTable;
  float fitness = random(2.5, 5);
  
  Community (float x_, float y_, float size_){
    x = x_;
    y = y_;
    size = size_;
    myCTable = ColourTable.getPresetColourTable(ColourTable.GN_BU,1, 5);
  }
  
  void display(){
    stroke(myCTable.findColour(fitness));
    strokeWeight(fitness*1.5);
    noFill();
    float w = size*9;
    float h = size*7;
    ellipse(x, y, w, h);
    Population nt1 = new Population(x-w/4.5, y-h/6, size/3);
    nt1.display();
    Population nt3 = new Population(x+w/4.5, y-h*0.1, size/3);
    nt3.display();
    Population nt4 = new Population(x-w*0.07, y+h/4.5, size/3);
    nt4.display();
  }
}
