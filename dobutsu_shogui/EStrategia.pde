abstract class Estrategia{
 
  public abstract Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos);
  
  public abstract String getNome();
  
  public abstract String getEquipe();
}

class EstrategiaAleatoria extends Estrategia{
 
  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
    int r = int(random(movimentos.size()));
    return movimentos.get(r);
  }
  
  public String getNome(){
    return "aleatoria";
  }
  
  public String getEquipe(){
    return "kira";
  }
}