class Galo extends PecaCore{
public Galo(int d){
    super(d);
    this.nome = "gal";
    this.img = loadImage("galo.jpg");
  }
  
  public int[][] getMatrizDeMovimento(){
    int[][] movimento = {
      {-1,-1},{0,-1},{1,-1},
      {-1,0},{1,0},
      {0,1}
    };
    
    if(this.direcao == PecaCore.BAIXO){
      for(int i =0;i<movimento.length;i++){
        movimento[0][i] = movimento[0][i]*-1;
      }
    }
    
    
    return movimento;
  }
}