import procmod.*;




//  define a new instance of the ModPlayer
//  we'll use this to draw a background color

int bgcolor = 0;
int globalNote, globalChannel, globalInstrument, globalPattern, globalPosition;
boolean selecting, playing;
String CurrentSong;
String Status;
ModPlayer currentSong;

void setup() {
  selecting = true;
  playing = false;
  size(400, 400);
  frameRate(1);
  textSize(40);
  background(bgcolor);
  Status = "";




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

    background(bgcolor, 0, 0);
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

  }
  if (channel == 1) {
    print(channel +":"+ instrument +":"+ note+ "\t");

  }
  if (channel == 2) {
    print(channel +":"+ instrument +":"+ note+ "\t");

  }
  if (channel == 3) {
    println(channel +":"+ instrument +":"+ note+ "\t");

  }
}
//modPatternEvent is called whenever a new pattern is played.
void modPatternEvent( int pattern, int position) {

  globalPattern = pattern;
  globalPosition = position;
  bgcolor = pattern+position * 20;
  if (bgcolor >255) {
    bgcolor = 255;
  }
  println("Current Pattern: " + pattern + "\t" + "Current Position: " + position);
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
