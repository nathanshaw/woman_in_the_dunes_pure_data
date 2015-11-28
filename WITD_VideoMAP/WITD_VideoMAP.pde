import netP5.*;
import oscP5.*;
import quickhull3d.*;
import ComputationalGeometry.*;
import processing.video.*;

/***~***/
/***~***/

int currMedia = 0;
int[] numShapes = {10, 10, 10}; //the number of shapes PER media file
String[] mediaFiles = {"WITD-sand.mp4", "WITD-sandBug.mp4", "WITD-sandFilter.mp4"}; //the media file names
int numMedia = numShapes.length;

float r, g, b, r2, g2, b2;
float noise1, noise2;
float bright1, bright2;

int sliders = 9;
float [] s = {0, 0, 0, 0, 0, 0, 0, 0,0};
int knobs = 8;
float [] k = {0, 0, 0, 0, 0, 0, 0, 0};
int buttons = 8;
int [] btn = {0, 0, 0, 0, 0, 0, 0, 0};


ClippingMask[] clip = new ClippingMask[numMedia];
boolean calibrate = true;

OscP5 osc;
NetAddress martinLocation;

void setup() {
  size(displayWidth, displayHeight, P3D);
  for (int i=0; i<numMedia; i++) {
    clip[i] = new ClippingMask(this, mediaFiles[i], "clip"+i+".json", i, numShapes[i]);
  }
  smooth();

  textSize(18);

  osc = new OscP5(this, 3001);//receive OSC
  martinLocation = new NetAddress("127.0.0.1", 3000);//send OSC
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  background(0);
  noise1 = map(s[1], 0, 1, 0, 10);
  r = map(s[2], 0, 1, 0, 255); 
  g = map(s[3], 0, 1, 0, 255);
  b = map(s[4], 0, 1, 0, 255);
  
  noise2 = map(s[5], 0, 1, 0, 10);
  r2 = map(s[6], 0, 1, 0, 1000);
  g2 = map(s[7], 0, 1, 0, 1000);
  b2 = map(s[8], 0, 1, 0, 1000);
  bright1 = map(k[1], 0, 1, 70, 255);
  bright2 = map(k[2], 0, 1, 0, height);


  
  for (int i=0; i<clip.length; i++) {
    clip[i].drawClippingMask();
  }

  if (calibrate) {
    fill(255);
    text("currentMedia = " + currMedia + ", currentShape = " + clip[currMedia].currShape, 20, 30);
  } else {
    noFill();
  }
}

void mousePressed() {
  if (calibrate) {
    ClippingMask currentClip = clip[currMedia]; //if you want to interact with another shape, change it here!

    boolean addNewPoint = true;
    for (int i=0; i<currentClip.controlPoints[currentClip.currShape].size(); i++) {
      if (currentClip.controlPoints[currentClip.currShape].get(i).mouseInside) {
        addNewPoint = false;
        break;
      }
    }
    if (addNewPoint) {
      currentClip.addPointToShape(-1, mouseX, mouseY, random(0, 1));
    }
  }
}

void mouseDragged() {
  if (calibrate) {
    ClippingMask currentClip = clip[currMedia]; //if you want to interact with another shape, change it here!

    for (int i=0; i<currentClip.controlPoints[currentClip.currShape].size(); i++) {
      if (currentClip.controlPoints[currentClip.currShape].get(i).mouseInside) {
        currentClip.controlPoints[currentClip.currShape].get(i).updatePoint(currentClip, mouseX, mouseY);
      }
    }
  }
}

void keyPressed() {
  if (key == 'c') {
    calibrate = !calibrate;
  } else if (key == 's') {
    saveCalibration();
  } else if (key == 'l') {
    loadCalibration();
  } else if (keyCode == UP) {
    currMedia++;

    if (currMedia >= numMedia) {
      currMedia--;
    } else if (currMedia < 0) {
      currMedia = 0;
    }
  } else if (keyCode == DOWN) {
    currMedia--;

    if (currMedia >= numMedia) {
      currMedia--;
    } else if (currMedia < 0) {
      currMedia = 0;
    }
  } else if (keyCode == LEFT) {
    clip[currMedia].updateCurrShape(-1);
  } else if (keyCode == RIGHT) {
    clip[currMedia].updateCurrShape(1);
  }
}

void saveCalibration() {
  for (int i=0; i<clip.length; i++) {
    clip[i].saveData();
  }
}

void loadCalibration() {
  for (int i=0; i<clip.length; i++) {
    clip[i].loadData();
  }
}

void oscEvent(OscMessage msg) {
  for (int i=1; i<sliders; i++)
  {
    String addr;
    addr = "/s" + i; 
    if (msg.checkAddrPattern(addr) == true)
    {
      s[i] = msg.get(0).floatValue();
      println(s[i]);
    }
  }
  for (int i=1; i<knobs; i++)
  {
    String addr;
    addr = "/k" + i; 
    if (msg.checkAddrPattern(addr) == true)
    {
      k[i] = msg.get(0).floatValue();
      println(k[i]);
    }
  }
  for (int i=1; i<buttons; i++)
  {
    String addr;
    addr = "/b" + i; 
    if (msg.checkAddrPattern(addr) == true)
    {
      btn[i] = msg.get(0).intValue();
      println(btn[i]);
    }
  }
  print("### received an osc message.");
  print(" addrpattern: "+msg.addrPattern());
  println(" typetag: "+msg.typetag());
}