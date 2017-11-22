


import java.util.ArrayList;
import java.util.HashMap;

public class Board {

  private Square[][] squares;
  private Player[] players;
  
  public Board(){
    this.squares = new Square[3][4];
    this.players = new Player[2];
    
    for(int i = 0;i<3;i++){
      for(int j = 0;j<4;j++){
        this.squares[i][j] = new Square(i,j);
      }
    }
    for(int i = 0;i<2;i++){
      this.players[i] = new Player();
    }
  }
  
  public Square getSquare(int x, int y){
    return this.squares[x][y];
  }
  
  public void tick(Move m){
    int dx = m.getDestinyX();
    int dy = m.getDestinyY();
    int ox = m.getOriginX();
    int oy = m.getOriginY();
    Player player = players[m.getPlayerId()-1];
    Piece piece;
    
    if(m.getType() == 'm'){
      piece = this.squares[ox][oy].removePiece();
      
      if(this.squares[dx][dy] != null){
        Piece removed = this.squares[dx][dy].removePiece();
        
        if(removed != null){
          if(removed.getName().equals("gal")){
            removed.setName("pin");
          }
        
          removed.setOwnerId(m.getPlayerId());
          removed.setX(-1);
          removed.setY(-1);
          player.addPiece(removed);
        }
      }
      
      if(piece.getName().equals("pin")){
        if(
          (dy == 0 && piece.getOwnerId() == 2) ||
          (dy == 3 && piece.getOwnerId() == 1) 
        ){
          piece.setName("gal");
        }
      }
    }
    else{
      piece = player.getPieceByName(m.getPieceName());
    }
    if(piece != null){
      this.squares[dx][dy].setPiece(piece);
    }
  }
  
  public int getOtherPlayerId(int i){
    if(i == 2){ return 1;}
    return 2;
  }
  
  public ArrayList<Move> getMoviments(int playerId){
    ArrayList<Move> moves = new ArrayList<Move>();
    Piece lion = findLion(playerId);
    
    ArrayList<Piece> myPieces = getPiecesOnBoard(playerId);
    int enemyId = getOtherPlayerId(playerId);
      
    ArrayList<Piece> enemyPieces = getPiecesOnBoard(enemyId);
    ArrayList<Piece> enemyAttackingPieces = getPiecesAttacking(lion);
    
    
    boolean[][] dangerMatrix = createDangerMatrix(enemyPieces);
      
      //if lion is beeing attacked
    if(enemyAttackingPieces.size()>0){
        for(Piece e:enemyAttackingPieces){
          for(Piece p:myPieces){
            int[][] pieceMoves = p.getMoveMatrix();
            for(int j = 0;j<pieceMoves.length;j++){
              int x = p.getX()+pieceMoves[j][0];
              int y = p.getY()+pieceMoves[j][1];
              
              if(x > -1 && x < 3 && y > -1 && y < 4){
                
                if(p.getName().equals("leo") && dangerMatrix[x][y] == false && x == e.getX() && y == e.getY()){
                  Move m = new Move(x,y,p.getX(),p.getY(),'m',playerId,"leo");
                  moves.add(m);
                }  
                else if(!p.getName().equals("leo") && x == e.getX() && y == e.getY()){
                  Move m = new Move(x,y,p.getX(),p.getY(),'m',playerId,p.getName());
                  moves.add(m);
                }
              }
            }
          }
        }
        
        int[][] pieceMoves = lion.getMoveMatrix();
        
        for(int j = 0;j<pieceMoves.length;j++){
          int x = lion.getX()+pieceMoves[j][0];
          int y = lion.getY()+pieceMoves[j][1];
          
          if(x > -1 && x < 3 && y > -1 && y < 4){
            Piece p = this.squares[x][y].getPiece();
            if(p != null && p.getOwnerId() != lion.getOwnerId() && dangerMatrix[x][y] ==false){
              Move m = new Move(x,y,lion.getX(),lion.getY(),'m',playerId,"leo");
              moves.add(m);
            }
            else if(p == null && dangerMatrix[x][y] ==false){
              Move m = new Move(x,y,lion.getX(),lion.getY(),'m',playerId,"leo");
              moves.add(m);
            }
          }
        }
      }
      else{
        if(this.players[playerId-1].getHand().size() > 0){
          for(Piece p:this.players[playerId-1].getHand()){
            ArrayList<Square> emptySquares = emptySquares();
            for(Square s:emptySquares){
              Move m = new Move(s.getX(),s.getY(),p.getX(),p.getY(),'c',playerId,p.getName());
              moves.add(m);
            }
          }
        }
        
        for(Piece p:myPieces){
          
          int[][] pieceMoves = p.getMoveMatrix();
          for(int j = 0;j<pieceMoves.length;j++){
            int x = p.getX()+pieceMoves[j][0];
            int y = p.getY()+pieceMoves[j][1];
            if(x > -1 && x < 3 && y > -1 && y < 4){
              Piece pd = this.squares[x][y].getPiece();
              if(p.getName().equals("leo")){
                if(dangerMatrix[x][y] == false && pd == null){
                  Move m = new Move(x,y,p.getX(),p.getY(),'m',playerId,p.getName());
                  moves.add(m);
                }
                else if(pd != null && pd.getOwnerId() != p.getOwnerId() && dangerMatrix[x][y] == false){
                  Move m = new Move(x,y,p.getX(),p.getY(),'m',playerId,p.getName());
                  moves.add(m);
                }
              }
              else if(pd == null){
                Move m = new Move(x,y,p.getX(),p.getY(),'m',playerId,p.getName());
                moves.add(m);
              }
              else if(pd != null && pd.getOwnerId() != playerId){
                Move m = new Move(x,y,p.getX(),p.getY(),'m',playerId,p.getName());
                moves.add(m);  
              }
            }
          }
        }
      }
      return moves;
  }
  
  public ArrayList<Square> emptySquares(){
    ArrayList<Square> squares = new ArrayList<Square>();
    for(int i =0;i<3;i++){
      for(int j =0;j<4;j++){
        Square s = this.squares[i][j];
        if(s.getPiece() == null){
          squares.add(s);
        }
      }
    }
    return squares;
  }
  
  public int isFinal(){
    for(int i =0;i<this.squares.length;i++){
      Piece p = this.squares[i][0].getPiece(); 
      if(p != null && p.getName().equals("leo") && p.getOwnerId() == 2){
        return 2;
      }      
    }
    for(int i =0;i<this.squares.length;i++){
      Piece p = this.squares[i][3].getPiece(); 
      if(p != null && p.getName().equals("leo") && p.getOwnerId() == 1){
        return 1;
      }      
    }
    int counter = 0;
    
    outerloop:
    for(int i =1;i<3;i++){
      
      Piece lion = findLion(i);
      ArrayList<Piece> myPieces = getPiecesOnBoard(i);
      
      int enemyId = getOtherPlayerId(i);
      
      ArrayList<Piece> enemyPieces = getPiecesOnBoard(enemyId);
      ArrayList<Piece> enemyAttackingPieces = getPiecesAttacking(lion);
      boolean[][] dangerMatrix = createDangerMatrix(enemyPieces);
      
      //if lion is beeing attacked
      if(enemyAttackingPieces.size()>0){
        
        ArrayList<Piece> defendingPieces = new ArrayList<Piece>();
        
        for(Piece e:enemyAttackingPieces){
          for(Piece p:myPieces){
            int[][] moves = p.getMoveMatrix();
            for(int j = 0;j<moves.length;j++){
              int x = p.getX()+moves[j][0];
              int y = p.getY()+moves[j][1];
              
              if(x > -1 && x < 3 && y > -1 && y < 4){
                
                if(p.getName().equals("leo") && dangerMatrix[x][y] == false && x == e.getX() && y == e.getY()){
                  defendingPieces.add(p);
                }  
                else if(!p.getName().equals("leo") && x == e.getX() && y == e.getY()){
                  defendingPieces.add(p);
                }
              }
            }
          }
        }
        if(defendingPieces.size() > 0){
          counter++;
          continue outerloop;
        }
        
        
        int[][] moves = lion.getMoveMatrix();
        for(int j = 0;j<moves.length;j++){
          int x = lion.getX()+moves[j][0];
          int y = lion.getY()+moves[j][1];
          
          if(x > -1 && x < 3 && y > -1 && y < 4){
            Piece p = this.squares[x][y].getPiece();
            if(p != null && p.getOwnerId() != lion.getOwnerId() && dangerMatrix[x][y] ==false){
              counter++;
              continue outerloop;
            }
            else if(p == null && dangerMatrix[x][y] ==false){
              counter++;
              continue outerloop;
            }
          }
        }
      }else{
        if(this.players[i-1].getHand().size() > 0){
          counter++;
          continue outerloop;
        }
        
        for(Piece p:myPieces){
          int[][] moves = p.getMoveMatrix();
          for(int j = 0;j<moves.length;j++){
            int x = p.getX()+moves[j][0];
            int y = p.getY()+moves[j][1];
            if(x > -1 && x < 3 && y > -1 && y < 4){
              Piece pd = this.squares[x][y].getPiece();
              if(pd == null){
                counter++;
                continue outerloop;
              }
              else if(pd != null && pd.getOwnerId() != i){
                counter++;
                continue outerloop;
              }
            }
          }
        }
      }
      if(counter == 1){
        return 1;
      }else{
        return 2;
      }
    }
    
    return 0;
  }
  private ArrayList<Piece> getPiecesAttacking(Piece p){
    ArrayList<Piece> attacking = new ArrayList<Piece>();
    int id = 1;
    if(p.getOwnerId() == 1){
      id = 2;
    }
    ArrayList<Piece> enemyPieces = getPiecesOnBoard(id);
    
    for(Piece e:enemyPieces){
      int[][] moves = e.getMoveMatrix();
      for(int j = 0;j<moves.length;j++){
        int x = e.getX()+moves[j][0];
        int y = e.getY()+moves[j][1];
        if(x > -1 && x < 3 && y > -1 && y < 4 && x == p.getX() && y == p.getY()){
          attacking.add(e);
        }
      }
    }
    return attacking;
  }
  private boolean[][] createDangerMatrix(ArrayList<Piece> pieces){
    boolean[][] dangerMatrix = new boolean[3][4];
    
    for(Piece e:pieces){
      int[][] moves = e.getMoveMatrix();
      
      for(int j = 0;j<moves.length;j++){
        int x = e.getX()+moves[j][0];
        int y = e.getY()+moves[j][1];
        
        if(x > -1 && x < 3 && y > -1 && y < 4){
          dangerMatrix[x][y] = true;
        }
      }
    }
    return dangerMatrix;
  }
  
  public ArrayList<Piece> getPiecesOnBoard(int playerId){
    ArrayList<Piece> pieces = new ArrayList<Piece>();
    
    for(int i =0;i<this.squares.length;i++){
      for(int j =0;j<this.squares[i].length;j++){
        Piece p = this.squares[i][j].getPiece();
        if(p != null && p.getOwnerId() == playerId){
          pieces.add(p);
        }
      }
    }
    return pieces;
  }
  
  public ArrayList<Piece> getAllPiecesOnBoard(){
    ArrayList<Piece> pieces = new ArrayList<Piece>();
    
    for(int i =0;i<this.squares.length;i++){
      for(int j =0;j<this.squares[i].length;j++){
        Piece p = this.squares[i][j].getPiece();
        if(p != null){
          pieces.add(p);
        }
      }
    }
    return pieces;
  }
  
  private Piece findLion(int playerId){
    for(int i =0;i<this.squares.length;i++){
      for(int j =0;j<this.squares[i].length;j++){
        Piece p = this.squares[i][j].getPiece();
        if(p != null){
          if(p.getName().equals("leo") && p.getOwnerId() == playerId){
            return p;
          }
        }
      }
    }
    return null;
  }
  public Player getPlayerById(int i){
    return this.players[i-1];
  }
  
  public Board duplicate(Board b){
    ArrayList<Piece> pieces = b.getAllPiecesOnBoard();
    Board newBoard = new Board();
    for(Piece p:pieces){
      Piece np = new Piece();
      np.setName(p.getName());
      np.setOwnerId(p.getOwnerId());
      np.setX(p.getX());
      np.setY(p.getY());
      newBoard.getSquare(p.getX(), p.getY()).setPiece(np);
    }
    
    Player p1 = b.getPlayerById(1);
    Player np1 = newBoard.getPlayerById(1);
    for(Piece p:p1.getHand()){
      Piece np = new Piece();
      np.setName(p.getName());
      np.setOwnerId(p.getOwnerId());
      np.setX(p.getX());
      np.setY(p.getY());
      np1.addPiece(np);
    }
    
    Player p2 = b.getPlayerById(2);
    Player np2 = newBoard.getPlayerById(2);
    for(Piece p:p2.getHand()){
      Piece np = new Piece();
      np.setName(p.getName());
      np.setOwnerId(p.getOwnerId());
      np.setX(p.getX());
      np.setY(p.getY());
      np2.addPiece(np);
    }
    
    return newBoard;
  }
  @Override
  public String toString() {
    // TODO Auto-generated method stub
    return super.toString();
  }
}


public class MinMax {

  private int myId;
  private int enemyId;
  private HashMap<String, Integer> values = new HashMap<String, Integer>();
  private Board board;  
  
  public static final double WINVALUE = 10000;
  public static final double LOSEVALUE = -10000;
  
  public MinMax(Board b,int playerTurn){
    this.myId = playerTurn;
    this.enemyId = 1;
    if(this.myId == 1){
      this.enemyId = 2;
    }
    this.board = b;
    
    values.put("leo", 1);
    values.put("gir", 5);
    values.put("ele", 4);
    values.put("gal", 3);
    values.put("pin", 2);
  }
  
  public Move run(int i){
    ArrayList<Move> moves = this.board.getMoviments(this.myId);
    double best = -Double.MAX_VALUE;
    
    Move move = null;
    int depth = i+1;
    for(Move m:moves){
      Board b = board.duplicate(board);
      b.tick(m);
      
      double value = iterate(b,depth,b.getOtherPlayerId(this.myId));
      if(value >= best){
        best = value;
        move = m;
      }
    }
    return move;
  }
  
  public double iterate(Board board,int depth, int playerTurn){
    if(depth > 0){
      ArrayList<Move> moves = board.getMoviments(playerTurn);
      
      if(playerTurn == this.myId){
        double best = -Double.MAX_VALUE;
        for(Move m:moves){
          Board b = board.duplicate(board);
          b.tick(m);
          double value = iterate(b,depth-1,b.getOtherPlayerId(playerTurn));
          best = Math.max(value, best);
        }
        
        return best;
      }else{
        double best = Double.MAX_VALUE;
        for(Move m:moves){
          Board b = board.duplicate(board);
          b.tick(m);
          double value = iterate(b,depth-1,b.getOtherPlayerId(playerTurn));
          best = Math.min(value, best);
        }
        return best;
      }
    }else{
      
      int victory = board.isFinal();
      if(victory != 0){
        if(victory == this.myId){
          return WINVALUE + depth;
        }else{
          return LOSEVALUE - depth;
        }
      }else{
        int id = this.myId;
        int eid = this.enemyId;
        double myBoard = 0;
        double eBoard = 0;
        double myHand = 0;
        double eHand = 0;
              
        for(Piece p:board.getPiecesOnBoard(id)){
          myBoard+=this.values.get(p.getName());
        }
        for(Piece p:board.getPlayerById(id).getHand()){
          myHand+=(0.5*this.values.get(p.getName()));
        }
        for(Piece p:board.getPiecesOnBoard(eid)){
          eBoard+=this.values.get(p.getName());
        }
        for(Piece p:board.getPlayerById(eid).getHand()){
          eHand+=(0.5*this.values.get(p.getName()));
        }
        return myBoard+myHand-eBoard-eHand;
      }      
    }
  }
}

import core.Info;
import core.Peca;

public class Boards {

  public Board infoToBoard(Info info){
    Board b = new Board();
    for(int i =0;i<3;i++){
      for(int j=0;j<4;j++){
        Peca p = info.getTabuleiro().getCasa(i, j).getPeca();
        
        if(p != null){
          Piece np = new Piece();
          np.setName(p.getNome());
          np.setOwnerId(p.getDono().getId());
          b.getSquare(i,j).setPiece(np);
        }
      }
    }
    for(Peca p :info.getEu().getPecasNaMao()){
      Piece np = new Piece();
      np.setName(p.getNome());
      np.setOwnerId(p.getDono().getId());
      b.getPlayerById(info.getEu().getId()).addPiece(np);
    }
    for(Peca p :info.getOponente().getPecasNaMao()){
      Piece np = new Piece();
      np.setName(p.getNome());
      np.setOwnerId(p.getDono().getId());
      b.getPlayerById(info.getOponente().getId()).addPiece(np);
    }
    return b;
  }
  public Board init(){
    Board b = new Board();
    
    Piece p = new Piece();
    p.setName("gir");
    p.setOwnerId(1);
    b.getSquare(0, 0).setPiece(p);
    
    Piece p2 = new Piece();
    p2.setName("leo");
    p2.setOwnerId(1);
    b.getSquare(1, 0).setPiece(p2);
    
    Piece p3 = new Piece();
    p3.setName("ele");
    p3.setOwnerId(1);
    b.getSquare(2, 0).setPiece(p3);
    
    Piece p4 = new Piece();
    p4.setName("pin");
    p4.setOwnerId(1);
    b.getSquare(1, 1).setPiece(p4);
    
    Piece p5 = new Piece();
    p5.setName("pin");
    p5.setOwnerId(2);
    b.getSquare(1, 2).setPiece(p5);
    
    Piece p6 = new Piece();
    p6.setName("ele");
    p6.setOwnerId(2);
    b.getSquare(0, 3).setPiece(p6);
    
    Piece p7 = new Piece();
    p7.setName("leo");
    p7.setOwnerId(2);
    b.getSquare(1, 3).setPiece(p7);
    
    Piece p8 = new Piece();
    p8.setName("gir");
    p8.setOwnerId(2);
    b.getSquare(2, 3).setPiece(p8);
    return b;
  }
}

import java.util.ArrayList;

public class Player {
  private ArrayList<Piece> hand;
  
  public Player(){
    this.hand = new ArrayList<Piece>();
  }

  public boolean addPiece(Piece e) {
    return hand.add(e);
  }
  
  public Piece getPieceByName(String pieceName){
    for(int i = 0;i<this.hand.size();i++){
      if(this.hand.get(i).equals(pieceName)){
        return this.hand.get(i);
      }
    }
    return null;
  }

  public ArrayList<Piece> getHand() {
    return hand;
  }
  
}

public class Piece {
  private int x;
  private int y;
  private String name;
  private int ownerId;
  
  public int getOwnerId() {
    return ownerId;
  }
  public void setOwnerId(int ownerId) {
    this.ownerId = ownerId;
  }
  public int getX() {
    return x;
  }
  public void setX(int x) {
    this.x = x;
  }
  public int getY() {
    return y;
  }
  public void setY(int y) {
    this.y = y;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  
  public int[][] getMoveMatrix(){
    if(this.name.equals("leo")){
      int[][] m = {{-1,-1},{0,-1},{1,-1},{-1,0},{1,0},{-1,1},{0,1},{1,1}};
      return m;
    }
    else if(this.name.equals("ele")){
      int[][] m = {{-1,-1},{1,-1},{-1,1},{1,1}};
      return m;
    }
    else if(this.name.equals("gir")){
      int[][] m = {{0,-1},{-1,0},{1,0},{0,1}};
      return m;
    }
    else if(this.name.equals("pin")){
      int[][] m = {{0,-1}};
      if(this.ownerId == 1){
        m[0][1] = m[0][1]*-1;
      }
      return m;
    }
    else if(this.name.equals("gal")){
      int[][] m = {{-1,-1},{0,-1},{1,-1},{-1,0},{1,0},{0,1}};
      
      if(this.ownerId == 1){
            for(int i =0;i<m.length;i++){
              m[i][0] = m[i][0]*(-1);
              m[i][1] = m[i][1]*(-1);
            }
      }
      return m;
    }
    return null;
  }
  @Override
  public String toString() {
    return this.getName()+";"+this.getX()+";"+this.getY()+";"+this.getOwnerId();
  }
}

public class Move {
  private int destinyX;
  private int destinyY;
  private int originX;
  private int originY;
  
  private char type;
  private int playerId;
  private String pieceName;
  
  
  public Move(int destinyX, int destinyY, int originX, int originY, char type, int playerId, String pieceName) {
    this.destinyX = destinyX;
    this.destinyY = destinyY;
    this.originX = originX;
    this.originY = originY;
    this.type = type;
    this.playerId = playerId;
    this.pieceName = pieceName;
  }
  
  public String getPieceName() {
    return pieceName;
  }
  public void setPieceName(String pieceName) {
    this.pieceName = pieceName;
  }
  public int getDestinyX() {
    return destinyX;
  }
  public void setDestinyX(int destinyX) {
    this.destinyX = destinyX;
  }
  public int getDestinyY() {
    return destinyY;
  }
  public void setDestinyY(int destinyY) {
    this.destinyY = destinyY;
  }
  public int getOriginX() {
    return originX;
  }
  public void setOriginX(int originX) {
    this.originX = originX;
  }
  public int getOriginY() {
    return originY;
  }
  public void setOriginY(int originY) {
    this.originY = originY;
  }
  public char getType() {
    return type;
  }
  public void setType(char type) {
    this.type = type;
  }
  public int getPlayerId() {
    return playerId;
  }
  public void setPlayerId(int playerId) {
    this.playerId = playerId;
  }
  @Override
  public String toString() {
    return this.originX+","+this.originY+","+this.destinyX+","+this.destinyY+","+this.pieceName+","+this.playerId+","+this.type;
  }
}

public class Square {
  private int x;
  private int y;
  private Piece piece;
  
  public Square(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  public int getX() {
    return x;
  }
  public void setX(int x) {
    this.x = x;
  }
  public int getY() {
    return y;
  }
  public void setY(int y) {
    this.y = y;
  }
  public Piece getPiece() {
    return piece;
  }
  public Piece removePiece(){
    Piece p = piece;
    piece = null;
    return p;
  }
  public void setPiece(Piece piece) {
    this.piece = piece;
    this.piece.setX(this.x);
    this.piece.setY(this.y);
  }
  
}