import procmod.*;

//TRY MAKING THE ARRAY OF SONG NAME STRINGS INSTEAD OF ARRAY OF MODPLAYER OBJECTS

//  define a new instance of the ModPlayer
//  we'll use this to draw a background color
int bgcolor = 0;
int globalNote, globalChannel, globalInstrument;

ModPlayer tester;



void setup() {

    size(200,200);
  frameRate(1);
  background(bgcolor);
  


  selectInput("Select a file to process:", "fileSelected");


}


void fileSelected(File selection) {

  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    
  } else {
    println("User selected " + selection.getAbsolutePath());

    tester = new ModPlayer(this, selection.getName());
    tester.play();
  }
}

void draw() {
//tester.play();
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

  if (key == ' ') {
    tester.stop();
    selectInput("Select a file to process:", "fileSelected");
  }

  if (key== 'c') {
        tester.pause(); // pauses when x is pressed (toggles)
}
  if (key== 'x') {
tester.stop();
    } 
    if (key== 'z') {
tester.play();
    }

}
