class Jogo{
  
  private FabricaPecaCore fabricaPeca;
  private Log log;
  
  private TabuleiroCore tabuleiro;
  private JogadorCore jogador1;
  private JogadorCore jogador2;
  private JogadorCore jogadorAtivo;
  private int turno;
  private Info info;
  
  private int estado;
  
  public Jogo(Estrategia e1, Estrategia e2){
    
    this.fabricaPeca = new FabricaPecaCore();
    this.log =new Log();
    
    this.tabuleiro = new TabuleiroCore();
    this.jogador1 = new JogadorCore(e1, 1);
    this.jogador2 = new JogadorCore(e2, 2);
    this.jogadorAtivo = jogador1;
    this.turno = 0;
    
    this.criarPecasJogador1();
    this.criarPecasJogador2();
    
    this.estado = 1;
    
  }
  
  private void criarInfo(){
    this.info = new Info(this,this.jogadorAtivo);    
  }
  
  private PecaCore acharPecaNoCore(Peca p){
    ArrayList<PecaCore> pecas = new ArrayList<PecaCore>();
    pecas.addAll(this.jogador1.getPecasNaMao());
    pecas.addAll(this.jogador2.getPecasNaMao());
    pecas.addAll(this.tabuleiro.getPecas());
    
    for(PecaCore pc: pecas){
      if(pc.getId() == p.getId()){
        return pc;
      }
    }
    
    return null;
  }
  
  public void turno(){
    this.criarInfo();
    
    if(this.info.getMovimentos().size()>0){
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
        this.moverPecaNoTabuleiro(p,px,py);
        
        if(p.getClass() == Pintinho.class){
          this.transformarEmGalo(p);
        }
      }
      else if(m.getTipo().equals("colocar")){
        this.colocarPecaNoTabuleiro(p,px,py);
      }
      this.log.adicionar(this.turno, m,this.jogadorAtivo);
    }else{
      this.irParafim();
    }
    
    
    JogadorCore ganhador = this.verificarLeoesNosFins();
    
    if(ganhador != null){
      this.irParafim();
    }
    
    this.trocarJogadorAtivo();
    this.turno++;
    
  }
  
  private void irParafim(){
     this.estado = 2;
     this.log.salvar();
  }
  
  private JogadorCore verificarLeoesNosFins(){
    ArrayList<PecaCore> pecas = this.tabuleiro.getPecasLeoes();
    for(PecaCore p:pecas){
      if(p.getDono() == this.jogador1 && p.getY() == 3){
        return this.jogador1;
      }
      if(p.getDono() == this.jogador2 && p.getY() == 0){
        return this.jogador2;
      }
    }
    return null;
  }
  private void transformarEmGalo(PecaCore p){
    if(
          (p.getDono() == this.jogador1 && p.getY() == 3) ||
          (p.getDono() == this.jogador2 && p.getY() == 0)
        ){
          
            int x = p.getX();
            int y = p.getY();
            PecaCore n = ((Pintinho)p).transformar();
            this.tabuleiro.removerPeca(p);
            this.tabuleiro.addPeca(n,x,y);
          
        }
  }
  
  private void moverPecaParaMao(PecaCore p, JogadorCore j){
    this.tabuleiro.removerPeca(p);
    if(p.getClass() == Galo.class){
      p = ((Galo) p).transformar();
    }
    j.colocarPecaNaMao(p);
    j.colocarPeca(p);
    p.setDono(j);
    p.mudarDirecao();
  }
  private void moverPecaNoTabuleiro(PecaCore p, int x,int y){
    this.tabuleiro.removerPeca(p);
      this.tabuleiro.addPeca(p,x,y);
  }
  private void colocarPecaNoTabuleiro(PecaCore p, int x,int y){
    this.jogadorAtivo.removePecaDaMao(p);
    this.tabuleiro.addPeca(p,x,y);
  }
  
  
  private void trocarJogadorAtivo(){
    if(this.jogadorAtivo == this.jogador1){
      this.jogadorAtivo = this.jogador2;
    }else{
      this.jogadorAtivo= this.jogador1;
    }
  }
  
  public TabuleiroCore getTabuleiro(){
    return this.tabuleiro;
  }
  public JogadorCore getJogador1(){
    return this.jogador1;
  }
  public JogadorCore getJogador2(){
    return this.jogador2;
  }
  
  private void criarPecasJogador1(){
    PecaCore g = fabricaPeca.criarGirafaParaBaixo();
    this.jogador1.colocarPeca(g);
    g.setDono(this.jogador1);
    this.tabuleiro.addPeca(g,0,0);
    
    PecaCore l = fabricaPeca.criarLeaoParaBaixo();
    this.jogador1.colocarPeca(l);
    l.setDono(this.jogador1);
    this.tabuleiro.addPeca(l,1,0);
    
    PecaCore e = fabricaPeca.criarElefanteParaBaixo();
    this.jogador1.colocarPeca(e);
    e.setDono(this.jogador1);
    this.tabuleiro.addPeca(e,2,0);
    
    PecaCore p = fabricaPeca.criarPintinhoParaBaixo();
    this.jogador1.colocarPeca(p);
    p.setDono(this.jogador1);
    this.tabuleiro.addPeca(p,1,1);
    
  }
  
  private void criarPecasJogador2(){
    PecaCore g = fabricaPeca.criarGirafaParaCima();
    this.jogador2.colocarPeca(g);
    g.setDono(this.jogador2);
    this.tabuleiro.addPeca(g,0,3);
    
    PecaCore l = fabricaPeca.criarLeaoParaCima();
    this.jogador2.colocarPeca(l);
    l.setDono(this.jogador2);
    this.tabuleiro.addPeca(l,1,3);
    
    PecaCore e = fabricaPeca.criarElefanteParaCima();
    this.jogador2.colocarPeca(e);
    e.setDono(this.jogador2);
    this.tabuleiro.addPeca(e,2,3);
    
    PecaCore p = fabricaPeca.criarPintinhoParaCima();
    this.jogador2.colocarPeca(p);
    p.setDono(this.jogador2);
    this.tabuleiro.addPeca(p,1,2);
  }
  
  public void desenhar(){
    tabuleiro.desenhar();
  }
  public int getTurno(){
    return this.turno;
  }
  public boolean continuar(){
    if(this.estado == 1){ return true;}
    else return false;
  }
}