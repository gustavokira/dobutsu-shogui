package estrategias;

import java.util.ArrayList;
import java.util.Random;

import core.Estrategia;
import core.Info;
import core.Tabuleiro;
import core.Movimento;
import core.Peca;
import core.Casa;

public class EstrategiaGirafaAntesDeTudoJava extends Estrategia{
	 
	  
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
	    Random random = new Random();
		int r = random.nextInt(movimentos.size());
		
	    return movimentos.get(r);
	  }
	  
	  public String getNome(){
	    return "girafa antes";
	  }
	  
	  public String getEquipe(){
	    return "ash ketchum";
	  }
	}