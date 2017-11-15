package ai.memoria;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import ai.EstrategiaAleatoriaSimulacao;
import ai.JogoSimulacao;
import core.JogadorCore;
import core.LogJava;
import core.Movimento;
import core.Replay;
import core.ReplayJava;

public class SimuladorAleatorioSalvarBancoDeDados{
	
	public static void main(String args[]) throws SQLException {
		int max = 20000;
		if(args.length > 0){
			max = Integer.parseInt(args[0]);
		}
		
		SimuladorAleatorioSalvarBancoDeDados simulador = new SimuladorAleatorioSalvarBancoDeDados();
		boolean acharMenores = false;
		DatabaseMemoria db = new DatabaseMemoria("dobutsu-aleatorio", "root", "");
		db.abrirConexao();
		
		ArrayList<Estado> estados = null;
		if(acharMenores){
			estados = db.getEstadosParaVisitar(15);
		}
		for(int i =0;i<max;i++){
			JogoSimulacao jogo = simulador.criarJogo();
			HashMap<String,Movimento> hist = new HashMap<String,Movimento>();	
			
			if(acharMenores){
				Random r = new Random();
				int rx = r.nextInt(estados.size());
				Estado er = estados.get(rx);
				jogo.stringToInfo(er.jogadorId,er.id);
				Movimento m = null;
				jogo.iniciar();
				jogo.turno();
//				System.out.println("--------------------------------------");
//				System.out.println(er.jogadorId+" "+er.id);
//				System.out.println("movimentos qty "+jogo.getInfo().getMovimentos().size());
//				
				if(er.jogadorId == 1){
					 m = ((EstrategiaAleatoriaSimulacao)jogo.getJogador1().getEstrategia()).atual;
				}else{
					 m = ((EstrategiaAleatoriaSimulacao)jogo.getJogador2().getEstrategia()).atual;
				}
				//System.out.println("m "+m);
				
				
				hist.put(er.id, m);
			}else{
				jogo.iniciar();
				jogo.criarInfo();
			}
			
			
			
			
			
			while(jogo.continuar()){
				int t = jogo.getTurno();
				String estadoId = jogo.infoToString();
				int j = jogo.getJogadorAtivo().getId();
				
				//System.out.println(j+" "+estadoId);
				Movimento m = null;
				jogo.turno();
				
				//pegar os movimentos que foram gerados neste turno
				//System.out.println("movimentos qty "+jogo.getInfo().getMovimentos().size());
				
				if(j == 1){
					 m = ((EstrategiaAleatoriaSimulacao)jogo.getJogador1().getEstrategia()).atual;
				}else{
					 m = ((EstrategiaAleatoriaSimulacao)jogo.getJogador2().getEstrategia()).atual;
				}
				//System.out.println("m "+m);
				
				hist.put(estadoId, m);
				
				
				if(j == 1){
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
		    if(i%100 == 0){
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