class Info{
  private Tabuleiro tabuleiro;
  private Jogador jogador1;
  private Jogador jogador2;
  private Jogador jogadorAtual;
  private int idDoJogadorAtual;
  private ArrayList<Movimento>movimentos;
  private boolean meuLeaoEstaSendoAtacado;
  
  
  public Info(Jogo jogo, JogadorCore j){
    idDoJogadorAtual = j.getId();
    this.jogador1 = new Jogador(jogo.getJogador1());
    this.jogador2 = new Jogador(jogo.getJogador2());
    
    if(this.idDoJogadorAtual == this.jogador1.getId()){
      this.jogadorAtual = this.jogador1;
    }else{
      this.jogadorAtual = this.jogador2;
    }
    
    this.tabuleiro = new Tabuleiro(jogo.getTabuleiro(),jogador1,jogador2);
    this.movimentos = new ArrayList<Movimento>();
    this.meuLeaoEstaSendoAtacado = false;
    
    ArrayList<Peca> pecas = this.tabuleiro.getPecas();
    ArrayList<Peca> pecasMinhas = new ArrayList<Peca>();
    ArrayList<Peca> pecasOponente = new ArrayList<Peca>();
    Peca meuLeao = null;
    
    for(Peca p :pecas){
      if(p.dono.getId() == this.idDoJogadorAtual){
        pecasMinhas.add(p);
        if(p.getNome().equals("leo")){
          meuLeao = p;
        }
      }else{
        pecasOponente.add(p);
      }
    }
    
    ArrayList<Peca> atacandoLeao = new ArrayList<Peca>();

    boolean[][] matrizDeAtaque = new boolean[this.tabuleiro.getLargura()][this.tabuleiro.getAltura()];
    for(Peca p: pecasOponente){
      int[][] matriz = p.getMatrizDeMovimento();
      for(int i =0;i<matriz.length;i++){
        int x = p.getX()+matriz[i][0];
        int y = p.getY()+matriz[i][1];
        
        if(x == meuLeao.getX() && y == meuLeao.getY()){
          atacandoLeao.add(p);
        }
        if( !(x < 0 || x > this.tabuleiro.getLargura()-1 || y< 0 || y > this.tabuleiro.getAltura()-1)){
          matrizDeAtaque[x][y] = true;
        }
      }
    }
    
    if(matrizDeAtaque[meuLeao.getX()][meuLeao.getY()]){
      this.meuLeaoEstaSendoAtacado = true;
    }
    
    for(Peca p :atacandoLeao){
      print(p);
    }
        
    for(Peca p :pecasMinhas){           
      int[][] matriz = p.getMatrizDeMovimento();
      for(int i =0;i<matriz.length;i++){
        int x = p.getX()+matriz[i][0];
        int y = p.getY()+matriz[i][1];
        if( !(x < 0 || x > this.tabuleiro.getLargura()-1 || y< 0 || y > this.tabuleiro.getAltura()-1)){
          Casa c = this.tabuleiro.getCasa(x,y);
          Peca destino = c.getPeca();
          
          //se for o leao, não pode mover onde o oponente esta atacando!
          if(p.getNome().equals("leo")){
              if(!matrizDeAtaque[x][y]){
                Movimento m = new Movimento(p,x,y,"mover",this.jogadorAtual);
                this.movimentos.add(m);
              }
          }else{
          
            if(destino != null && destino.getDono() != p.getDono()){
              Movimento m = new Movimento(p,x,y,"mover",this.jogadorAtual);
              this.movimentos.add(m);
            }
            
            if(destino == null){
                Movimento m = new Movimento(p,x,y,"mover",this.jogadorAtual);
                this.movimentos.add(m);
            }
          }
        }      
      }
    }
    
    
    pecasMinhas.clear();
    if(this.idDoJogadorAtual == this.jogador1.getId()){
      pecasMinhas = this.jogador1.getPecasNaMao();
    }
    else{
      pecasMinhas = this.jogador2.getPecasNaMao();
    }
    ArrayList<Casa>casasVazias = this.tabuleiro.getCasasVazias();
    for(Peca p :pecasMinhas){
      for(Casa c:casasVazias){
        Movimento m = new Movimento(p,c.getX(),c.getY(),"colocar",this.jogadorAtual);
        this.movimentos.add(m);
      }
    }
    
    
    
    
  }
  
  public Tabuleiro getTabuleiro(){
    return this.tabuleiro;
  }
  
  
  public Jogador getOponente(){
    if(this.idDoJogadorAtual == this.jogador1.getId()){
      return this.jogador2;
    }else{
      return this.jogador1;
    }
  }
  
  public ArrayList<Movimento> getMovimentos(){
    return this.movimentos;
  }
  
  public Jogador getEu(){
    if(this.idDoJogadorAtual == this.jogador1.getId()){
      return this.jogador1;
    }else{
      return this.jogador2;
    }
  }
  public boolean meuLeaoEstaSendoAtacado(){
    return this.meuLeaoEstaSendoAtacado;
  }
}