
class JogadorCore{
  private ArrayList<PecaCore>pecas;
  private ArrayList<PecaCore>pecasNaMao;
  private Estrategia estrategia;
  
  public JogadorCore(Estrategia e){
    this.pecas = new ArrayList<PecaCore>();
    this.pecasNaMao = new ArrayList<PecaCore>();
    this.estrategia = e;
  }
  
  public Movimento jogar(Info info){
    return this.estrategia.escolherMovimento(info);
  }
  
  public void colocarPeca(PecaCore p){
    p.setDono(this);
    this.pecas.add(p);
  }
  
  public void removePeca(PecaCore p){
    p.setDono(null);
    this.pecas.remove(p);
  }
  
  public void colocarPecaNaMao(PecaCore p){
    p.setDono(this);
    this.pecasNaMao.add(p);
  }
  
  public void removePecaDaMao(PecaCore p){
    p.setDono(null);
    this.pecasNaMao.remove(p);
  }
  
  public ArrayList<PecaCore> getPecas(){
    return this.pecas;
  }
  
  public ArrayList<PecaCore> getPecasNaMao(){
    return this.pecasNaMao;
  }
}