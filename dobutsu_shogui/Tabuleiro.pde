class Tabuleiro{
  public Casa[][] casas;
  private int largura;
  private int altura;
  
  public Tabuleiro(){
    this.largura = 3;
    this.altura = 4;
    
    this.criarCasas();
    
  }
  private void criarCasas(){
    casas = new Casa[this.largura][this.altura];
    for(int i =0;i<this.largura;i++){
      for(int j =0;j<this.altura;j++){
        this.casas[i][j] = new Casa(i,j);
      }
    }
  }
  public void addPeca(Peca p, int x, int y){
    this.casas[x][y].colocarPeca(p);
  }
  
  public Casa getCasa(int x, int y){
    return this.casas[x][y];
  }
  
  public void desenhar(){
    for(int i =0;i<this.largura;i++){
      for(int j =0;j<this.altura;j++){
          this.casas[i][j].desenhar(i*80,j*80);
        }
    }
  }
}