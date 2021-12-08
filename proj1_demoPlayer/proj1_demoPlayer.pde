import procmod.*; //imports the library


int bgcolor = 0; //  we'll use this to draw a background color
int channel0BG, channel1BG, channel2BG, channel3BG; //variables for the individual channel colors
int globalNote, globalChannel, globalInstrument, globalPattern, globalPosition;
boolean selecting, playing;
String CurrentSong;
String Status;
ModPlayer currentSong; //  define a new instance of the ModPlayer

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



  selectInput("Select a file to process:", "fileSelected"); //opens the file selection window, runs the given function.
}




void fileSelected(File selection) {

  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } 
  else {
    println("User selected " + selection.getAbsolutePath());

    currentSong = new ModPlayer(this, selection.getName()); // initializes the ModPlayer object with the selected song
    currentSong.play();//plays the song
    Status = "Playing";
    selecting = false;
    playing = true;
    CurrentSong = selection.getName();
  }
}

void draw() {
  if (!selecting) {
    fill(0);
    rect(0,0,width,255);
    background(bgcolor, 0, 0);
    fill(channel0BG,0,0);
    rect(0,0,width/4,channel0BG); //channel 0 visual 
    fill(0,channel1BG,0);
    rect(100,0,width/4,channel1BG);//channel 1 visual 
    fill(0,0,channel3BG);
    rect(200,0,width/4,channel2BG);//channel 2 visual 
    fill(channel3BG);
    rect(300,0,width/4,channel3BG);//channel 3 visual 
    
    fill(255);
    rect(0,height - 30, globalPosition*10, 30); //pattern visual 

    text(CurrentSong, 40, 100);
    text(globalInstrument +":"+ globalNote, 40, 180);
    text(globalPattern +":" + globalPosition, 40, 340);
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
  bgcolor = pattern+position * 20; //changes background color based on the current pattern 
  if (bgcolor >255) {
    bgcolor = 255;
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
      currentSong.play();//plays the song, if it is not already playing
      Status = "Playing";
      playing = true;
    }
  }
}
