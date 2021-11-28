import procmod.*;

//  define a new instance of the ModPlayer
ModPlayer mplayer;
//  we'll use this to draw a background color
int bgcolor = 0;
int globalNote, globalChannel, globalInstrument;
int songNumber;
boolean playing;
String Song = "";
File dir;
ModPlayer songList[];
boolean selecting = true;


void setup() {
  songNumber = 0;
  playing = false;
  songList = new ModPlayer[1];
  size(200,200);
  frameRate(1);
  background(bgcolor);
  //  Load the supplied test.mod file
  
  for (int i = 0; i<1; i++){ 
  selectInput("Select a file to process:", "fileSelected");
      songList[i] = new ModPlayer(this, '"' + Song +'"');
  }
  songList[songNumber].play();
}


void fileSelected(File selection) {

  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    Song = selection.getPath();
    print(Song);
    
  
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
  if (key == 'v') {
    if (songNumber<songList.length){
          println("next song: "+ songNumber);
    songNumber +=1;
    }
  }
  if (key == 'z') {
    if (songNumber>1) {
    songNumber -=1;
    println("previous song: " + songNumber);
    }
  }
  if (key== 'c') {
    if (playing) {
        songList[0].pause(); // pauses when x is pressed (toggles)
    }
}
  if (key== 'x') {
    playing = !playing;//when z is pressed, switches playing state
    if (playing) {
        songList[0].play(); // if playing is true, play song
    }
    if(!playing) {
      songList[0].stop();//if playing is false, stop song

    }

  }


}
