package core;
public class Movimento{
  
  public static final String MOVER = "mover";
  public static final String COLOCAR = "colocar";
  
  private Peca peca;
  private String tipo;
  private int x;
  private int y;
  private Jogador jogador;
  
  public Movimento(Peca p, int x, int y,String tipo, Jogador j){
    this.x = x;
    this.y = y;
    this.tipo = tipo;
    this.peca = p;
    this.jogador = j;
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
  
  public Jogador getJogador(){
    return this.jogador;
  }
  
  public String toString(){
    return jogador.getId()+","+peca.getX()+","+peca.getY()+","+this.x+","+this.y+","+this.peca.getNome()+","+tipo;
  }
}