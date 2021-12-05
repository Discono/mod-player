import procmod.*;




//  define a new instance of the ModPlayer
//  we'll use this to draw a background color

int bgcolor = 0;
int globalNote, globalChannel, globalInstrument, globalPattern, globalPosition;
boolean selecting;
String CurrentSong;
ModPlayer currentSong;

void setup() {
 selecting = true;
    size(400,400);
  frameRate(1);
  background(bgcolor);





  selectInput("Select a file to process:", "fileSelected");
 
  
}




void fileSelected(File selection) {

  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    
  } else {
    println("User selected " + selection.getAbsolutePath());

    currentSong = new ModPlayer(this, selection.getName());
    currentSong.play();
    selecting = false;
    CurrentSong = selection.getName();
  }
}

void draw() {
  if (!selecting) {
 
  background(bgcolor,0,0);
  fill(255);

    
    text(CurrentSong, 100,100);
  text(globalChannel +":"+ globalInstrument +":"+ globalNote, 40, 180);
  text(globalPattern +":" + globalPosition,40,200);
}
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

  }
    if (channel == 1)  {
    print(channel +":"+ instrument +":"+ note+ "\t");
    //  Whatever instrument is being played just set a background color from the note played.

  }
    if (channel == 2)  {
    print(channel +":"+ instrument +":"+ note+ "\t");
    //  Whatever instrument is being played just set a background color from the note played.

  }
    if (channel == 3)  {
    println(channel +":"+ instrument +":"+ note+ "\t");
    //  Whatever instrument is being played just set a background color from the note played.

  }

  
}
//modPatternEvent is called whenever a new pattern is played.
void modPatternEvent( int pattern, int position) {
      //println(pattern + ", " + position);
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

        currentSong.pause(); // pauses when c is pressed
}
  if (key== 'x') {
currentSong.stop();  //stops when x is pressed
    }
        
    if (key== 'z') {
currentSong.play();
    }

}

