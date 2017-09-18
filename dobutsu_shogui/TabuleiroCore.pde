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
    this.casas[px][py].removerPeca();
  }
  
  public CasaCore getCasa(int x, int y){
    if(x < 0 || x > this.largura-1 || y < 0 || y > this.altura-1){
      return null;
    }else{
      return this.casas[x][y];
    }
  }
  
  public int getLargura(){
    return this.largura;
  }
  
  public int getAltura(){
    return this.altura;
  }
  
  public ArrayList<PecaCore> getPecas(){
    ArrayList<PecaCore> pecas = new ArrayList<PecaCore>(); 
     for(int i =0;i<this.largura;i++){
      for(int j =0;j<this.altura;j++){
        
        if(this.casas[i][j].temPeca())
          pecas.add(this.casas[i][j].getPeca());
        }
      }
      return pecas;
     }
     
  public ArrayList<PecaCore> getPecasLeoes(){
    return this.getPecasPorTipo(Leao.class);
  }
  public ArrayList<PecaCore> getPecasPintinhos(){
    return this.getPecasPorTipo(Pintinho.class);
  }
  
  private ArrayList<PecaCore> getPecasPorTipo(Class c){
    ArrayList<PecaCore> pecas = new ArrayList<PecaCore>(); 
     for(int i =0;i<this.largura;i++){
      for(int j =0;j<this.altura;j++){
        
        if(this.casas[i][j].temPeca() && this.casas[i][j].getPeca().getClass() == c){
          pecas.add(this.casas[i][j].getPeca());
        }
      }
       }
      return pecas;
  }
  
  public void desenhar(){
    for(int i =0;i<this.largura;i++){
      for(int j =0;j<this.altura;j++){
          this.casas[i][j].desenhar(i*80,j*80);
        }
    }
  }
}