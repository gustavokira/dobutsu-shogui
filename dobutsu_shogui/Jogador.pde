
class Jogador{
  private ArrayList<Peca>pecas;
  private ArrayList<Peca>pecasNaMao;
  
  public Jogador(){
    this.pecas = new ArrayList<Peca>();
    this.pecasNaMao = new ArrayList<Peca>();
  }
  
  public void colocarPeca(Peca p){
    this.pecas.add(p);
  }
  
  public void removePeca(Peca p){
    this.pecas.remove(p);
  }
  
  public void colocarPecaNaMao(Peca p){
    this.pecasNaMao.add(p);
  }
  
  public void removePecaDaMao(Peca p){
    this.pecasNaMao.remove(p);
  }
}