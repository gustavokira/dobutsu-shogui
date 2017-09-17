class Pintinho extends PecaCore{
  public Pintinho(int id, int d){
    super(id, d);
    this.nome = "pin";
    this.img = loadImage("pintinho.jpg");
  }
  
  public int[][] getMatrizDeMovimento(){
    int[][] movimento = {
      {0,-1}
    };
    
    if(this.direcao == PecaCore.BAIXO){
      movimento[0][1] = movimento[0][1]*-1;
    }
    return movimento;
  }
}