class Girafa extends PecaCore{
  public Girafa(int id, int d){
    super(id, d);
    this.nome = "gir";
  }
  
  public int[][] getMatrizDeMovimento(){
    int[][] movimento = {
      {0,-1},
      {-1,0},{1,0},
      {0,1}
    };
    return movimento;
  }
}