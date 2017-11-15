package ai;

import java.util.ArrayList;

import core.Info;
import core.Jogador;
import core.Movimento;
import core.Peca;

public class Utils {
	
	public static Movimento acharMovimento(Movimento movimento, ArrayList<Movimento> movimentos){
		for(Movimento m:movimentos){
			if(compararMovimentos(m,movimento)){
				return m;
			}
		}
		return null;
	}
	
	public static boolean compararMovimentos(Movimento m1, Movimento m2){
		if( m1.getJogador().getId() == m2.getJogador().getId() &&
				m1.getPeca().getX() == m2.getPeca().getX() &&
				m1.getPeca().getY() == m2.getPeca().getY() &&
				m1.getPeca().getNome().equals(m2.getPeca().getNome()) &&
				m1.getTipo().equals(m2.getTipo()) &&
				m1.getX() == m2.getX() &&
				m1.getY() == m2.getY()
			){
				return true;
			}
		else{
			return false;
		}
	}

	public static String infoToString(Info info){
	      String saida = "";
	    
	    for(int i = 0;i<info.getTabuleiro().getLargura();i++){
	        for(int j = 0;j<info.getTabuleiro().getAltura();j++){
	          String peca = "---";
	          int direcao = 0;
	          if(info.getTabuleiro().getCasa(i, j).temPeca()){
	            peca = info.getTabuleiro().getCasa(i, j).getPeca().getNome();
	            
	            int donoId = info.getTabuleiro().getCasa(i, j).getPeca().getDono().getId();
	            direcao = 1;
	            if(donoId == 2){
	              direcao = -1;
	            }
	          }
	          
	          String c = i+","+j+","+peca+","+direcao;
	          c+=":";
	          
	          saida+=c;
	        }
	      }
	    saida = saida.substring(0,saida.length()-1);
	    saida+=";";
	    
	    int[] maoJ1 = new int[3];
	    int[] maoJ2 = new int[3];
	    Jogador jogador1 = info.getEu();
	    Jogador jogador2 = info.getOponente();
	    if(info.getEu().getId() == 2){
	      jogador2 = info.getEu();
	      jogador1 = info.getOponente();
	    }
	      ArrayList<Peca> pecasNaMaoJ1 = jogador1.getPecasNaMao();
	      ArrayList<Peca> pecasNaMaoJ2 = jogador2.getPecasNaMao();
	      
	      for(Peca p:pecasNaMaoJ1){
	        if(p.getNome().equals("pin")){
	          maoJ1[0]++;
	        }
	        if(p.getNome().equals("ele")){
	          maoJ1[1]++;
	        }
	        if(p.getNome().equals("gir")){
	          maoJ1[2]++;
	        }
	    }
	      for(int m:maoJ1){
	        saida+= m+",";
	      }
	      saida = saida.substring(0, saida.length()-1);
	      saida +=":";
	      for(Peca p:pecasNaMaoJ2){
	        if(p.getNome().equals("pin")){
	          maoJ2[0]++;
	        }
	        if(p.getNome().equals("ele")){
	          maoJ2[1]++;
	        }
	        if(p.getNome().equals("gir")){
	          maoJ2[2]++;
	        }
	    }
	      for(int m:maoJ2){
	        saida+= m+",";
	      }
	      saida = saida.substring(0, saida.length()-1);
	    
	    return saida;
	    }
	  
	
}
