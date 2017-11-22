package ai.forecasting;

import java.util.ArrayList;
import java.util.HashMap;

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

		values.put("leo", 10);
		values.put("gir", 14);
		values.put("ele", 13);
		values.put("gal", 12);
		values.put("pin", 11);
	}

	public Move run(int i){
		ArrayList<Move> moves = this.board.getMoviments(this.myId);
		double best = -Double.MAX_VALUE;

		Move move = null;
		int depth = i+1;
		for(Move m:moves){
			Board b = Board.duplicate(board);
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

		int victory = board.isFinal();
		if(victory != 0){
			if(victory == this.myId){
				return WINVALUE + (depth*100);
			}else{
				return LOSEVALUE - (depth*100);
			}
		}

		if(depth > 0){
			ArrayList<Move> moves = board.getMoviments(playerTurn);

			if(playerTurn == this.myId){
				double best = -Double.MAX_VALUE;
				for(Move m:moves){
					Board b = Board.duplicate(board);
					b.tick(m);
					double value = iterate(b,depth-1,b.getOtherPlayerId(playerTurn));
					best = Math.max(value, best);
				}

				return best;
			}else{
				double best = Double.MAX_VALUE;
				for(Move m:moves){
					Board b = Board.duplicate(board);
					b.tick(m);
					double value = iterate(b,depth-1,b.getOtherPlayerId(playerTurn));
					best = Math.min(value, best);
				}
				return best;
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


