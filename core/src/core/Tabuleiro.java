package core;
import java.util.ArrayList;

public class Tabuleiro{
  private int largura;
  private int altura;
  private Casa[][] casas;
  private ArrayList<Peca> pecas;
  
  public Tabuleiro(TabuleiroCore tc,Jogador j1, Jogador j2){
    this.largura = 3;
    this.altura = 4;
    this.pecas = new ArrayList<Peca>();
    
    this.casas = new Casa[this.largura][this.altura];
    for(int i =0;i<this.largura;i++){
      for(int j =0;j<this.altura;j++){
        
        if( tc.getCasa(i,j).temPeca() ){
          
          PecaCore pc = tc.getCasa(i,j).getPeca();
          Jogador jogador = null;
          
          if(pc.getDono().getId() == j1.getId()){
            jogador = j1;
          }else{
            jogador = j2;
          }
          Peca p = new Peca(pc,jogador);
          this.pecas.add(p);
          this.casas[i][j] = new Casa(i,j,p);
        }else{
          this.casas[i][j] = new Casa(i,j,null);
        }
      }
    }
    
  }
 
 public Casa getCasa(int x, int y){
    if(x < 0 || x > this.largura-1 || y < 0 || y > this.altura-1){
      return null;
    }else{
      return this.casas[x][y];
    }
  }
  
  public int getLargura(){
    return this.largura;
  }
  
  public int getAltura(){
    return this.altura;
  }
  
  public ArrayList<Peca> getPecas(){
    return this.pecas;
  }
  
  
  public ArrayList<Casa> getCasasVazias(){
    ArrayList<Casa> casas = new ArrayList<Casa>(); 
     for(int i =0;i<this.largura;i++){
      for(int j =0;j<this.altura;j++){
        
        if(!this.casas[i][j].temPeca())
          casas.add(this.casas[i][j]);
        }
      }
      return casas;
     }
}