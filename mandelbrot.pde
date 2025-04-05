PShader shader;

float rate = 8;
float cx = 0;
float cy = 0;
ArrayList<String> keys;

void setup(){
  frameRate(144);
  size(1280,720,P3D);
  shader = loadShader("shader.glsl");
  shader.set("resolution",width,height);
  shader.set("n",1000);
  shader.set("treshold",1000000000.0f);
  keys = new ArrayList<>();
  drawFractal();
}

void draw(){
  if (keys.size()>0){
    for (String i : keys){
      if (i=="d"){
        cx += 1/(rate*4);
      }
      if (i=="a"){
        cx -= 1/(rate*4);
      }
      if (i=="w"){
        cy += 1/(rate*4);
      }
      if (i=="s"){
        cy -= 1/(rate*4);
      }
      if (i=="q"){
        rate -= rate/32.0;
      }
      if (i=="e"){
        rate += rate/32.0;
      }
    }
    rate = max(1,rate);
    //println(rate);    
  }
  drawFractal();
  textSize(30);
  fill(255);
  text(String.format("FrameRate: %.0f",frameRate),10,30);
}

void drawFractal(){
  background(0);
  shader.set("topLeft",cx-16/rate,cy-9/rate);  
  shader.set("bottomRight",cx+16/rate,cy+9/rate);
  println(cx,cy);
  //println(cx+16/rate,cy+9/rate);
  shader(shader);
  rect(0,0,width,height);
  resetShader();
}

void keyPressed(){
  if (key=='D' || key=='d'){
    keys.add("d");
  }
  if (key=='A' || key=='a'){
    keys.add("a");
  }
  if (key=='W' || key=='w'){
    keys.add("w");
  }
  if (key=='S' || key=='s'){
    keys.add("s");
  }
  if (key=='E' || key=='e'){
    keys.add("e");
  }
  if (key=='Q' || key=='q'){
    keys.add("q");
  }
}

void keyReleased(){
  if (key=='D' || key=='d'){
    keys.remove("d");
  }
  if (key=='A' || key=='a'){
    keys.remove("a");
  }
  if (key=='W' || key=='w'){
    keys.remove("w");
  }
  if (key=='S' || key=='s'){
    keys.remove("s");
  }
  if (key=='E' || key=='e'){
    keys.remove("e");
  }
  if (key=='Q' || key=='q'){
    keys.remove("q");
  }
}
