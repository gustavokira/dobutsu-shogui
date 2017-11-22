package ai.forecasting;

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
