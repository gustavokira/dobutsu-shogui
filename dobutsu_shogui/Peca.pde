class Peca{
 private int x;
 private int y;
 private String nome;
 private Jogador dono;
 private int direcao;
 private int[][] matrizDeMovimento;
  
  public Peca(PecaCore p,Jogador dono){
    this.x = p.x;
    this.y = p.y;
    this.dono = dono;
    this.nome = p.nome;
    this.matrizDeMovimento = p.getMatrizDeMovimento();
  }
  
  public int getX(){
    return this.x;
  }
  
  public int getY(){
    return this.y;
  }
   
  public Jogador getDono(){
    return this.dono;
  }
  
  public String getNome(){
    return this.nome;
  }
  public int[][] getMatrizDeMovimento(){
    return this.matrizDeMovimento;
  }
  public String toString(){
    return "["+this.x+","+this.y+","+this.nome+","+this.dono.getId()+"]";
  }
}