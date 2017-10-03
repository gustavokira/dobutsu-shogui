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

class EstrategiaGirafaAntesDeTudo extends Estrategia{
 
  
  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
    
    //percorre todos os movimentos
    for(int i =0;i<movimentos.size();i++){
      //pega o atual
      Movimento m = movimentos.get(i);
      //pega o x e o y do movimento.
      int destinoX = m.getX();
      int destinoY = m.getY();
      //pega o tabuleiro
      Tabuleiro t = info.getTabuleiro();
      //pega a casa destino do movimento
      Casa destino = t.getCasa(destinoX,destinoY);
      //se tem uma peca na casa de destino
      if(destino.temPeca()){
        //pega a peca no destino
        Peca noDestino = destino.getPeca();
        //se a peca e girafa, escolhemos essa.
        if(noDestino.getNome() == "gir"){
          return m;
        }
      }
    }
    //se não achar nenhuma girafa, sorteamos uma qualqer
    int r = int(random(movimentos.size()));
    return movimentos.get(r);
  }
  
  public String getNome(){
    return "girafa antes";
  }
  
  public String getEquipe(){
    return "ash ketchum";
  }
}