class FabricaPecaCore{
  private int pecaId;
  public FabricaPecaCore(){
    this.pecaId = -1;
  }
  public PecaCore criarLeaoParaBaixo(){
    return new Leao(++this.pecaId, PecaCore.BAIXO);
  }
  public PecaCore criarLeaoParaCima(){
    return new Leao(++this.pecaId, PecaCore.CIMA);
  }
  
  public PecaCore criarElefanteParaBaixo(){
    return new Elefante(++this.pecaId, PecaCore.BAIXO);
  }
  public PecaCore criarElefanteParaCima(){
    return new Elefante(++this.pecaId, PecaCore.CIMA);
  }
  
  public PecaCore criarGirafaParaCima(){
    return new Girafa(++this.pecaId, PecaCore.CIMA);
  }
  public PecaCore criarGirafaParaBaixo(){
    return new Girafa(++this.pecaId, PecaCore.BAIXO);
  }
  
  public PecaCore criarPintinhoParaCima(){
    return new Pintinho(++this.pecaId, PecaCore.CIMA);
  }
  public PecaCore criarPintinhoParaBaixo(){
    return new Pintinho(++this.pecaId, PecaCore.BAIXO);
  }
  
  public PecaCore criarGaloParaCima(){
    return new Galo(++this.pecaId, PecaCore.CIMA);
  }
  public PecaCore criarGaloParaBaixo(){
    return new Galo(++this.pecaId, PecaCore.BAIXO);
  }
} 