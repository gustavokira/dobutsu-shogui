class EstrategiaMatadora extends EstrategiaComMemoria{
 
  public int der = 0;
  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
    for(Movimento m:movimentos){
      if(m.getPeca().getNome().equals("leo")){
        if(m.getY() == 0 && m.getJogador().getId() == 2){
          return m;
        }
        if(m.getY() == 2 && m.getJogador().getId() == 1){
          return m;
        }
      }
    }
    for(Movimento m:movimentos){
      
      JogoSimulacao j = new JogoSimulacao(new EstrategiaAleatoria(),new EstrategiaAleatoria());
      LogJava l = new LogJava();
      Replay r = new ReplayJava(l.getTimeStamp());
      j.setLog(l);
      j.setReplay(r);
      j.stringToInfo(info.getEu().getId(),infoToString(info));
      j.criarInfo();
      Info ij = j.getInfo();
      Movimento escolhido = null;
      for(Movimento mj:ij.getMovimentos()){
        if(
          mj.getX() == m.getX() &&
          mj.getY() == m.getY() &&
          mj.getPeca().getNome() == m.getPeca().getNome()
          ){
            escolhido = mj;
          }
    }
      
      j.turno(escolhido);
      j.criarInfo();
      
      Info i = j.getInfo();
      
      if(i.getMovimentos().size() == 0){
        return m;
      }
      
    }
        
    int r = int(random(movimentos.size()));
    return movimentos.get(r);
  }
  
  public String getNome(){
    return "matadora";
  }
  
  public String getEquipe(){
    return "ash ketchum";
  }
}