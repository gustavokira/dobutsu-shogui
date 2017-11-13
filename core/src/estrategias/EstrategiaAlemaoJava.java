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

public class EstrategiaAlemaoJava extends Estrategia{
	 
	  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
	      
	    boolean posi_cim = false;
	    Jogador eu = info.getEu();
	    Jogador opp = info.getOponente();
	    int j = eu.getId();
	    
	    if(j == 1){
	       posi_cim = true;
	    }else{
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
	      
	        if (destino.temPeca() && atual.getNome() == "pin"){
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
	    
	    //se não achar nenhuma girafa, sorteamos uma qualqer
	    Random random = new Random();
		int r = random.nextInt(movimentos.size());
	    return movimentos.get(r);
	  }
	    
	  public String getNome(){
	    return "PintoAlemao";
	  }
	  
	  public String getEquipe(){
	    return "Panqueca-Tcemaki";
	  }

	}