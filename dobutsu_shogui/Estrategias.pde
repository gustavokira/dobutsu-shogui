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


class EstrategiaMaterial extends Estrategia{
 
  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
    HashMap<String,Integer> valores = new HashMap<String,Integer>();
    valores.put("leo",0);
    valores.put("gir",4);
    valores.put("ele",3);
    valores.put("gal",2);
    valores.put("pin",1);
    ArrayList<Movimento> movimentosQueValem = new ArrayList<Movimento>(); 
    for(int i =0;i<movimentos.size();i++){
      Movimento m = movimentos.get(i);
      int destinoX = m.getX();
      int destinoY = m.getY();
      Tabuleiro t = info.getTabuleiro();
      Casa destino = t.getCasa(destinoX,destinoY);
      if(destino.temPeca()){
        Peca noDestino = destino.getPeca();
        int valor1 = valores.get(m.getPeca().getNome());
        int valor2 = valores.get(noDestino.getNome());
        if(valor2 > valor1){
          movimentosQueValem.add(m);
        }
      }
    }
    if(movimentosQueValem.size() == 0){
      int r = int(random(movimentos.size()));
      return movimentos.get(r);
    }else{
      int r = int(random(movimentosQueValem.size()));
      return movimentosQueValem.get(r);
    }
  }
  
  public String getNome(){
    return "material";
  }
  
  public String getEquipe(){
    return "ash ketchum";
  }
}