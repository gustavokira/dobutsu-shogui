//classe abstrata responsável por definir aquilo que é obrigatório ao definir uma estratégia.
abstract class Estrategia{
  
  //método que de fato define a estrategia
  public abstract Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos);
  
  //toda estratégia deve ter um nome.
  public abstract String getNome();
  
  //toda estratégia deve ter um nome de equipe.
  public abstract String getEquipe();
}

class EstrategiaAleatoria extends Estrategia{
 
  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
    int r = int(random(movimentos.size()));
    return movimentos.get(r);
  }
  
  public String getNome(){
    return "aleatória";
  }
  
  public String getEquipe(){
    return "autobots";
  }
}