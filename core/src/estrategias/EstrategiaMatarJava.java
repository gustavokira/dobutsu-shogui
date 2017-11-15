package estrategias;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import core.Estrategia;
import core.Info;
import core.Tabuleiro;
import core.Movimento;
import core.Casa;

public class EstrategiaMatarJava extends Estrategia {
	  
	  public Movimento escolherMovimento(Info info,ArrayList<Movimento>movimentos){
	    HashMap<String,Integer> valores = new HashMap<String,Integer>();
	    valores.put("leo",0);
	    valores.put("gal",4);
	    valores.put("gir",3);
	    valores.put("ele",2);
	    valores.put("pin",1);
	    
	   
	    for(int i =0;i<movimentos.size();i++){
	      Movimento m = movimentos.get(i);
	      
	      String nome = m.getPeca().getNome();
	      
	      if (nome =="pin"){
	      
	        int destinoX = m.getX();
	        int destinoY = m.getY();
	        Tabuleiro t = info.getTabuleiro();
	        Casa destino = t.getCasa(destinoX,destinoY);
	        
	        if(destino.temPeca()){
	           return m;
	        }
	      }
	      else if (nome =="ele"){
	      
	        int destinoX = m.getX();
	        int destinoY = m.getY();
	        Tabuleiro t = info.getTabuleiro();
	        Casa destino = t.getCasa(destinoX,destinoY);
	        
	        if(destino.temPeca()){
	           return m;
	        }
	      }
	        else if (nome =="gir"){
	      
	        int destinoX = m.getX();
	        int destinoY = m.getY();
	        Tabuleiro t = info.getTabuleiro();
	        Casa destino = t.getCasa(destinoX,destinoY);
	        
	        if(destino.temPeca()){
	           return m;
	        }
	      }
	      else if (nome =="gal"){
	      
	        int destinoX = m.getX();
	        int destinoY = m.getY();
	        Tabuleiro t = info.getTabuleiro();
	        Casa destino = t.getCasa(destinoX,destinoY);
	        
	        if(destino.temPeca()){
	           return m;
	        }
	      }
	      else if (nome =="leo"){
	      
	        int destinoX = m.getX();
	        int destinoY = m.getY();
	        Tabuleiro t = info.getTabuleiro();
	        Casa destino = t.getCasa(destinoX,destinoY);
	        
	        if(destino.temPeca()){
	           return m;
	        }
	      }
	      
	    }
	    
	    Random random = new Random();
		int r = random.nextInt(movimentos.size());
	    return movimentos.get(r);
	  }
	  public String getNome(){
	    return "Fatality";
	  }
	  
	  public String getEquipe(){
	    return "ShoguiOnda";
	  }
	}