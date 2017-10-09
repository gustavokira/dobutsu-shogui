package core;
public class Leao extends PecaCore{
  
  public Leao(int id, int d){
    super(id, d);
    this.nome = "leo";    
  }
  
  public int[][] getMatrizDeMovimento(){
    int[][] movimento = {
      {-1,-1},{0,-1},{1,-1},
      {-1,0},{1,0},
      {-1,1},{0,1},{1,1}
    };
    return movimento;
  }
}