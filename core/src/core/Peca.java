package core;
public class Peca{
 private int x;
 private int y;
 private int id;
 private String nome;
 private Jogador dono;
 protected int direcao;
 private int[][] matrizDeMovimento;
  
  public Peca(PecaCore p,Jogador dono){
    this.x = p.getX();
    this.y = p.getY();
    this.id = p.getId();
    this.dono = dono;
    this.nome = p.getNome();
    this.matrizDeMovimento = p.getMatrizDeMovimento();
  }
  
  public int getX(){
    return this.x;
  }
  
  public int getY(){
    return this.y;
  }
  
  public int getId(){
    return this.id;
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
    return "peca:"+this.x+","+this.y+","+this.nome+","+this.dono.getId()+";\n";
  }
}