class Movimento{
  
  public static final String MOVER = "mover";
  public static final String COLOCAR = "colocar";
  
  private Peca peca;
  private String tipo;
  private int x;
  private int y;
  
  public Movimento(Peca p, int x, int y,String tipo){
    this.x = x;
    this.y = y;
    this.tipo = tipo;
    this.peca = p;

}
  
  public String getTipo(){
    return this.tipo;
  }
  
  public Peca getPeca(){
    return this.peca;
  }
  public int getX(){
    return this.x;
  }
  public int getY(){
    return this.y;
  }
}