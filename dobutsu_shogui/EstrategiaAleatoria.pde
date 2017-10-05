class EstrategiaAleatoria extends Estrategia{
 
  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
    int r = int(random(movimentos.size()));
    return movimentos.get(r);
  }
  
  public String getNome(){
    return "aleatória";
  }
  
  public String getEquipe(){
    return "ash ketchum";
  }
}