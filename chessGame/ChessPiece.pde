class ChessPiece {
  // pawn, knight, bishop, rook, queen, king

  String type;
  PImage p;
  Boolean isBlack;

  ChessPiece(String type, Boolean isBlack) {
    //chess piece images from wikipedia
    this.type = type;
    this.isBlack = isBlack;
    if (isBlack) {
      p = loadImage("black"+type+".png");
    } 
    else {
      p = loadImage("white"+type+".png");
    }
  }

  //moves the selected piece to a new position on the board
  void moveTo(int fromX, int fromY, int toX, int toY) {
    b.setPosition(fromX, fromY, toX, toY, this);
  }

  //draws the representation of the piece to the screen
  void drawPiece(int xpos, int ypos, boolean isGraphical) {
    if (isGraphical) {
      //draw graphical version
      imageMode(CENTER);
      image(p, (SQUARESIZE/2)+(xpos*SQUARESIZE), (SQUARESIZE/2)+(ypos*SQUARESIZE));
    } 
    else if (!isGraphical) {
      //draw textual version
      textAlign(CENTER);
      if (isBlack) {
        fill(0);
      } 
      else {
        fill(150);
      }
      text(type, (SQUARESIZE/2)+(xpos*SQUARESIZE), (SQUARESIZE/2)+(ypos*SQUARESIZE));
    }
  }

  PImage getImage() {
    return this.p;
  }

  String getType() {
    return this.type;
  }

  Boolean getColour() {
    return this.isBlack;
  }
}

