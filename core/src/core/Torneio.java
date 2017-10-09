package core;
import java.util.ArrayList;

public class Torneio{
  private ArrayList<Estrategia> estrategias;
  private Jogo jogo;
  private int confrontos;
  private Log log;
  
  public Torneio(int confrontos,Log l){
    this.confrontos = confrontos;
    this.log = l;
    this.estrategias = new ArrayList<Estrategia>();
  }
  
  public void adicionarEstrategia(Estrategia e){
    this.estrategias.add(e);
  }
  
  public void rodar(){
    for(int i =0;i<this.estrategias.size();i++){
      for(int j =i+1;j<this.estrategias.size();j++){
        Estrategia e1 = this.estrategias.get(i);
        Estrategia e2 = this.estrategias.get(j);
        
        for(int k = 0;k<this.confrontos;k++){
          this.jogo = new Jogo(e1,e2);
          this.jogo.setLog(this.log);
          this.jogo.salvarLog();
          
          this.jogo.iniciar();
          while(this.jogo.continuar()){
            this.jogo.turno();
          }
        }
        
      }
    }
    this.jogo = null;
  }
  
  public Jogo getJogo(){
    return this.jogo;
  }
}