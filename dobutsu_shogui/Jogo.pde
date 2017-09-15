class Jogo{
  private Tabuleiro tabuleiro;
  
  private Jogador jogador1;
  private Jogador jogador2;
  private Jogador jogadorAtivo;
  
  public Jogo(){
    
    this.tabuleiro = new Tabuleiro();
    this.jogador1 = new Jogador();
    this.jogador2 = new Jogador();
    this.jogadorAtivo = jogador1;
    
    this.criarPecasJogador1();
    this.criarPecasJogador2();
  }
  
  private void trocarJogadorAtivo(){
    if(this.jogadorAtivo == this.jogador1){
      this.jogadorAtivo= this.jogador2;
    }else{
      this.jogadorAtivo= this.jogador1;
    }
  }
  
  private void criarPecasJogador1(){
    Peca g = new Girafa(Peca.BAIXO);
    this.jogador1.colocarPeca(g);
    this.tabuleiro.addPeca(g,0,0);
    
    Peca l = new Leao(Peca.BAIXO);
    this.jogador1.colocarPeca(l);
    this.tabuleiro.addPeca(l,1,0);
    
    Peca e = new Elefante(Peca.BAIXO);
    this.jogador1.colocarPeca(e);
    this.tabuleiro.addPeca(e,2,0);
    
    Peca p = new Pintinho(Peca.BAIXO);
    this.jogador1.colocarPeca(p);
    this.tabuleiro.addPeca(p,1,1);
  }
  
  private void criarPecasJogador2(){
    Peca g = new Girafa(Peca.CIMA);
    this.jogador2.colocarPeca(g);
    this.tabuleiro.addPeca(g,0,3);
    
    Peca l = new Leao(Peca.CIMA);
    this.jogador2.colocarPeca(l);
    this.tabuleiro.addPeca(l,1,3);
    
    Peca e = new Elefante(Peca.CIMA);
    this.jogador2.colocarPeca(e);
    this.tabuleiro.addPeca(e,2,3);
    
    Peca p = new Pintinho(Peca.CIMA);
    this.jogador2.colocarPeca(p);
    this.tabuleiro.addPeca(p,1,3);
  }
  
  public void desenhar(){
    tabuleiro.desenhar();
  }
}