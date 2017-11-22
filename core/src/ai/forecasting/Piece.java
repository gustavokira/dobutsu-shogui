package ai.forecasting;

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
