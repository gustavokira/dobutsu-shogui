package ai.memoria;

import java.sql.SQLException;
import java.util.HashMap;

import ai.EstrategiaAleatoriaSimulacao;
import ai.JogoSimulacao;
import core.JogadorCore;
import core.LogJava;
import core.Movimento;
import core.Replay;
import core.ReplayJava;

public class SimuladorAleatorioSalvarBancoDeDados{
	
	public static void main(String args[]) throws SQLException {
		
		SimuladorAleatorioSalvarBancoDeDados simulador = new SimuladorAleatorioSalvarBancoDeDados();
		
		DatabaseMemoria db = new DatabaseMemoria("dobutsu-aleatorio", "root", "");
		db.abrirConexao();
		
		for(int i =0;i<1000;i++){
			JogoSimulacao jogo = simulador.criarJogo();
			jogo.iniciar();
			jogo.criarInfo();
			HashMap<String,Movimento> hist = new HashMap<String,Movimento>();	
			
			while(jogo.continuar()){
				int t = jogo.getTurno();
				String estadoId = jogo.infoToString();
				Movimento m = null;
				jogo.turno();
				
				//pegar os movimentos que foram gerados neste turno
//				System.out.println("movimentos qty "+jogo.getInfo().getMovimentos().size());
//				
				if(t%2 == 0){
					 m = ((EstrategiaAleatoriaSimulacao)jogo.getJogador1().getEstrategia()).atual;
				}else{
					 m = ((EstrategiaAleatoriaSimulacao)jogo.getJogador2().getEstrategia()).atual;
				}
				
				
				hist.put(estadoId, m);
				
				
				if(t%2 == 0){
					 ((EstrategiaAleatoriaSimulacao)jogo.getJogador1().getEstrategia()).atual = null;
				}else{
					 ((EstrategiaAleatoriaSimulacao)jogo.getJogador2().getEstrategia()).atual = null;
				}
				
			}
		    JogadorCore ganhador = jogo.getGanhador();
		    //System.out.println("ganhador "+ganhador.getId());
		    
		    if(ganhador != null){
		    	
		    	for(String k:hist.keySet()){
		    		Movimento m =  hist.get(k);
		    		if(m != null){
			    		String peca = m.getPeca().getNome();
			    		int x = m.getX();
			    		int y = m.getY();
			    		String tipo = m.getTipo();
			    		
			    		Estado e = db.getEstadoPorChave(k, m.getJogador().getId(), peca, x, y, tipo);

			    		if(e != null){
			    	    	String id = e.id;
			    	        int v = e.visitado+1;
			    	        int g = e.ganhou;
			    	        int p = e.perdeu;
	
			    	    	if(ganhador.getId() == m.getJogador().getId()){
			    	    		g+=1;
			    	    		db.atulizarEstado(id, v, g, p, m.getJogador().getId(), peca, x, y, tipo);
			    	    	}else{
			    	    		p+=1;
			    	    		db.atulizarEstado(id, v, g, p, m.getJogador().getId(), peca, x, y, tipo);
			    	    	}
			    	    }else{
			    	    	if(ganhador.getId() == m.getJogador().getId()){
			    	    		db.criarEstado(k, true, m.getJogador().getId(), peca, x, y, tipo);
			    	    	}else{
			    	    		db.criarEstado(k, false, m.getJogador().getId(), peca, x, y, tipo);
			    	    	}
			    	    }
		    		}else{
		    			//System.out.println("final");
		    			//System.out.println(k);
		    		}
		    	}
		    }
		    if(i%10 == 0){
		    	System.out.println("i:"+i);
		    }
		}
		db.fecharConexao();
	}
	
	public JogoSimulacao criarJogo(){
		JogoSimulacao jogo = new JogoSimulacao(new EstrategiaAleatoriaSimulacao(), new EstrategiaAleatoriaSimulacao());
		
		LogJava l = new LogJava();
		Replay r = new ReplayJava(l.getTimeStamp());
		
		jogo.setLog(new LogJava());
		jogo.setReplay(r);
		return jogo;
	}
}