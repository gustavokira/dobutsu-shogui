class Galo extends PecaCore{
public Galo(int id, int d){
    super(id, d);
    this.nome = "gal";
  }
  
  public PecaCore transformar(){
    PecaCore p = new Pintinho(this.getId(),this.direcao);
    p.setDono(this.dono);
    return p;
  }
  
  public int[][] getMatrizDeMovimento(){
    int[][] movimento = {
      {-1,-1},{0,-1},{1,-1},
      {-1,0},{1,0},
      {0,1}
    };
    
    if(this.direcao == PecaCore.BAIXO){
      for(int i =0;i<movimento.length;i++){
        movimento[i][0] = movimento[i][0]*(-1);
        movimento[i][1] = movimento[i][1]*(-1);
      }
    }
    
    
    return movimento;
  }
}