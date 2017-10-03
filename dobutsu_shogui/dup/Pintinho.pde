class Pintinho extends PecaCore{
  public Pintinho(int id, int d){
    super(id, d);
    this.nome = "pin";
  }
  
  public PecaCore transformar(){
    PecaCore g = new Galo(this.getId(),this.direcao);
    g.setDono(this.dono);
    return g;
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