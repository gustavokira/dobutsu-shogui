package ai;

import java.util.ArrayList;
import java.util.Random;

import core.Estrategia;
import core.Info;
import core.Jogador;
import core.LogJava;
import core.Movimento;
import core.Peca;
import core.Replay;
import core.ReplayJava;

public class EstrategiaParaTeste extends Estrategia{
	
	public Movimento atual;
	
	@Override
	public Movimento escolherMovimento(Info info, ArrayList<Movimento> movimentos) {
	
		for(Movimento m:movimentos){
		      if(m.getPeca().getNome().equals("leo")){
		        if(m.getY() == 0 && m.getJogador().getId() == 2){
		          return m;
		        }
		        if(m.getY() == 2 && m.getJogador().getId() == 1){
		          return m;
		        }
		      }
		    }
		    for(Movimento m:movimentos){
		      
		      JogoSimulacao j = new JogoSimulacao(new EstrategiaAleatoriaSimulacao(),new EstrategiaAleatoriaSimulacao());
		      LogJava l = new LogJava();
			  Replay r = new ReplayJava(l.getTimeStamp());
		      j.setLog(l);
		      j.setReplay(r);
		      j.stringToInfo(info.getEu().getId(),Utils.infoToString(info));
		      j.criarInfo();
		      Info ij = j.getInfo();
		      Movimento escolhido = null;
		      for(Movimento mj:ij.getMovimentos()){
		        if(
		          mj.getX() == m.getX() &&
		          mj.getY() == m.getY() &&
		          mj.getPeca().getNome() == m.getPeca().getNome()
		          ){
		            escolhido = mj;
		          }
		    }
		      
		      j.turno(escolhido);
		      j.criarInfo();
		      
		      Info i = j.getInfo();
		      
		      if(i.getMovimentos().size() == 0){
		        return m;
		      }
		      
		    }
		        
		
		Random r = new Random();
		int i = r.nextInt(movimentos.size());
		Movimento m = movimentos.get(i);
		this.atual = m;
		
		return m;
	}

	@Override
	public String getNome() {
		return "teste";
	}

	@Override
	public String getEquipe() {
		return "simulador";
	}

}
