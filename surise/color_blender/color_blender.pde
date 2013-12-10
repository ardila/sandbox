import java.awt.*;
//First 3 are rgb for base color, next 3 for mixin color
int[] colorSettings = {248, 226, 239, 220, 244, 254};

//This is the color of the paper
color water = color(255, 255, 255);
color currentColor = water;
//If this is set to false, blending pauses and the current rgb is shown
boolean blending = true;
//This enables text fields that set the coors you are mixing
boolean fieldsShowing = false;

TextField[] colorFields = new TextField[6];





void setup() {
  size(512, 512);
}

void draw() {
  color color1 = color(colorSettings[0],colorSettings[1],colorSettings[2]);
  color color2 = color(colorSettings[3],colorSettings[4],colorSettings[5]);

  background(currentColor);
  if(blending){
    float relativeY = map(mouseY, 0, height, 0, 1);
    float relativeX = map(mouseX, 0, height, 0, 1);
    color blend_2 = lerpColor(color1, color2, relativeX);
    color blend_all = lerpColor(blend_2, water,  relativeY);
    currentColor = blend_all;
  }
  if(!blending){
    textAlign(CENTER);
    textSize(height/10);
    //PFont gillSans = loadFont("GillSansMT-32.vlw");
    //textFont(gillSans);
    fill(invert(currentColor));
    text(displayText(currentColor), height/2, width/2);
 
  }
  
  
}



void keyPressed(){
  if (key==10){
      fieldsShowing = !fieldsShowing;
      for(int i=0; i<6; i=i+1){
        if(fieldsShowing){
          TextField f =  new TextField(str(colorSettings[i]), 3);
          colorFields[i] =f;
          add(f);
        }
        else{
          colorSettings[i] = int(colorFields[i].getText());
          remove(colorFields[i]);
        }
      }        
  }

  if (key==' '){    
    updateBaseColor(currentColor);
  }
  if (key=='r'){
    updateMixinColor(color(255,0,0));
  }
  if (key=='g'){
    updateMixinColor(color(0,255,0));
  }
  if (key=='b'){
    updateMixinColor(color(0,0,255));
  }
  if (key=='y'){
    updateMixinColor(color(255,255,0));
  }
  if (key=='m'){
    updateMixinColor(color(255,0,255));
  }
  if (key=='c'){
    updateMixinColor(color(0,255,255));
  }
  if (key=='p'){
    blending=!blending;
  }
  
  
}

void updateBaseColor(color c){  
  colorSettings[0] = int(red(c));
  colorSettings[1] = int(green(c));
  colorSettings[2] = int(blue(c));
  updateFields();
}
void updateMixinColor(color c){  
  colorSettings[3] = int(red(c));
  colorSettings[4] = int(green(c));
  colorSettings[5] = int(blue(c));
  updateFields();
}
void updateFields(){
  if(fieldsShowing){
    for(int i=0; i<6; i=i+1){
      colorFields[i].setText(str(colorSettings[i]));
    }
  }
}

String displayText(color currentColor){
    String red_val= str(int(red(currentColor)));
    String green_val = str(int(green(currentColor)));
    String blue_val = str(int(blue(currentColor)));
    String display = red_val+", "+green_val+", "+blue_val;
    return display;
}

color invert(color original){
  color new_color = color(255-red(original), 255-green(original), 255-blue(original));
  return new_color;
}
