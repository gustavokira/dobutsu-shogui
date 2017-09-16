class TabuleiroCore{
  public CasaCore[][] casas;
  private int largura;
  private int altura;
  
  public TabuleiroCore(){
    this.largura = 3;
    this.altura = 4;
    
    this.criarCasas();
    
  }
  private void criarCasas(){
    casas = new CasaCore[this.largura][this.altura];
    for(int i =0;i<this.largura;i++){
      for(int j =0;j<this.altura;j++){
        this.casas[i][j] = new CasaCore(i,j);
      }
    }
  }
  public void addPeca(PecaCore p, int x, int y){
    this.casas[x][y].colocarPeca(p);
  }
  
  public void removerPeca(PecaCore p){
    int px = p.getX();
    int py = p.getY();
    p.setX(-1);
    p.setY(-1);
    this.casas[px][py] = null;
  }
  
  public CasaCore getCasa(int x, int y){
    if(x < 0 || x > this.largura-1 || y < 0 || y > this.altura+1){
      return this.casas[x][y];
    }else{
      return null;
    }
  }
  
  public int getLargura(){
    return this.largura;
  }
  
  public int getAltura(){
    return this.altura;
  }
  
  public void desenhar(){
    for(int i =0;i<this.largura;i++){
      for(int j =0;j<this.altura;j++){
          this.casas[i][j].desenhar(i*80,j*80);
        }
    }
  }
}