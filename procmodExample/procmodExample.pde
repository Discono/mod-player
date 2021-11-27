import procmod.*;

//  define a new instance of the ModPlayer
ModPlayer mplayer;
//  we'll use this to draw a background color
int bgcolor = 0;

void setup() {
  size(200,200);
  background(bgcolor);
  //  Load the supplied test.mod file
  mplayer = new ModPlayer(this, "test.mod");
  //  play it rightaway
  mplayer.play();
}

void draw() {
  background(bgcolor);
  fill(255);
  text("Helloow", 40, 180);
}

//  This method is called every time an instrument is being played. 
//  Note: It is also called when no instrument is being called on a channel
//  the instrument number will be 0 then.
void modRowEvent( int channel, int instrument, int note )
{
  //  We will only respond to channel 0 (a MOD file usually only has 4 channels)
  if (channel == 0)
  {
    println(channel +":"+ instrument +":"+ note);
    //  Whatever instrument is being played just set a background color from the note played.
    bgcolor = note * 3;
  }
}
