class EstrategiaBigBeijo extends Estrategia{
 
  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
      for(int i =0;i<movimentos.size();i++){
      //pega o atual
      Movimento m = movimentos.get(i);
      //pega o x e o y do movimento.
      Peca p = m.getPeca();
      String nomedapecaqvm = p.getNome();
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
        if(noDestino.getNome() == "null" && nomedapecaqvm == "leo" && destinoY == 4){
         return m;
        }
        if(noDestino.getNome() == "ele" && nomedapecaqvm == "pin"){
        return m;
        }
        if(noDestino.getNome() == "ele" && nomedapecaqvm == "ele"){
          return m;
        }
        if(noDestino.getNome() == "ele" && nomedapecaqvm == "gir"){
          return m;
        }
        if(noDestino.getNome() == "gir" && nomedapecaqvm == "pin"){
          return m;
        }
        if(noDestino.getNome() == "gir" && nomedapecaqvm == "gir"){
          return m;
        }
        if(noDestino.getNome() == "gir" && nomedapecaqvm == "ele"){
          return m;
        }

      }
    }
    int r = int(random(movimentos.size()));
    return movimentos.get(r);
  }
  
  public String getNome(){
    return "1%";
  }
  
  public String getEquipe(){
    return "chance d ganhar";
  }
}