class EstrategiaDinossauro extends Estrategia{
                    
  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
   
    //Receber o meu id no jogo
     int id = info.getEu().getId();
    //Identificar se eu estou na parte de cima ou de baixo
    int valorFinalDeY= 0; 
    if(id == 1){
    //quero criar uma variável/arraylist que armazene as possíveis coordenadas para o leão chegar do outro lado e ganhar o jogo
    valorFinalDeY= 3;
    } else if(id == 2){
    //quero criar uma variável/arraylist que armazene as possíveis coordenadas para o leão chegar do outro lado e ganhar o jogo só que dessa vez do outro lado
    //percorre todos os movimentos
        valorFinalDeY= 0;
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
      //se tem uma peca na casa de destino
      
      if((destinoX == 0 || destinoX == 1 || destinoX == 2) && (destinoY == valorFinalDeY)){
      
      Peca p = m.getPeca();
      String nome = p.getNome();

      if (nome == "leo") {
        
      return m; 
      
      }
      }

      if(valorFinalDeY==0){
      
      if(destinoX==0 && destinoY==1){
      Casa oLeao= t.getCasa(0,2);
      
      Casa vaLeao= t.getCasa(0,0);
      Casa goLeao= t.getCasa(1,0);
      Casa vamosLeao= t.getCasa(0,1);
      Casa allerLeao= t.getCasa(1,1);
      
      if(vaLeao.temPeca()== false && goLeao.temPeca()== false && vamosLeao.temPeca()== false && allerLeao.temPeca()== false){
        if(oLeao.temPeca()== true){
          
        Peca pecaVaiLeao = oLeao.getPeca();
        
        if(pecaVaiLeao.getNome() == "leo"){
          
      return m;
      
      }
      }
      }
      }      
      
      else if (destinoX==2 && destinoY==1){
        
      Casa oLeao= t.getCasa(2,2);   
      Casa vaLeao= t.getCasa(2,0);
      Casa goLeao= t.getCasa(1,0);
      Casa vamosLeao= t.getCasa(1,1);
      Casa allerLeao= t.getCasa(2,1);
      
      if(vaLeao.temPeca()== false && goLeao.temPeca()== false && vamosLeao.temPeca()== false && allerLeao.temPeca()== false){
       
      if(oLeao.temPeca()== true){
        
        Peca pecaVaiLeao = oLeao.getPeca();
        
        if(pecaVaiLeao.getNome() == "leo"){
          
      return m;
      }
      }
      }
      }     
      
      Casa fecharLeao= t.getCasa(1,0);
      
      if(fecharLeao.temPeca()){
       Peca pecafecharLeao = fecharLeao.getPeca();
     
        if(pecafecharLeao.getNome() == "leo"){
        if (destinoX== 1 && destinoY==1){
       
        Peca p = m.getPeca();
      String nome = p.getNome();
      
       if (nome == "ele") {
      return m;
      }
      }
      }
      }
      }
      
      else if(valorFinalDeY==3){
       
      if(destinoX==0 && destinoY==2){
      
      Casa oLeao= t.getCasa(0,1);   
      Casa vaLeao= t.getCasa(0,2);
      Casa goLeao= t.getCasa(0,3);
      Casa vamosLeao= t.getCasa(1,2);
      Casa allerLeao= t.getCasa(1,3);
      
      if(vaLeao.temPeca()== false && goLeao.temPeca()== false && vamosLeao.temPeca()== false && allerLeao.temPeca()== false){
       
         if(oLeao.temPeca()== true){
        
        Peca pecaVaiLeao = oLeao.getPeca();
        
        if(pecaVaiLeao.getNome() == "leo"){
          
      return m;
      }
      }
      }
      }      
      
      else if (destinoX==2 && destinoY==2){
        
      Casa oLeao= t.getCasa(2,1);   
      Casa vaLeao= t.getCasa(1,2);
      Casa goLeao= t.getCasa(1,3);
      Casa vamosLeao= t.getCasa(2,2);
      Casa allerLeao= t.getCasa(2,3);
      
      if(vaLeao.temPeca()== false && goLeao.temPeca()== false && vamosLeao.temPeca()== false && allerLeao.temPeca()== false){
       
        if(oLeao.temPeca()== true){
        
        Peca pecaVaiLeao = oLeao.getPeca();
        
        if(pecaVaiLeao.getNome() == "leo"){
          
      return m;
      }
      }
      }
      }
      
      Casa fecharLeao= t.getCasa(1,3);
      
      if(fecharLeao.temPeca()){
       Peca pecafecharLeao = fecharLeao.getPeca();
     
        if(pecafecharLeao.getNome() == "leo"){
      if (destinoX== 1 && destinoY==2){
        Peca p = m.getPeca();
      String nome = p.getNome();
      
       if (nome == "ele") {
      return m;
      
      }
      }
      }
      }
      }
      if(destino.temPeca()){
        //pega a peca no destino
        Peca noDestino = destino.getPeca();       
        //se a peca e girafa, escolhemos essa.
        
        //gostaria de fazer um if nesse local identificando se os destinos póssiveis aramazenadas na variável/arraylist do leão
        
         if(noDestino.getNome() == "gir"){
          return m;
        }
        else if(noDestino.getNome() == "ele"){
          return m;
      }
        else if(noDestino.getNome() == "gal"){
          return m;
    }
        else if(noDestino.getNome() == "pin"){
          return m;
    } 
    }
      }
      
    //se nenhuma estratégia der certo, sorteamos um movimento qualqer
    int r = int(random(movimentos.size()));
    return movimentos.get(r);
  }
    
  
  public String getNome(){
    return "ssauro";
  }
  
  public String getEquipe(){
    return "Dino";
  }
  }