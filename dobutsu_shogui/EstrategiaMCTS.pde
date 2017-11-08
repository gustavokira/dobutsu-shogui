class EstrategiaMCTS extends EstrategiaComMemoria{
 
  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
    
    MonteCarloTreeSearch mcts = new MonteCarloTreeSearch(1,null,50);
    mcts.run();
    return null;
  }
  
  public String getNome(){
    return "mcts";
  }
  
  public String getEquipe(){
    return "ash ketchum";
  }
}