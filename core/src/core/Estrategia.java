package core;
import java.util.ArrayList;

//classe abstrata responsável por definir aquilo que é obrigatório ao definir uma estratégia.
public abstract class Estrategia{
  
  //método que de fato define a estrategia
  public abstract Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos);
  
  //toda estratégia deve ter um nome.
  public abstract String getNome();
  
  //toda estratégia deve ter um nome de equipe.
  public abstract String getEquipe();
  
  public void terminar(int idGanhador){
  }
}