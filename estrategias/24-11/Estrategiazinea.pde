class Estrategiazinea extends Estrategia{
 
  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
    String inicio;
  
    Jogador eu = info.getEu();
    int k = eu.getId();
    if(k == 1){
      inicio= "sou primeiro";
    }else {
      inicio= "sou segundo";
    }
    
    if (inicio=="sou primeiro"){
      
        Tabuleiro t= info.getTabuleiro();
        
         Casa girafacasa = t.getCasa(0,0);
         Casa leaocasa = t.getCasa(1,2);
         Casa elefanteop = t.getCasa(0,1);
         Casa leaonormal = t.getCasa(1,0);
         Casa leaofugiues = t.getCasa(0,2);
         Casa leaofugiudi = t.getCasa(2,2);
         Casa elefantefoge= t.getCasa(2,0);
         Casa elefantefoge1= t.getCasa(2,0);
         Casa girafaandou = t.getCasa (0,1);
         Casa leaorecuou = t.getCasa (1,3);
         Casa leaoplado = t.getCasa (2,2);
         Casa leaomeu= t.getCasa(1,0);
         Casa pinmeu1= t.getCasa(2,0);
         Casa pinmeu2= t.getCasa(1,1);
         Casa girafameu= t.getCasa(2,1);
         Casa leaooutro= t.getCasa(0,3);
         Casa girafaoutro= t.getCasa(1,3);
         Casa eleoutro1= t.getCasa(2,3);
         Casa eleoutro2= t.getCasa(2,2);
         Casa leaofim= t.getCasa(2,2);
         Casa elemorre= t.getCasa(2,2);
         
         
//------------------------------------------------------------------------         

         boolean girafaesta00= false;
         boolean leaoelefante12= false;
         boolean elefante01= false;
         boolean leaonormal1= false;
         boolean leaoes= false;
         boolean leaodi= false;
         boolean elefanteC= false;
         boolean giraandou= false;
         boolean lerecuou= false;
         boolean lelado= false;
         boolean leaomeuA= false;
         boolean pinmeu1A= false;
         boolean pinmeu2A= false;
         boolean girafameuA= false;
         boolean leaooutroA= false;
         boolean girafaoutroA= false;
         boolean eleoutro1A= false;
         boolean eleoutro2A= false;   
         boolean leaofimA= false;
         boolean elemorreA= false;

         
//--------------------------------------------------------         
         if (girafacasa.temPeca()){
           Peca p = girafacasa.getPeca();
           if (p.getNome()=="gir"){
             girafaesta00=true;
           }
         }
         
         if (leaocasa.temPeca()){
           Peca p = leaocasa.getPeca();
           Jogador j = p.getDono();
           if ((p.getNome()=="leo" || p.getNome()=="ele") && j.getId()!=k){
             leaoelefante12=true;
           }
         }
         
        if (girafaesta00 == true && leaoelefante12 == true){
          Movimento escolhido = this.gifaraParaFrenteSeLeaoOuElefanteNoMeio(info,movimentos);
          if(escolhido != null){
            return escolhido;
          }
        } 
        
 //-----------------------------------------------------------------------------------------------       
        if (elefanteop.temPeca()){
           Peca p = elefanteop.getPeca();
           Jogador j = p.getDono();
           if (p.getNome()=="ele"&& j.getId()!=k){
             elefante01=true;
           }
         }
         
         if (leaonormal.temPeca()){
           Peca p = leaonormal.getPeca();
           Jogador j = p.getDono();
           if ((p.getNome()=="leo" || p.getNome()=="ele") && j.getId()!=k){
             leaonormal1=true;
           }
         }
         
        
        if (elefante01 == true && leaonormal1 == true){
          Movimento escolhido = this.ComeElefanteDoOP(info,movimentos);
            if(escolhido != null){
            return escolhido;
          }
        } 
        
 //--------------------------------------------------------       
        
       if (elefantefoge.temPeca()){
           Peca p = elefantefoge.getPeca();
           if (p.getNome()=="ele"){
             elefanteC=true;
           }
         } 
         
         if (elefantefoge1.temPeca()){
           Peca p = elefantefoge1.getPeca();
           if (p.getNome()=="ele"){
             elefanteC=true;
           }
         }
         
         if (leaofugiues.temPeca()){
           Peca p = leaofugiues.getPeca();
           Jogador j = p.getDono();
           if (p.getNome()=="leo"  && j.getId()!=k){
             leaoes=true;
           }
         }
         
          if (leaofugiudi.temPeca()){
           Peca p = leaofugiudi.getPeca();
           Jogador j = p.getDono();
           if (p.getNome()=="leo" && j.getId()!=k){
             leaodi=true;
           }
         }
         
        if (elefanteC == true && (leaodi == true || leaoes == true)){
           Movimento escolhido = this.SeLeaoOPFugirDoPintinho(info,movimentos);
            if(escolhido != null){
            return escolhido;
          }
        }
          
//--------------------------------------------------------
           if (leaorecuou.temPeca()){
           Peca p = leaorecuou.getPeca();
           Jogador j = p.getDono();
           if (p.getNome()=="leo"&& j.getId()!=k){
             lerecuou=true;
           }
         }
         
           if (leaoplado.temPeca()){
           Peca p = leaoplado.getPeca();
           Jogador j = p.getDono();
           if (p.getNome()=="leo"&& j.getId()!=k){
             lelado=true;
           }
         }
         
         if (girafaandou.temPeca()){
           Peca p = girafaandou.getPeca();
          
           if (p.getNome()=="gir"){
             giraandou=true;
           }
         }
         
        
        if ((lerecuou == true || lelado==true) && giraandou == true){
          Movimento escolhido = this.QuandoLeaoRecuaOuVaiProLado(info,movimentos);
            if(escolhido != null){
            return escolhido;
          }
        } 
 //-----------------------------------------------------------------------------         
        if (leaomeu.temPeca()){
           Peca p = leaomeu.getPeca();
           if (p.getNome()=="leo"){
             leaomeuA=true;
           }
         } 
         
         if (pinmeu1.temPeca()){
           Peca p = pinmeu1.getPeca();
           if (p.getNome()=="pin"){
             pinmeu1A=true;
           }
         }

         
         if (pinmeu2.temPeca()){
           Peca p = pinmeu2.getPeca();
           if (p.getNome()=="pin"){
             pinmeu2A=true;
           }
         } 
         
         if (girafameu.temPeca()){
           Peca p = girafameu.getPeca();
           if (p.getNome()=="gir"){
             girafameuA=true;
           }
         }
         
         
         if (leaooutro.temPeca()){
           Peca p = leaooutro.getPeca();
           Jogador j = p.getDono();
           if (p.getNome()=="leo"  && j.getId()!=k){
             leaooutroA=true;
           }
         }
         
          if (girafaoutro.temPeca()){
           Peca p = girafaoutro.getPeca();
           Jogador j = p.getDono();
           if (p.getNome()=="gir" && j.getId()!=k){
             girafaoutroA=true;
           }
         }
         
         if (eleoutro1.temPeca()){
           Peca p = eleoutro1.getPeca();
           Jogador j = p.getDono();
           if (p.getNome()=="ele"  && j.getId()!=k){
             eleoutro1A=true;
           }
         }
         
          if (eleoutro2.temPeca()){
           Peca p = eleoutro2.getPeca();
           Jogador j = p.getDono();
           if (p.getNome()=="ele"  && j.getId()!=k){
             eleoutro2A=true;
           }
         }
         
        if (leaomeuA == true && leaooutroA == true && girafameuA == true && girafaoutroA == true && pinmeu1A == true && pinmeu2A == true && eleoutro1A == true && eleoutro2A == true){
           Movimento escolhido = this.LeaoOPnoCantoComDoisElefates(info,movimentos);
            if(escolhido != null){
            return escolhido;
          }
        }  
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------          
          
           if (leaofim.temPeca()){
           Peca p = leaofim.getPeca();
           if (p.getNome()=="leo"){
             leaofimA=true;
           }
         }
         
         if (elemorre.temPeca()){
           Peca p = elemorre.getPeca();
           Jogador j = p.getDono();
           if ( p.getNome()=="ele" && j.getId()!=k){
             elemorreA=true;
           }
         }
         
        if (elemorreA == true && leaofimA == true){
          Movimento escolhido = this.LeaoVaiProCampoInimigoEganha(info,movimentos);
          if(escolhido != null){
            return escolhido;
          }
        } 
          
 //----------------------------------------------         
        } else if (inicio== "sou segundo"){
        
          Tabuleiro t = info.getTabuleiro(); 
          
        Casa pintinho = t.getCasa(1,1);
        Casa girafaPP = t.getCasa(2,2);
        Casa leaomeu = t.getCasa(1,3);
 //--------------------------------------------------------       
        boolean pininho = false;
        boolean irafa = false;
        boolean leomeu= false;
  //--------------------------------------------------------      
        if (leaomeu.temPeca()){
           Peca p = leaomeu.getPeca();
           if (p.getNome()=="leo"){
             leomeu=true;
           }
         }
         
         if (pintinho.temPeca()){
           Peca p = pintinho.getPeca();
           Jogador j = p.getDono();
           if (p.getNome()=="pin"&& j.getId()!=k){
             pininho=true;
           }
         }
         
        if (leomeu == true && pininho == true){
            Movimento escolhido = this.OPcomecouPintinho(info,movimentos);
            if(escolhido != null){
            return escolhido;
          }
      
        }
      
//--------------------------------------------------------        
        if (leaomeu.temPeca()){
           Peca p = leaomeu.getPeca();
           if (p.getNome()=="leo"){
             leomeu=true;
           }
         }
         
         if (girafaPP.temPeca()){
           Peca p = girafaPP.getPeca();
           Jogador j = p.getDono();
           if (p.getNome()=="pin"&& j.getId()!=k){
             irafa=true;
           }
         }
         
        if (leomeu == true && irafa == true){
            Movimento escolhido = this.OPcomecouGirafa(info,movimentos);
            if(escolhido != null){
            return escolhido;
          }
        }
        
//---------------------------------------------------------------------------------------
        }else {
           Tabuleiro t = info.getTabuleiro(); 
          for(int i =0;i<movimentos.size();i++){
            Movimento m = movimentos.get(i);
            Peca p = m.getPeca();

            if( p.getNome() == "pin"){
                Casa destino = t.getCasa(1,2);
                if(destino.temPeca()){return m;}
            }
           }
        }
    
     int r = int(random(movimentos.size()));
    return movimentos.get(r);
  }
  //--------------------------------------------------------------------------------------------------
  public Movimento gifaraParaFrenteSeLeaoOuElefanteNoMeio(Info info, ArrayList<Movimento> movimentos){
      Tabuleiro t = info.getTabuleiro(); 
      for(int i =0;i<movimentos.size();i++){
            Movimento m = movimentos.get(i);
            Peca p = m.getPeca();
      
            if( p.getNome() == "gir"){
              int destinoX = m.getX();
              int destinoY = m.getY();
           
              Casa destino = t.getCasa(0,1);
         
              if( destinoX==0 && destinoY == 1){
                return m;  
              }
            }
          }
    return null;
  }
  
 //------------------------------------------------------------------------------------
  public Movimento SeLeaoOPFugirDoPintinho(Info info, ArrayList<Movimento> movimentos){
     Tabuleiro t = info.getTabuleiro(); 
     for(int i =0;i<movimentos.size();i++){
            Movimento m = movimentos.get(i);
            Peca p = m.getPeca();
      
            if( p.getNome() == "ele"){
              int destinoX = m.getX();
              int destinoY = m.getY();
           
              Casa destino = t.getCasa(1,1);
         
              if( destinoX==1 && destinoY == 1){
                return m;  
              }
            }
          }
  return null;
  }
  //------------------------------------------------------------------------------
  public Movimento ComeElefanteDoOP (Info info, ArrayList <Movimento> movimentos){
    
      Tabuleiro t = info.getTabuleiro(); 
  for(int i =0;i<movimentos.size();i++){
            Movimento m = movimentos.get(i);
            Peca p = m.getPeca();
      
            if( p.getNome() == "leo"){
              int destinoX = m.getX();
              int destinoY = m.getY();
           
              Casa destino = t.getCasa(0,1);
         
              if( destinoX==0 && destinoY == 1){
                return m;  
              }
            }
          }
  return null;
  }
  //----------------------------------------------------------------------------------
  public Movimento OPcomecouPintinho (Info info, ArrayList <Movimento> movimentos){
     Tabuleiro t = info.getTabuleiro(); 
   for(int i =0;i<movimentos.size();i++){
            Movimento m = movimentos.get(i);
            Peca p = m.getPeca();
      
            if( p.getNome() == "leo"){
              int destinoX = m.getX();
              int destinoY = m.getY();
           
              Casa destino = t.getCasa(1,2);
         
              if( destinoX==1 && destinoY == 2){
                return m;  
              }
            }
          }
          return null;
  }
  
 //-------------------------------------------------------------------------------- 
   public Movimento OPcomecouGirafa (Info info, ArrayList <Movimento> movimentos){
     Tabuleiro t = info.getTabuleiro(); 
   for(int i =0;i<movimentos.size();i++){
            Movimento m = movimentos.get(i);
            Peca p = m.getPeca();
      
            if( p.getNome() == "leo"){
              int destinoX = m.getX();
              int destinoY = m.getY();
           
              Casa destino = t.getCasa(2,2);
         
              if( destinoX==2 && destinoY == 2){
                return m;  
              }
            }
          }
          return null;
  }
  //----------------------------------------------------------------------------------------------
   public Movimento QuandoLeaoRecuaOuVaiProLado (Info info, ArrayList <Movimento> movimentos){
     Tabuleiro t = info.getTabuleiro(); 
   for(int i =0;i<movimentos.size();i++){
            Movimento m = movimentos.get(i);
            Peca p = m.getPeca();
      
            if( p.getNome() == "ele"){
              int destinoX = m.getX();
              int destinoY = m.getY();
           
              Casa destino = t.getCasa(1,1);
         
              if( destinoX==1 && destinoY == 1){
                return m;  
              }
            }
          }
          return null;
  }
  
 //------------------------------------------------------------------------------------------------------- 
 
    public Movimento LeaoOPnoCantoComDoisElefates (Info info, ArrayList <Movimento> movimentos){
     Tabuleiro t = info.getTabuleiro(); 
   for(int i =0;i<movimentos.size();i++){
            Movimento m = movimentos.get(i);
            Peca p = m.getPeca();
      
            if( p.getNome() == "leo"){
              int destinoX = m.getX();
              int destinoY = m.getY();
           
              Casa destino = t.getCasa(1,0);
         
              if( destinoX==1 && destinoY == 0){
                return m;  
              }
            }
          }
          return null;
  }
  
 //---------------------------------------------------------------------------------------------------
 
  public Movimento LeaoVaiProCampoInimigoEganha (Info info, ArrayList <Movimento> movimentos){
     Tabuleiro t = info.getTabuleiro(); 
   for(int i =0;i<movimentos.size();i++){
            Movimento m = movimentos.get(i);
            Peca p = m.getPeca();
      
            if( p.getNome() == "leo"){
              int destinoX = m.getX();
              int destinoY = m.getY();
           
              Casa destino = t.getCasa(3,2);
         
              if( destinoX==3 && destinoY == 2){
                return m;  
              }
            }
          }
          return null;
  }
 //--------------------------------------------------------------------------------------------------
  public String getNome(){
    return"Estrategiazinea";
  }
  
  public String getEquipe(){
    return "hehe";
  }
}

  