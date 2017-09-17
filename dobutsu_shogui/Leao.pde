class Leao extends PecaCore{
  
  public Leao(int d){
    super(d);
    this.nome = "leo";
    this.img = loadImage("leao.jpg");
    
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