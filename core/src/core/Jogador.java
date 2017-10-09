package core;
import java.util.ArrayList;

public class Jogador{
  
    private int id;
    private ArrayList<Peca>pecasNaMao;
    
    public Jogador(JogadorCore jogador){
      this.id = jogador.getId();
      this.pecasNaMao = new ArrayList<Peca>();
      
      ArrayList<PecaCore> pecasNaMaoOriginal = jogador.getPecasNaMao();
      for(PecaCore pc: pecasNaMaoOriginal){
        Peca p = new Peca(pc,this);
        this.pecasNaMao.add(p);
      }
      
    }
  
   public int getId(){
    return this.id;
  }
  public ArrayList<Peca> getPecasNaMao(){
    return this.pecasNaMao;
  }
  public String toString(){
    return "jogador:\n"+this.pecasNaMao;
  }
}