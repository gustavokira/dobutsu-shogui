package core;
import java.util.ArrayList;

public class JogadorCore{
  
  private int id;
  private ArrayList<PecaCore>pecas;
  private ArrayList<PecaCore>pecasNaMao;
  private Estrategia estrategia;
  
  public JogadorCore(Estrategia e,int id){
    this.pecas = new ArrayList<PecaCore>();
    this.pecasNaMao = new ArrayList<PecaCore>();
    this.estrategia = e;
    this.id = id;

  }
    
  public Movimento jogar(Info info){
    return this.estrategia.escolherMovimento(info,info.getMovimentos());
  }
  
  public void colocarPeca(PecaCore p){
    this.pecas.add(p);
  }
  
  public void removePeca(PecaCore p){
    this.pecas.remove(p);
  }
  
  public void colocarPecaNaMao(PecaCore p){
    this.pecasNaMao.add(p);
  }
  
  public void removePecaDaMao(PecaCore p){
    this.pecasNaMao.remove(p);
  }
  
  
  public ArrayList<PecaCore> getPecasNaMao(){
    return this.pecasNaMao;
  }
  public int getId(){
    return this.id;
  }
  public Estrategia getEstrategia(){
    return this.estrategia;
  }
  public String getNomeEquipe(){
    return this.estrategia.getNome();
  }
  public String getNomeEstrategia(){
    return this.estrategia.getEquipe();
  }
  
  public void terminar(int idGanhador){
    this.estrategia.terminar(idGanhador);
  }
  
}