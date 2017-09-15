class Casa{
  private int x;
  private int y;
  private Peca peca;
  
  public Casa(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  public void colocarPeca(Peca p){
    this.peca = p;
    p.setX(this.x);
    p.setY(this.y);
  }
  
  public int getX(){
    return this.x;
  }
  public int getY(){
    return this.y;
  }
  
  public void desenhar(int offx, int offy){
    rect(offx+this.x,offy+this.y,80,80);
    if(this.peca != null){
      this.peca.desenhar(offx,offy);
    }
    
  }
}