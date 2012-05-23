// can change scale size to effectively 'zoom' the board
float SCALESIZE = 1;
int SQUARESIZE = (int)(SCALESIZE*60);
int lastPosX = 0, lastPosY = 0;
ChessBoard b;
boolean squareSelected, pieceSelectedBool, fileWait, isLoad, isGraphical = true;
ChessPiece pieceSelected;
String fileName;
String typing = "";
PFont f;

void setup () {
  size(8*SQUARESIZE, 8*SQUARESIZE);
  f = createFont("Arial", 16, true);
  b = new ChessBoard();
}

void draw() {
  //pieces will be displayed graphically or textually depending on user selection
  scale(SCALESIZE);
  b.drawBoard(); //draws board squares
  b.drawSelected(lastPosX, lastPosY); //draw the selected board square
  b.drawPieces(isGraphical); //draw the chess pieces either graphically or textually
  if (pieceSelectedBool) {
    b.drawPieceSelected(pieceSelected, isGraphical);
  } //draw selected chess piece following mouse
  if (fileWait) {
    drawTextBox(); //draw file load/save dialog
    drawText(isLoad);
  }
}

//draws the text box under which the save/load text is displayed on 
void drawTextBox() {
  stroke(0);
  fill(150);
  rect(1*SQUARESIZE, 3.5*SQUARESIZE, 6*SQUARESIZE, SQUARESIZE);
}

//draws save/load dialog text to alert the user
void drawText(boolean isLoad) {
  fill(255);
  textAlign(LEFT, CENTER);
  if (isLoad) {
    text("Name of file to load:", 1.5*SQUARESIZE, 4*SQUARESIZE);
  } 
  else {
    text("Name of file to save:", 1.5*SQUARESIZE, 4*SQUARESIZE);
  }
  text(typing, 4*SQUARESIZE, 4*SQUARESIZE);
}

void mousePressed() {
  int newPosX, newPosY;
  //find square mouse clicked on
  newPosX = mouseX/SQUARESIZE;
  newPosY = mouseY/SQUARESIZE;

  if (!squareSelected) {
    //if a piece/square is not currently chosen, select the one clicked on
    if (b.getPiece(newPosX, newPosY) != null) {
      pieceSelected = b.selectPiece(newPosX, newPosY);
      pieceSelectedBool = true;
      squareSelected = true;
      lastPosX = newPosX;
      lastPosY = newPosY;
    }
  } 
  else {
    //after a piece to move has been selected, move peice to new square selected
    pieceSelected.moveTo(lastPosX, lastPosY, newPosX, newPosY);
    b.unhighlightSquare(lastPosX, lastPosY);
    pieceSelectedBool = false;
    squareSelected = false;
  }
}

void keyPressed() {
  if (key == BACKSPACE && fileWait && typing.length() != 0) {   //allows user to backspace and fix typing errors
    typing = typing.substring(0, typing.length()-1);
  } 
  else if (fileWait) {
    typing += key;
  } 
  else if (key == 'l') {  //if l is pressed, ask the user what file to load
    typing = "";
    fileWait = true;
    isLoad = true;
  } 
  else if (key == 's') { //if s is pressed, ask the user what to save the file as
    typing = "";
    fileWait = true;
    isLoad = false;
  } 
  else if (key == '1' && !fileWait) {  //allows user to switch between display modes
    isGraphical = true;
  } 
  else if (key == '2' && !fileWait) {
    isGraphical = false;
  }

  //takes the string entered and uses it as a filename to load a new board
  if (key == '\n' && fileWait && isLoad) {
    String fileFinal = typing.substring(0, typing.length()-1); //length-1 to remove \n character
    File f = new File(sketchPath(fileFinal));

    //makes sure file exists before trying to process it
    if (f.exists()) {
      b.setUpBoard(fileFinal); //loads fileFinal
      typing = "";
      fileWait = false;
    } 
    else {
      print("\nFile doesn't exist");
      typing = typing.substring(0, typing.length()-1);
    }
  } 
  else if (key == '\n' && fileWait && !isLoad) { //save a board layout
    String fileFinal = typing.substring(0, typing.length()-1);
    b.saveBoard(fileFinal);
    fileWait = false;
  }
}

