class Peca{
  private PecaCore peca;
  
  public Peca(PecaCore p){
    this.peca = p;
  }
  
  public int getX(){
    return this.peca.getX();
  }
  
  public int getY(){
    return this.peca.getY();
  }
   
  public JogadorCore getDono(){
    return this.peca.getDono();
  }
  
  public String getNome(){
    return this.peca.getNome();
  }
}