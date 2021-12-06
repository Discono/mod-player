import procmod.*;




//  define a new instance of the ModPlayer
//  we'll use this to draw a background color
int bgcolorNum = 0;
color bgcolor = #000000;
int channel0BG, channel1BG, channel2BG, channel3BG;
int globalNote, globalChannel, globalInstrument, globalPattern, globalPosition;
boolean selecting, playing;
String CurrentSong;
String Status;
ModPlayer currentSong;

void setup() {
  selecting = true;
  playing = false;
  size(400, 400);
  frameRate(60);
  textSize(40);
  background(bgcolor);
  Status = "";
  channel0BG = 0;
  channel1BG = 0;
  channel2BG = 0;
  channel3BG = 0;



  selectInput("Select a file to process:", "fileSelected");
}




void fileSelected(File selection) {

  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } 
  else {
    println("User selected " + selection.getAbsolutePath());

    currentSong = new ModPlayer(this, selection.getName());
    currentSong.play();
    Status = "Playing";
    selecting = false;
    playing = true;
    CurrentSong = selection.getName();
  }
}

void draw() {
  if (!selecting) {

    background(bgcolor);
    fill(channel0BG,0,0);
    rect(width/8*1,0,30,channel0BG);
    fill(0,channel1BG,0);
    rect(width/8*3,0,30,channel1BG);
    fill(0,0,channel2BG);
    rect(width/8*5,0,30,channel2BG);
    fill(channel3BG);
    rect(width/8*7,0, 30,channel3BG);
    
    fill(255);
    

    text(CurrentSong, 40, 100);
    text(globalChannel +":"+ globalInstrument +":"+ globalNote, 40, 180);
    text(globalPattern +":" + globalPosition, 40, 220);
    text(Status, 40, 300);
  }
}

//  This method is called every time an instrument is being played. 
//  Note: It is also called when no instrument is being called on a channel
//  the instrument number will be 0 then.


void modRowEvent( int channel, int instrument, int note ) {
  globalNote = note;
  globalInstrument = instrument;
  globalChannel = channel;


  if (channel == 0) {
    print(channel +":"+ instrument +":"+ note+ "\t");
    channel0BG = bgChange(channel, note, channel0BG);
  }
  if (channel == 1) {
    print(channel +":"+ instrument +":"+ note+ "\t");
    channel1BG = bgChange(channel, note, channel1BG);
  }
  if (channel == 2) {
    print(channel +":"+ instrument +":"+ note+ "\t");
    channel2BG = bgChange(channel, note, channel2BG);
  }
  if (channel == 3) {
    print(channel +":"+ instrument +":"+ note+ "\t");
    channel3BG = bgChange(channel, note, channel3BG);
  }
}

int bgChange(int currentChannel, int currentNote, int currentBG) {
  int newBG = currentBG;
    if (currentNote == 0) {
    newBG = currentBG-5;
    if (newBG <0) {
     newBG = 0; 
    }
  }
  else { 
    newBG = currentBG + 10;

    if (newBG > 255) {
     newBG = 255; 
    }
  }
      println("changed: "+currentChannel +"to: " + newBG);
      if (currentChannel ==3) {
        println("\n");
      }
  return newBG;
}

//modPatternEvent is called whenever a new pattern is played.
void modPatternEvent( int pattern, int position) {

  globalPattern = pattern;
  globalPosition = position;
  bgcolorNum = pattern+position;
  if (bgcolorNum % 3 == 0) {
    bgcolor = #FF0000;
  }
  else if(bgcolorNum % 3 ==1) {
    bgcolor = #00FF00;
  }
    else if(bgcolorNum % 3 ==2) {
    bgcolor = #0000FF;
  }
  println("Current Pattern: " + pattern + "\t" + "Current Position: " + position + "\n");
}


void keyPressed() {

  if (key == ' ') { //when space is pressed, 
    currentSong.stop();  //stops currently playing song
    selectInput("Select a file to process:", "fileSelected");  //loads new song
  }

  if (key== 'c') {
    if (Status == "Playing") {
      Status = "Paused";
    } 
    else if (Status == "Paused") {
      Status = "Playing";
    }
    currentSong.pause(); // pauses when c is pressed
  }
  if (key== 'x') {

    currentSong.stop();  //stops when x is pressed
    Status = "Stopped";
    playing = false;
  }

  if (key== 'z') {
    if (!playing) {
      currentSong.play();
      Status = "Playing";
      playing = true;
    }
  }
}
