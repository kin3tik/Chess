color gray = (100);
color white = (255);
color highlight = color(0, 200, 255);

class ChessBoard {
  ChessPiece[][] board;
  String[] inputLines;

  ChessBoard() {
    //if no file has been selected to load, set up board normally
    setUpBoard(fileName);
  }

  void setUpBoard(String fileName) {
    if (fileName != null) {
      //load user file
      inputLines = loadStrings(fileName);
      board = new ChessPiece[8][8];

      for (int row = 0; row < 8; row++) {
        String temp = inputLines[row];
        for (int col = 0; col < 8; col++) {
          switch(temp.charAt(col)) {
          case '0': //empty square
            break;
          case 'P':
            board[col][row] = new ChessPiece("pawn", true);
            break;
          case 'N':
            board[col][row] = new ChessPiece("knight", true);
            break;
          case 'B':
            board[col][row] = new ChessPiece("bishop", true);
            break;
          case 'R':
            board[col][row] = new ChessPiece("rook", true);
            break;
          case 'Q':
            board[col][row] = new ChessPiece("queen", true);
            break;  
          case 'K':
            board[col][row] = new ChessPiece("king", true);
            break; 
          case 'p':
            board[col][row] = new ChessPiece("pawn", false);
            break;
          case 'n':
            board[col][row] = new ChessPiece("knight", false);
            break;
          case 'b':
            board[col][row] = new ChessPiece("bishop", false);
            break;
          case 'r':
            board[col][row] = new ChessPiece("rook", false);
            break;
          case 'q':
            board[col][row] = new ChessPiece("queen", false);
            break;  
          case 'k':
            board[col][row] = new ChessPiece("king", false);
            break;
          }
        }
      }
    } 
    else {
      //load regular board
      board = new ChessPiece[8][8];
      //black team
      board[0][0] = new ChessPiece("rook", true);
      board[1][0] = new ChessPiece("knight", true);
      board[2][0] = new ChessPiece("bishop", true);
      board[3][0] = new ChessPiece("queen", true);
      board[4][0] = new ChessPiece("king", true);
      board[5][0] = new ChessPiece("bishop", true);
      board[6][0] = new ChessPiece("knight", true);
      board[7][0] = new ChessPiece("rook", true);
      board[0][1] = new ChessPiece("pawn", true);
      board[1][1] = new ChessPiece("pawn", true);
      board[2][1] = new ChessPiece("pawn", true);
      board[3][1] = new ChessPiece("pawn", true);
      board[4][1] = new ChessPiece("pawn", true);
      board[5][1] = new ChessPiece("pawn", true);
      board[6][1] = new ChessPiece("pawn", true);
      board[7][1] = new ChessPiece("pawn", true);
      //white team
      board[0][7] = new ChessPiece("rook", false);
      board[1][7] = new ChessPiece("knight", false);
      board[2][7] = new ChessPiece("bishop", false);
      board[3][7] = new ChessPiece("queen", false);
      board[4][7] = new ChessPiece("king", false);
      board[5][7] = new ChessPiece("bishop", false);
      board[6][7] = new ChessPiece("knight", false);
      board[7][7] = new ChessPiece("rook", false);
      board[0][6] = new ChessPiece("pawn", false);
      board[1][6] = new ChessPiece("pawn", false);
      board[2][6] = new ChessPiece("pawn", false);
      board[3][6] = new ChessPiece("pawn", false);
      board[4][6] = new ChessPiece("pawn", false);
      board[5][6] = new ChessPiece("pawn", false);
      board[6][6] = new ChessPiece("pawn", false);
      board[7][6] = new ChessPiece("pawn", false);
    }
  }

  //takes current board layout and saves it to a file specified by user
  void saveBoard(String fileName) {
    String tempLine = "";
    String[] boardLayout = new String[8];

    for (int row = 0; row < 8; row++) {
      for (int col = 0; col < 8; col++) {
        if (board[col][row] != null) {
          char pieceType = board[col][row].getType().charAt(2); //using a dirty hack to get around not using strings for switch cases. finite different pieces so works here
          boolean isBlack = board[col][row].getColour();
          switch(pieceType) {
          case 'w': //pawn
            tempLine += (isBlack) ?  'P' : 'p'; // if the piece colour is black, add 'P' to tempLine, otherwise add 'p'
            break;
          case 'i': //knight
            tempLine += (isBlack) ?  'N' : 'n';
            break;
          case 's': //bishop
            tempLine += (isBlack) ?  'B' : 'b';
            break;
          case 'o': //rook
            tempLine += (isBlack) ?  'R' : 'r';
            break;
          case 'e': //queen
            tempLine += (isBlack) ?  'Q' : 'q';
            break;
          case 'n': //king
            tempLine += (isBlack) ?  'K' : 'k';
            break;
          }
        } 
        else {
          //space is empty, make it 0
          tempLine += '0';
        }
      }
      boardLayout[row] = tempLine;
      tempLine = ""; //reset after each row
    }
    //save the board layout to a text file
    saveStrings(fileName, boardLayout);
  }

  //draws the chess board itself to the screen
  void drawBoard() {
    //creates the board squares in the correct setup
    boolean isBlack = false;
    noStroke();
    for (int x = 0; x<(8*SQUARESIZE); x+=SQUARESIZE) {
      for (int y = 0; y<(8*SQUARESIZE); y+=SQUARESIZE) {
        if (isBlack) {
          fill(gray);
          rect(x, y, SQUARESIZE, SQUARESIZE);
          isBlack = false;
        } 
        else {
          fill(white);
          rect(x, y, SQUARESIZE, SQUARESIZE);
          isBlack = true;
        }
      }
      isBlack = !isBlack;
    }
  }

  //get piece at [x][y] in board
  ChessPiece selectPiece(int x, int y) {
    ChessPiece temp = board[x][y];
    board[x][y] = null;
    return temp;
  }

  //indicate the selected pieces' original square by highlighting it
  void drawSelected(int x, int y) {
    if (squareSelected) {
      highlightSquare(x, y);
    }
  }

  //draws the selected piece at the mouse coordinates, movement animation
  void drawPieceSelected(ChessPiece p, boolean isGraphical) {
    if (isGraphical) {
      PImage pic = p.getImage();
      image(pic, mouseX, mouseY);
    } 
    else {
      String name = p.getType();
      if (p.getColour()) {
        fill(0);
      } 
      else {
        fill(150);
      }
      text(name, mouseX, mouseY);
    }
  }

  //method used by drawSelected() to highlight square
  void highlightSquare(int x, int y) {
    fill(highlight);
    rect(x*SQUARESIZE, y*SQUARESIZE, SQUARESIZE, SQUARESIZE);
  }

  //sets highlighted square back to original colour after piece has been moved
  void unhighlightSquare(int x, int y) {
    //check if even or odd
    int remX = x%2;
    int remY = y%2;
    if ((remX == 0 && remY == 0) || (remX == 1 && remY == 1)) {
      //square should be white
      fill(white);
      rect(x*SQUARESIZE, y*SQUARESIZE, SQUARESIZE, SQUARESIZE);
    } 
    else {
      //square should be black
      fill(gray);
      rect(x*SQUARESIZE, y*SQUARESIZE, SQUARESIZE, SQUARESIZE);
    }
  }

  //used to draw representations of all pieces to the screen  
  void drawPieces(boolean isGraphical) {
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (board[i][j] != null) {
          board[i][j].drawPiece(i, j, isGraphical);
        }
      }
    }
  }

  ChessPiece getPiece(int x, int y) {
    return board[x][y];
  }

  void setPosition(int fromX, int fromY, int toX, int toY, ChessPiece p) {
    //replace the captured piece with the new one
    if (p != null) {
      //msg to user to inform them what unit was captured
      if (board[toX][toY] != null)
        println(board[toX][toY].getType()+" was captured.");
      board[toX][toY] = p;
    }
  }
}

