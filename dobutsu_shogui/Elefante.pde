class Elefante extends PecaCore{
public Elefante(int id, int d){
    super(id, d);
    this.nome = "ele";
    this.img = loadImage("elefante.jpg");
  }
  
  public int[][] getMatrizDeMovimento(){
    int[][] movimento = {
      {-1,-1},{1,-1},
      {-1,1},{1,1}
    };
    return movimento;
  }
}