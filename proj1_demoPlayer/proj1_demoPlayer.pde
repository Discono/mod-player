import procmod.*;

//  define a new instance of the ModPlayer
ModPlayer mplayer;
//  we'll use this to draw a background color
int bgcolor = 0;
int globalNote, globalChannel, globalInstrument;
boolean playing;
String Song = "";
File dir;
String songList[];
boolean selecting = true;


void setup() {
  playing = false;
  songList = new String[10];
  size(200,200);
  frameRate(1);
  background(bgcolor);
  //  Load the supplied test.mod file
  
  for (int i = 0; i<10; i++){ 
  selectInput("Select a file to process:", "fileSelected");
  }
}

void folderSelected(File selection) {

  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    Song = selection.getPath();
    dir = selection;
    
  
  }
}

void fileSelected(File selection) {

  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    Song = selection.getPath();
    mplayer = new ModPlayer(this, Song);
    
  
  }
}

void draw() {
  background(bgcolor);
  fill(255);
  text(globalChannel +":"+ globalInstrument +":"+ globalNote, 40, 180);

}
//  This method is called every time an instrument is being played. 
//  Note: It is also called when no instrument is being called on a channel
//  the instrument number will be 0 then.
void modRowEvent( int channel, int instrument, int note ) {
  globalNote = note;
  globalInstrument = instrument;
  globalChannel = channel;
  
  //  We will only respond to channel 0 (a MOD file usually only has 4 channels)
  if (channel == 0)  {
    print(channel +":"+ instrument +":"+ note+ "\t");
    //  Whatever instrument is being played just set a background color from the note played.
    bgcolor = note * 3;
  }
    if (channel == 1)  {
    print(channel +":"+ instrument +":"+ note+ "\t");
    //  Whatever instrument is being played just set a background color from the note played.
    bgcolor = note * 3;
  }
    if (channel == 2)  {
    print(channel +":"+ instrument +":"+ note+ "\t");
    //  Whatever instrument is being played just set a background color from the note played.
    bgcolor = note * 3;
  }
    if (channel == 3)  {
    println(channel +":"+ instrument +":"+ note+ "\t");
    //  Whatever instrument is being played just set a background color from the note played.
    bgcolor = note * 3;
  }
  
}

void keyPressed() {
  if (key== 'x') {
        mplayer.pause(); // pauses when x is pressed (toggles)
  }
  if (key== 'z') {
    playing =!playing;//when z is pressed, switches playing state
    if (playing) {
        mplayer.play(); // if playing is true, play song
    }
    else {
      mplayer.stop();//if playing is false, stop song

    }

  }
      if (key == 'n') {
      playing=false;
      mplayer.stop();// if n is pressed, stop song and change playing state to false
      selectInput("Select a file to process:", "fileSelected");
         mplayer = new ModPlayer(this, Song);

    }
    if (key == 's') {
     selecting = false; 
    }
}
