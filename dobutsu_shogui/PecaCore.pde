class PecaCore{
  
  private int id;
  private int x;
  private int y;
  protected int direcao;
    
  protected String nome;
  protected JogadorCore dono;
  
  public static final int CIMA = -1;
  public static final int BAIXO = 1;
  
  public PecaCore(int id, int d){
    this.direcao = d;
    this.id = id;
  }
  
  public void mudarDirecao(){
    if(this.direcao == CIMA){
      this.direcao = BAIXO;
    }else{
      this.direcao = CIMA;
    }
  }
  
  public int getX(){
    return this.x;
  }
  
  public int getY(){
    return this.y;
  }
  public void setX(int x){
    this.x = x;
  }
  
  public void setY(int y){
    this.y = y;
  } 
  
  public void setDono(JogadorCore j){
    this.dono = j;
  }
 
  public JogadorCore getDono(){
    return this.dono;
  }
  
  public String getNome(){
    return this.nome;
  }
  public int getId(){
    return this.id;
  }
  
  public int[][] getMatrizDeMovimento(){
    return null;
  }
  
  public int getDirecao(){
    return this.direcao;
  }
    
}