package core;

public class Casa{
  private int x;
  private int y;
  private Peca peca;
  
  public Casa(int x, int y, Peca p){
    this.x = x;
    this.y = y;
    this.peca = p;
  }
  
  public int getX(){
    return this.x;
  }
  public int getY(){
    return this.y;
  }
      
  public boolean temPeca(){
    if(this.peca == null){
      return false;
    }else{
      return true;
    }
  }
   
  public Peca getPeca(){
    return this.peca;
  }
}