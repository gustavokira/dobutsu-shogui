class Jogo{
  
  private TabuleiroCore tabuleiro;
  private JogadorCore jogador1;
  private JogadorCore jogador2;
  private JogadorCore jogadorAtivo;
  private Info info;
  public Jogo(Estrategia e1, Estrategia e2){
    
    this.tabuleiro = new TabuleiroCore();
    this.jogador1 = new JogadorCore(e1);
    this.jogador2 = new JogadorCore(e2);
    this.jogadorAtivo = jogador1;
    this.info = new Info();
    
    this.criarPecasJogador1();
    this.criarPecasJogador2();
  }
  
  private void criarInfo(){
    this.info = this.info;
    
    
    
  }
  
  private PecaCore acharPecaNoCore(Peca p){
    ArrayList<PecaCore> pecas = this.jogador1.getPecas();
  
    for(PecaCore pc: pecas){
      if(pc.getX() == p.getX() &&
         pc.getY() == p.getY() &&
         pc.getNome() == p.getNome()
      ){
        return pc;
      }
    }
    
    pecas = this.jogador2.getPecas();
  
    for(PecaCore pc: pecas){
      if(pc.getX() == p.getX() &&
         pc.getY() == p.getY() &&
         pc.getNome() == p.getNome()
      ){
        return pc;
      }
    }
    return null;
  }
  
  public void turno(){
    criarInfo();
    Movimento m = this.jogadorAtivo.jogar(this.info);
    int px = m.getX();
    int py = m.getY();
    PecaCore p = acharPecaNoCore(m.getPeca());
    
    if(m.getTipo().equals("mover")){
      CasaCore c = this.tabuleiro.getCasa(px,py);
      if(c.temPeca()){
        PecaCore alvo = c.getPeca();
        this.moverPecaParaMao(alvo, this.jogadorAtivo);
      }
      this.tabuleiro.addPeca(p,px,py);
    }
    else if(m.getTipo().equals("colocar")){
      this.tabuleiro.addPeca(p,px,py);
    }
    
    this.trocarJogadorAtivo();
  }
  
  private void moverPecaParaMao(PecaCore p, JogadorCore j){
    j.colocarPecaNaMao(p);
    j.colocarPeca(p);
    this.tabuleiro.removerPeca(p);
  }
  
  private void trocarJogadorAtivo(){
    if(this.jogadorAtivo == this.jogador1){
      this.jogadorAtivo= this.jogador2;
    }else{
      this.jogadorAtivo= this.jogador1;
    }
  }
  
  private void criarPecasJogador1(){
    PecaCore g = new Girafa(PecaCore.BAIXO);
    this.jogador1.colocarPeca(g);
    this.tabuleiro.addPeca(g,0,0);
    
    PecaCore l = new Leao(PecaCore.BAIXO);
    this.jogador1.colocarPeca(l);
    this.tabuleiro.addPeca(l,1,0);
    
    PecaCore e = new Elefante(PecaCore.BAIXO);
    this.jogador1.colocarPeca(e);
    this.tabuleiro.addPeca(e,2,0);
    
    PecaCore p = new Pintinho(PecaCore.BAIXO);
    this.jogador1.colocarPeca(p);
    this.tabuleiro.addPeca(p,1,1);
  }
  
  private void criarPecasJogador2(){
    PecaCore g = new Girafa(PecaCore.CIMA);
    this.jogador2.colocarPeca(g);
    this.tabuleiro.addPeca(g,0,3);
    
    PecaCore l = new Leao(PecaCore.CIMA);
    this.jogador2.colocarPeca(l);
    this.tabuleiro.addPeca(l,1,3);
    
    PecaCore e = new Elefante(PecaCore.CIMA);
    this.jogador2.colocarPeca(e);
    this.tabuleiro.addPeca(e,2,3);
    
    PecaCore p = new Pintinho(PecaCore.CIMA);
    this.jogador2.colocarPeca(p);
    this.tabuleiro.addPeca(p,1,3);
  }
  
  public void desenhar(){
    tabuleiro.desenhar();
  }
}