import procmod.*;

//TRY MAKING THE ARRAY OF SONG NAME STRINGS INSTEAD OF ARRAY OF MODPLAYER OBJECTS

//  define a new instance of the ModPlayer
//  we'll use this to draw a background color
int bgcolor = 0;
int globalNote, globalChannel, globalInstrument;
int songNumber;
boolean playing; 
String Song ="";
String[] SongListing;
ModPlayer tester;
ModPlayer[] songList;
ModPlayer songSelected;
boolean selecting = true;


void setup() {
  songNumber = 0;
  playing = false;
  songList = new ModPlayer[2];
  tester = new ModPlayer(this, "h{");
  println(this);
  SongListing = new String[2];
  size(200,200);
  frameRate(1);
  background(bgcolor);
  //  Load the supplied test.mod file
  

    //for (ModPlayer mod : songList){ 
  selectInput("Select a file to process:", "fileSelected");

  //tester = new ModPlayer(this,SongListing[songNumber]);
}


void fileSelected(File selection) {

  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    //tester = new ModPlayer(this selection.getName());
    tester = new ModPlayer(this, selection.getName());
    tester.play();
    
    //songList[songNumber] = new ModPlayer(this, '"' + Song +'"');
    //print( Song);
    
  
  }
}

void draw() {
//tester.play();
  background(bgcolor);
  fill(255);
  text(globalChannel +":"+ globalInstrument +":"+ globalNote, 40, 180);
//println(songList[0]);
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
        tester.play();
    if (songNumber<songList.length-1){
          println("next song: "+ songNumber);
    songNumber +=1;
    }

}
  if (key == ' ') {
    tester.stop();
    selectInput("Select a file to process:", "fileSelected");
    
//songSelected = new ModPlayer(this, SongListing[songNumber]);
//println(SongListing[songNumber]+ "iiiiiiiii");
//songSelected.play();
//println("play"+songNumber);
  }
  if (key == 'z') {
    if (songNumber>0) {
    songNumber -=1;
    println("previous song: " + songNumber);
    }
  }
  if (key== 'c') {
    if (playing) {
      
        songList[songNumber].pause(); // pauses when x is pressed (toggles)
    }
}
  if (key== 'x') {
    playing = !playing;//when z is pressed, switches playing state
    if (playing) {
        songList[songNumber].play(); // if playing is true, play song
        println(songList[songNumber]);
    }
    if(!playing) {
   //.stop();//if playing is false, stop song

    }

  }


}
