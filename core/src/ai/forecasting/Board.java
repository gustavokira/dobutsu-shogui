package ai.forecasting;

import java.util.ArrayList;

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
	
	public static Board duplicate(Board b){
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
