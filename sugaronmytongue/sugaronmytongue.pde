PImage disco;
//int countsframe = 1;

PImage tongue;
PImage lip1;
PImage lip2;
PImage lipe;
PImage candy;

//int currentScene = 1;


import ddf.minim.*;
Minim minim;
AudioPlayer player;


boolean discoAppear = false;
boolean minisAppear = false;
boolean minis2Appear = false;
boolean candyAppear = false;


//audio
float gradOffsetL = 3;   // sol şeridin ofseti (0..1)
float gradOffsetR = 3;   // sağ şeridin ofseti (0..1)
float gradSmooth = 1;   // smoothing (0 yavaş, 1 ani)

//RADIAL GRADIENT SETUP
boolean showGradient = false;   // g on of
int dim;                        // drawGradient radius

// color and steps
float HUE_MIN  = 200;
float HUE_MAX  = 330;
float SAT      = 90;
float BRI      = 70;
float HUE_STEP = 2.0;   // reactive to mousey
int   R_STEP   = 3;     // reactive to mousex

// ÜSTE (global)
int TARGET_FPS = 30;  // 24–30 iyi


void setup(){
  //pixelDensity(1); lag fix
  fullScreen(P2D);
  // setup() İÇİNE
frameRate(TARGET_FPS);
  
  
  //size(650,650);
  fullScreen(); //circle ortada olsun diye circle(width/2,height/2,234);
  
  disco = loadImage("disco.png");
  tongue = loadImage("tongue.png");
  lip1 = loadImage("l8.png");
  lip2 = loadImage("l7.png");
  lipe = loadImage("l9.png");
  candy = loadImage("candy.png");
  
  //background(11,54,180); //trail biraksin diye
  imageMode(CENTER); //image ortadan varolacka ki mouse nerdeyse orda olsun
  
  minim = new Minim(this);
  player = minim.loadFile("sugar2.wav");
  player.play();
  
  // === GRADIENT MODÜLÜ: setup ekleri ===
    dim = width / 2;          // drawGradient’te yarıçap türetmek için
    
  
}

void draw(){
  //background(11,54,180);
  // fade out efect::
  //fill(11,54,108, 50);
  //rect(0,0,  width,height);
  
  
  // Arka plan: yukarıdan aşağıya beyaz → siyah
  float mx = map(mouseX, 0, width, 0, 255);
  float my = map(mouseY, 0, height, 0, 255);

  setGradient(0, 0, width, height, color(my, 170, 50), color(120, mx, 255));

  //audio
  float left = player.left.get(1) * 100000;   // sol kanal
  float right = player.right.get(1) * 100000;  // sağ kanal

  // offset map
  float targetL = constrain(map(left, -100, 100, 0.0, 1.0), 0, 1);
  float targetR = constrain(map(right, -100, 100, 0.0, 1.0), 0, 1);

 // offset reactive
 setGradientHOffset(0, 0, width/3, height,  color(120,0,255), color(0,170,50), targetL);       
 setGradientHOffset(2*width/3, 0, width/3, height, color(0,170,50), color(120,0,255), targetR);
 
 
  if (discoAppear) {
    image(disco, width/2, height/6, 300, 300);
  }
  
  
  if (minisAppear) {
  fill(106,232,66);
  noStroke();
  for (int i = 0; i < 20; i++) {
    square(random(width), random(height), 20);
    }
  }

  if (minis2Appear) {
  fill(232,66,230);
  noStroke();
  for (int i = 0; i < 20; i++) {
    square(random(width), random(height), 20);
          }
       }
       
       
       if (candyAppear) {
  int s = 100; // size
  
  image(candy, width/6, height/4.5, s, s); //solust
  image(candy, width - width/6, height/4.5, s, s);// sagust
  image(candy, width/6, height - height/4.5, s, s); //solalt
  image(candy, width - width/6, height - height/4.5, s, s); //sagalt
}
       
       
       
       // === GRADIENT MODÜLÜ: draw ekleri ===
if (showGradient) {
  float hStart  = map(mouseX, 0, width,  HUE_MIN, HUE_MAX);
  HUE_STEP      = constrain(map(mouseY, 0, height, 0.5, 8.0), 0.5, 8.0);
  drawGradient(width/2, height/2, hStart);
}
       
 }

void keyPressed(){
 // if(key == '2'){ currentScene = 2;  }
  //if(key == '1'){    currentScene = 1;  }
  //if(key == 'a'){  background(random(0,250),random(0,250),random(0,250));  }
  
  if(key == 'i'){
    //background(250,0,0);
    filter(INVERT);
  }

 // if(key == 'o'){   fill(255);   circle(350,350,350); }
 
  if(key == 's'){
    save("screenshot.jpg");
  }
  
  if (key == 'd' || key == 'D') {
  discoAppear = !discoAppear; // D'ye her basışta aç/kapat
  } 
  
  if(key == 'e'){
    //background(250,0,0);
    image(lipe, width/2, height/2, 400, 400);
  }
  
  if (key == 'c' || key == 'C') {
  candyAppear = !candyAppear; 
}
  
  if (keyCode == UP) {
    println("YUKARI basıldı");
    image(lip1, width/2, height/2, 400, 400);   // ↑ basıldığında lip5 çiz
  }
  
  if (keyCode == DOWN) {
    println("AŞAĞI basıldı");
    image(lip2, width/2, height/2, 400, 400);   // ↓ basıldığında lip6 çiz
  }

if (key == 's' || key == 'S') {
    if (key == 's' || key == 'S') {
    minisAppear = !minisAppear;
    minis2Appear = !minis2Appear;
    }
  }
  
  // === GRADIENT MODÜLÜ: keyPressed ekleri ===
if (key == 'g' || key == 'G') {
  showGradient = !showGradient;
}

}

  //void mousePressed(){  image(tongue, width/2, 2*height/3, 300, 300);}

 void mouseDragged(){ 
 image(tongue, mouseX, mouseY, 300, 300);
 
 }


// linear gradient
void setGradient(int x, int y, int w, int h, color c1, color c2) {
  noFill();
  int yEnd = y + h - 1;
  int xEnd = x + w - 1;
  int step = 5;            // <— satır aralığı (2 hızlı, 3 daha da hızlı)
  strokeWeight(step);      // <— boşlukları kapat
  for (int i = y; i <= yEnd; i += step) {
    float inter = map(i, y, yEnd, 0, 1);
    stroke(lerpColor(c1, c2, inter));
    line(x, i, xEnd, i);
  }
  strokeWeight(1);         // geri al
}

// horizontal gradient (sol → sağ) + KAYDIRMA (offset: 0..1, sağa doğru)
void setGradientHOffset(int x, int y, int w, int h, color c1, color c2, float offset) {
  noFill();
  int xEnd = x + w - 1;
  int yEnd = y + h - 1;
  int step = 2;
  strokeWeight(step);
  for (int j = x; j <= xEnd; j += step) {
    float u = ((j - x) / float(w - 1)) + offset;
     u = abs((u % 2.0) - 1.0);  // üçgen dalga gibi: 0→1→0→1
     float t = u;
    
    stroke(lerpColor(c1, c2, t));
    line(j, y, j, yEnd);
  }
  strokeWeight(1);
}


///g appaear gradient
void drawGradient(float x, float y, float hStart) {
  pushStyle();
  colorMode(HSB, 360, 100, 100);
  ellipseMode(RADIUS);
  noStroke();

  int radius = dim / 4;
  float h = hStart;
  for (int r = radius; r > 0; r -= R_STEP) {
    fill(h, SAT, BRI);
    ellipse(x, y, r, r);
    h += HUE_STEP;
    if (h > HUE_MAX)      h = HUE_MIN + (h - HUE_MAX);
    else if (h < HUE_MIN) h = HUE_MAX - (HUE_MIN - h);
  }
  popStyle();
}

void setEllipseGradient(int x, int y, int w, int h, color c1, color c2) {
  noStroke();
  for (float f = 1; f >= 0; f -= 0.01) {
    color c = lerpColor(c1, c2, f);
    fill(c);
    ellipse(x, y, w*f, h*f);
  }
}
