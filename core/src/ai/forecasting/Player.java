package ai.forecasting;

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
