class Gui{
  private int casa;
  private int painel;
  private TabuleiroCore tabuleiro;
  private Jogo jogo;
  private ArrayList<PecaCore> pecas;
  private ArrayList<PecaCore> pecasNaMao1;
  private ArrayList<PecaCore> pecasNaMao2;
  private Estrategia e1;
  private Estrategia e2;
  
  private PFont fontGrande;
  private PFont fontPequena;
  
  public Gui(Jogo jogo){
    this.casa = 100;
    this.painel = 100;
    this.e1 = jogo.getJogador1().getEstrategia();
    this.e2 = jogo.getJogador2().getEstrategia();
    this.jogo = jogo;
    this.tabuleiro = jogo.getTabuleiro();
    this.pecasNaMao1 = jogo.getJogador1().getPecasNaMao();
    this.pecasNaMao2 = jogo.getJogador2().getPecasNaMao();
    this.pecas = this.tabuleiro.getPecas();
    this.fontGrande = loadFont("Roboto-Regular-36.vlw");
    this.fontPequena = loadFont("Roboto-Regular-24.vlw");
  }
  
  public void desenhar(){
   
   this.desenharIdentificacao(jogo.getJogador1().getId(),e1);
   translate(0,5*this.casa);
   this.desenharIdentificacao(jogo.getJogador2().getId(),e2);
   translate(0,-5*this.casa);
   this.desenharTabuleiro();
   this.pecas = this.tabuleiro.getPecas();
   for(PecaCore p:this.pecas){
     rect(10+p.getX()*this.casa,10+this.painel+p.getY()*this.casa,this.casa-20,this.casa-20);
     if(p.getClass() == Leao.class){
         this.desenharPeca(p,"img/leao.jpg");
     }
     if(p.getClass() == Elefante.class){
         this.desenharPeca(p,"img/elefante.jpg");
     }
     if(p.getClass() == Girafa.class){
         this.desenharPeca(p,"img/girafa.jpg");
     }
     if(p.getClass() == Pintinho.class){
         this.desenharPeca(p,"img/pintinho.jpg");
     }
     if(p.getClass() == Galo.class){
         this.desenharPeca(p,"img/galo.jpg");
     }
   }
   
   
   rect(3*this.casa,0,this.casa,6*this.casa);
   this.pecasNaMao1 = jogo.getJogador1().getPecasNaMao();
   this.pecasNaMao2 = jogo.getJogador2().getPecasNaMao();
   for(int i =0;i<this.pecasNaMao1.size();i++){
     PecaCore p = this.pecasNaMao1.get(i);
    if(p.getClass() == Leao.class){
         this.desenharPecaNaMao(p,"img/leao.jpg",i);
     }
     if(p.getClass() == Elefante.class){
         this.desenharPecaNaMao(p,"img/elefante.jpg",i);
     }
     if(p.getClass() == Girafa.class){
         this.desenharPecaNaMao(p,"img/girafa.jpg",i);
     }
     if(p.getClass() == Pintinho.class){
         this.desenharPecaNaMao(p,"img/pintinho.jpg",i);
     }
     if(p.getClass() == Galo.class){
         this.desenharPecaNaMao(p,"img/galo.jpg",i);
     }
    }
    for(int i =0;i<this.pecasNaMao2.size();i++){
     PecaCore p = this.pecasNaMao2.get(i);
    if(p.getClass() == Leao.class){
         this.desenharPecaNaMao(p,"img/leao.jpg",i);
     }
     if(p.getClass() == Elefante.class){
         this.desenharPecaNaMao(p,"img/elefante.jpg",i);
     }
     if(p.getClass() == Girafa.class){
         this.desenharPecaNaMao(p,"img/girafa.jpg",i);
     }
     if(p.getClass() == Pintinho.class){
         this.desenharPecaNaMao(p,"img/pintinho.jpg",i);
     }
     if(p.getClass() == Galo.class){
         this.desenharPecaNaMao(p,"img/galo.jpg",i);
     }
    }
  }
  
  public void desenharPecaNaMao(PecaCore p, String imgLink,float i){
    int lado = this.casa/2;
    int r = int(i%2);
    int q = int(i/2);
   
    PImage img = loadImage(imgLink);
         if(p.getDirecao() == PecaCore.BAIXO){
            pushMatrix();
            translate(
              (r*(lado))+(3*this.casa) +lado/2,
              (q*(lado))+(3*this.casa) +lado/2
            );
            rotate(PI);
            image(img, -lado/2, (3*this.casa)-lado/2,lado, lado);
            popMatrix();
          }else{
              image(img, (r*(lado))+(3*this.casa), (q*(lado))+(3*this.casa),lado, lado);
          }
  }

  
  public void desenharPeca(PecaCore p, String imgLink){
    PImage img = loadImage(imgLink);
         if(p.getDirecao() == PecaCore.BAIXO){
            pushMatrix();
            translate(
              10+p.getX()*this.casa +(this.casa-20)/2,
              10+this.painel+p.getY()*this.casa +(this.casa-20)/2
            );
            rotate(PI);
            image(img, -(this.casa-20)/2, -(this.casa-20)/2,this.casa-20, this.casa-20);
            popMatrix();
          }else{
              image(img, 10+p.getX()*this.casa, 10+this.painel+p.getY()*this.casa,this.casa-20, this.casa-20);
          }
  }
  
  public void desenharIdentificacao(int i,Estrategia e){
    
    fill(255);
    stroke(125);
    rect(100,0,2*this.casa,this.casa);
    
    //numero fundo
    stroke(0);
    fill(0);
    rect(0,0,this.casa,this.casa);
    
    
   if(this.jogo.temGanhador() && i == this.jogo.getGanhador().getId()){
       fill(0,255,0);
       stroke(0,255,0);
       rect(0,0,3*this.casa,this.casa);
   }
    
    //nome
    fill(0);
    textFont(fontGrande,36);
    text(e.getNome(), 120, 75);
    
    
    //numero
    textFont(fontGrande,64);
    fill(255);
    text(i, 32, 70);
    
    //equipe
    fill(100);
    textFont(fontPequena,24);
    text(e.getEquipe(), 120, 40);
    
  }
    
  public void desenharTabuleiro(){
    stroke(255);
    fill(125);
    for(int i =0;i<3;i++){
      for(int j =0;j<4;j++){
        rect(i*this.casa,this.painel + j*this.casa,this.casa,this.casa);
      }
    }
  }
  
}