class EstrategiaPintoAlemao extends Estrategia{
 
  int turno = 0;
  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
     turno++;
    boolean posi_cim = false;
    Jogador eu = info.getEu();
    Jogador opp = info.getOponente();
    int j = eu.getId();
    
    if(j == 1){
       println("estou jogando em cima");
       posi_cim = true;
    }else{
       println("estou jogando em baixo");
       posi_cim = false;
    }
    
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
    
   
    println("turno",turno);
   
      
      
      Peca atual = m.getPeca();
      
        
        ArrayList<Peca> pecasNoTabuleiro = t.getPecas();
        
        //for(int b =0;b<pecasNoTabuleiro.size();b++){
        //    Peca pAtual = pecasNoTabuleiro.get(b);
        //    Jogador dono = pAtual.getDono();
        //    int idDono = dono.getId();
            
        //    if (idDono == opp.getId() && destino.getPeca().getNome() == "leo"){
              
        //    }
        //    else{
        //    }
        //  }

      
      String tipo = m.getTipo();
      if (tipo == "colocar"){
      return m;
      }
      
     } 
        
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
      
      Peca atual = m.getPeca();
      
        if (atual.getNome() == "pin"){
            return m; 
       }
      }
    
    
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
      
      Peca atual = m.getPeca();
      
      if (atual.getNome() == "ele"){
         if (destino.temPeca() && destino.getPeca().getNome() != "pin"){
           return m; 
      }
    }
    }
    
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
      
      Peca atual = m.getPeca();
      
      if (atual.getNome() == "gir"){
           return m; 
      }
    }

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
      
      Peca atual = m.getPeca();
      
      if (posi_cim == false){
        if (atual.getNome() == "leo"){
           int x = m.getX();
           int y = m.getY();
             if(x == 0 && y == 2){
               return m;
             }
       }
      }else{
          if (atual.getNome() == "leo"){
           int x = m.getX();
           int y = m.getY();
             if(x == 0 && y == 3){
               return m;
          }
      }
    }
   }
  if (turno >= 200 && turno <= 203){
    //se não achar nenhuma girafa, sorteamos uma qualqer
    int r = int(random(movimentos.size()));
    return movimentos.get(r);
  }
  
  int r = int(random(movimentos.size()));
    return movimentos.get(r);
  }
    
  public String getNome(){
    return "PintoAlemao";
  }
  
  public String getEquipe(){
    return "Panqueca-Temaki";
  }

}