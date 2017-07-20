import processing.sound.*;

//pad(Number of sines, frequency, attack time, sustain time, sustain level, release time, parent)
pad p1 = new pad(1, 150, 0.001, 0.04, 0.3, 1.5, this);
pad p2 = new pad(1, 100, 0.001, 0.04, 0.3, 1.5, this);
pad p3 = new pad(1, 200, 0.001, 0.04, 0.3, 1.0, this);
pad p4 = new pad(1, 300, 0.001, 0.04, 0.3, 1.0, this);
void setup(){
  size(430, 430);
  background(255);
  
}

void draw(){
  fill(0, 200, 0);
  rect(10, 10, 200, 200, 5);
  rect(10, 220, 200, 200, 5);
  rect(220, 10, 200, 200, 5);
  rect(220, 220, 200, 200, 5); 
  
  
}

void mouseClicked(){
   if (mouseX < 210 && mouseX > 10 && mouseY < 210 && mouseY > 10){
     p1.play();
   }
   else if (mouseX < 210 && mouseX > 10 && mouseY < 420 && mouseY > 220){
     p2.play();
   }
   else if (mouseX < 420 && mouseX > 220 && mouseY < 210 && mouseY > 10){
     p3.play();
   }
   else if (mouseX < 420 && mouseX > 220 && mouseY < 420 && mouseY > 220){
     p4.play();
   }
}

class pad{
  SinOsc[] sineWaves;
  float[] sineFreq;
  Env env;
  int numSines;
  LowPass lowpass;
  
  float attackTime;
  float sustainTime;
  float sustainLevel;
  float releaseTime;
  float freq;
  
  pad (int numSines, float freq, float attackTime, float sustainTime, float sustainLevel, float releaseTime, PApplet parent){
    
    this.numSines = numSines;
    
    this.attackTime = attackTime;
    this.sustainTime = sustainTime;
    this.sustainLevel = sustainLevel;
    this.releaseTime = releaseTime;
    this.freq = freq;
  
    sineWaves = new SinOsc[numSines];
    sineFreq = new float[numSines];
    env = new Env(parent);
    lowpass = new LowPass(parent);
    
    for (int i = 0; i < numSines; i++){
      // Create the oscillators
      sineWaves[i] = new SinOsc(parent);
      // Calculate the amplitude for each oscillator
      float sineVolume = (1.0 / this.numSines) / (i + 1);
      // Set the amplitudes for all oscillators
      sineWaves[i].amp(sineVolume);
      float detune = 1;
      sineFreq[i] = freq * (i + 1 * detune);
      // Set the frequencies for all oscillators
      sineWaves[i].freq(sineFreq[i]);
    }
  }
  
  void play(){
    for (int i = 0; i < this.numSines; i++){
      
      // Start Oscillators
      sineWaves[i].play();
      lowpass.process(sineWaves[i], 1000);
      env.play(sineWaves[i], attackTime, sustainTime, sustainLevel, releaseTime);
    }
  }
}
    