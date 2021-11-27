//mod player demo 

import procmod.*;


ModPlayer hello;
int bgcolor = 0;

void setup() {
  background(bgcolor);
  
  hello = new ModPlayer(this, "space_debris.mod");
  hello.play();
}

void draw() {
  background(bgcolor);
  fill(255);
}

void modRowEvent( int channel, int instrument, int note )
{
  if (channel == 0)
  {
    println(channel +":"+ instrument +":"+ note);
    bgcolor = note;
  }
}
