import procmod.*;


//  define a new instance of the ModPlayer
ModPlayer mplayer;
//  we'll use this to draw a background color
int bgcolor = 0;
int globalNote, globalChannel, globalInstrument;
boolean playing;

void setup() {
mplayer.createNewMixer();
  
  playing = false;
  size(200,200);
  frameRate(1);
  background(bgcolor);
  //  Load the supplied test.mod file
  mplayer = new ModPlayer(this, "space_debris.mod");
  //  play it rightaway

        mplayer.play(); 
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
        mplayer.pause(); 
  }
  if (key== 'z') {
    playing =!playing;
    if (playing) {
        mplayer.stop(); 
    }
    else {
      mplayer.play();

    }
  }
}

