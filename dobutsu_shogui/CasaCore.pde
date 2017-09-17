class CasaCore{
  private int x;
  private int y;
  private PecaCore peca;
  
  public CasaCore(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  public void colocarPeca(PecaCore p){
    this.peca = p;
    this.peca.setX(this.x);
    this.peca.setY(this.y);
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
  
  public void removerPeca(){
    this.peca = null;
  }
 
  public PecaCore getPeca(){
    return this.peca;
  }
  
  public void desenhar(int offx, int offy){
    rect(offx+this.x,offy+this.y,80,80);
    if(this.peca != null){
      this.peca.desenhar(offx,offy);
    }
    
  }
}