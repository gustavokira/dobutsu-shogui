package estrategias;

import java.util.ArrayList;
import java.util.Random;

import core.Estrategia;
import core.Info;
import core.Jogador;
import core.Tabuleiro;
import core.Movimento;
import core.Casa;
import core.Peca;
//se o elefante tiver uma casa de destino, ele anda, se não, a peça que estiver ocupando o unico destino possivel para ele se movimenta pra onde for possivel

public class EstrategiaGirafaGodiJava extends Estrategia{

public int turno = 0;
 
public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){

  this.turno++;
  Jogador eu = info.getEu();
  int lado = eu.getId();
  int pelefantex, pelefantey, ppintinhox, ppintinhoy, pgirafax, pgirafay; 
  
  if(lado == 1){
     //estou jogando em cima
     pelefantex = 1 ;
     pelefantey = 1 ;
     ppintinhox = 0 ;
     ppintinhoy = 2 ;
     pgirafax   = 2 ;
     pgirafay   = 0 ;

  }else{
      //estou jogando em baixo
      pelefantex = 1 ;
      pelefantey = 2 ;
      ppintinhox = 0 ;
      ppintinhoy = 1 ;
      pgirafax   = 2 ;
      pgirafay   = 3 ;
  }
       
    if(this.turno == 1){
      
     for(int i =0;i<movimentos.size();i++){
        //pega o atual
        Movimento m = movimentos.get(i);
        Peca p = m.getPeca();
        String nomedapeca = p.getNome();
        if (nomedapeca == "pin"){
          return m;
        }
      }
      
    }else{
       
        // GIRAFA MATA PEÇA POSSIVEL
      for(int i =0;i<movimentos.size();i++){
        //pega o atual
        Movimento m = movimentos.get(i);
        Peca p = m.getPeca();
        String nomedapeca = p.getNome();
        //pega o x e o y do movimento.
        int destinoX = m.getX();
        int destinoY = m.getY();
        //pega o tabuleiro
        Tabuleiro t = info.getTabuleiro();
        //pega a casa destino do movimento
        Casa destino = t.getCasa(destinoX,destinoY);
        //se tem uma peca na casa de destino
        
        if(destino.temPeca() && nomedapeca == "gir"){
            return m;
        }
      }
      
      // ELEFANTE MATA PEÇA POSSIVEL
      for(int i =0;i<movimentos.size();i++){
        //pega o atual
        Movimento m = movimentos.get(i);
        Peca p = m.getPeca();
        String nomedapeca = p.getNome();
        //pega o x e o y do movimento.
        int destinoX = m.getX();
        int destinoY = m.getY();
        //pega o tabuleiro
        Tabuleiro t = info.getTabuleiro();
        //pega a casa destino do movimento
        Casa destino = t.getCasa(destinoX,destinoY);
        //se tem uma peca na casa de destino
        
        if(destino.temPeca() && nomedapeca == "ele"){
            return m;
        }
       }
      
      //Elefante de volta
      for(int i =0;i<movimentos.size();i++){
        //pega o atual
        Movimento m = movimentos.get(i);
        Peca p = m.getPeca();
        String nomedapeca = p.getNome();
        //pega o x e o y do movimento.
        int destinoX = m.getX();
        int destinoY = m.getY();
        //pega o tabuleiro
        Tabuleiro t = info.getTabuleiro();
        //pega a casa destino do movimento
        Casa destino = t.getCasa(destinoX,destinoY);
        //se tem uma peca na casa de destino
        
        if(destinoX == pelefantex && destinoY == pelefantey && nomedapeca == "ele"){
          //pega a peca no destino
            return m;
        }
       }
       //QUALQUER PEÇA MATA A GIR
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
      // PRIORIDADE DO PINTÃO MATAR AS PEÇAS
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
        Peca p = m.getPeca();
        String nomedapeca = p.getNome();
        if (nomedapeca == "pin"){
          return m;
        }
      }
     }

    //GIRAFA MATA PEÇA NA CASA DE DESTINO
     for(int i =0;i<movimentos.size();i++){
    //pega o atual
    Movimento m = movimentos.get(i);
    //pega o x e o y do movimento.
    int destinoX = m.getX();
    int destinoY = m.getY();
    //pega o tabuleiro
    Tabuleiro t = info.getTabuleiro();
    String tipo = m.getTipo();
    //pega a casa destino do movimento
      if(tipo == "colocar" ){
        Peca p = m.getPeca();
        String nomedapeca = p.getNome();
        if (nomedapeca == "gir" && destinoX == pgirafax && destinoY == pgirafay){
         return m;
        }
       }   
      }
 
  //PEGA O PINTÃO DA RESERVA E COLOCA NO JOGO
  for(int i =0;i<movimentos.size();i++){
    //pega o atual
    Movimento m = movimentos.get(i);
    //pega o x e o y do movimento.
    int destinoX = m.getX();
    int destinoY = m.getY();
    //pega o tabuleiro
    Tabuleiro t = info.getTabuleiro();
    String tipo = m.getTipo();
    //pega a casa destino do movimento
      if(tipo == "colocar" ){
        Peca p = m.getPeca();
        String nomedapeca = p.getNome();
        if (nomedapeca == "pin" && destinoX == ppintinhox && destinoY == ppintinhoy){
         return m;
        }
       }   
      }
     }

    //se não achar nenhuma girafa, sorteamos uma qualqer
    Random random = new Random();
	int r = random.nextInt(movimentos.size());
    return movimentos.get(r);
  }
 
public String getNome(){
  return "Cerol na mão";
}

public String getEquipe(){
  return "Bonde do Tigrão";
}
}