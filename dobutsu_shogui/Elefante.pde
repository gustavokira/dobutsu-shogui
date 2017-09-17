class Elefante extends PecaCore{
public Elefante(int d){
    super(d);
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