class EstrategiaMCTS extends EstrategiaComMemoria{
 
  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
   
    String infoStr = infoToString(info);
    int i = info.getEu().getId();
     Movimento escolhido= null;
    try{
    MonteCarloTreeSearch mcts = new MonteCarloTreeSearch(i,infoStr,1000,0);
    mcts.run();
    Movimento melhor= mcts.getMovimento();
   
    
      for(Movimento m:movimentos){
         int x = m.getX();
         int y = m.getY();
         String nome= m.getPeca().getNome();
         
         if(melhor.getX() == x && melhor.getY() == y && nome == melhor.getPeca().getNome()){
           escolhido = m;
         }
      }
    }catch(Exception e){
      if(escolhido == null){
        println("random!");
        int r = int(random(movimentos.size()));
        return movimentos.get(r);
      }
    }
       
    return escolhido;
  }
  
  public String getNome(){
    return "mcts";
  }
  
  public String getEquipe(){
    return "ash ketchum";
  }
}