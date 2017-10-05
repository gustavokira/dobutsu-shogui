class EstrategiaTeste extends Estrategia{
 
  private int turno = 1;
  
  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
    
    Jogador eu = info.getEu();
    println("turno",turno);
    turno++;
    
    println("minha mao:");
    ArrayList<Peca> minhaMao = eu.getPecasNaMao();
    for(int i =0;i<minhaMao.size();i++){
      Peca p = minhaMao.get(i);
      println(p.getNome());
    }
    
    Jogador inimigo = info.getOponente();
    
    println("mao inimigo:");
    ArrayList<Peca> maoInimigo = inimigo.getPecasNaMao();
    for(int i =0;i<maoInimigo.size();i++){
      Peca p = maoInimigo.get(i);
      println(p.getNome());
    }
    
    //pega o tabuleiro
    Tabuleiro t = info.getTabuleiro();
    
    println("casas:");
    //percorre todas as casas
    for(int i =0;i<t.getAltura();i++){
      for(int j =0;j<t.getLargura();j++){
    
         //pega a cada j, i
        Casa c = t.getCasa(j,i);
        
        boolean temPeca = c.temPeca();
        println(c.getX(),c.getY(),temPeca);
        Peca p = c.getPeca();
        if(p != null){
          println(p.getId(),p.getNome(),p.getX(),p.getY());
        }
      }
    }
    
    println("movimentos:");
    for(int i =0;i<movimentos.size();i++){
      Movimento m = movimentos.get(i);
      Peca p = m.getPeca();
      println(p.getNome(),p.getX(),p.getY(),m.getX(),m.getY(),m.getTipo());
    }
    
    println("-------------------");
    
    int r = int(random(movimentos.size()));
    return movimentos.get(r);
  }
  
  public String getNome(){
    return "teste";
  }
  
  public String getEquipe(){
    return "ash ketchum";
  }
}