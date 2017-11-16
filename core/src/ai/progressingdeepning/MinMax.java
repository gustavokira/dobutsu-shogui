package ai.progressingdeepning;

import java.util.HashMap;

import ai.Arvore;
import ai.EstrategiaParaTeste;
import ai.JogoSimulacao;
import ai.No;
import ai.Utils;
import core.Info;
import core.LogJava;
import core.Movimento;
import core.PecaCore;
import core.Replay;
import core.ReplayJava;

public class MinMax {

	Arvore arvore;
	int id;
	
	
	public MinMax(String estadoStr,int id){
		
		JogoSimulacao jogo = new JogoSimulacao(new EstrategiaParaTeste(), new EstrategiaParaTeste());
		LogJava l = new LogJava();
		Replay r = new ReplayJava(l.getTimeStamp());
		jogo.setLog(l);		
		jogo.setReplay(r);
		if(estadoStr != null){
			jogo.stringToInfo(id, estadoStr);
		}
		this.id = id;
		jogo.iniciar();
		jogo.criarInfo();

		this.arvore = new Arvore(jogo);
	}
	
	public Movimento run(int i){
		expandir(this.arvore.raiz, 0, i, 0,this.id);
		int valorMaximo = -1;
		Movimento m = null;
		for(No n:this.arvore.raiz.proximos.values()){
			if(n.valor > valorMaximo){
				valorMaximo = (int)n.valor;
				m = n.movimento;
			}
		}
		return m;
	}
	
	public int expandir(No no,int i,int max,int turno,int id){
		No anterior = no;
		if(i < max){
			HashMap<Movimento,JogoSimulacao> proximos = this.getProximosEstados(no.jogo);
			for(Movimento m:proximos.keySet()){
				No n = new No();
				n.movimento = m;
				n.jogo = proximos.get(m);
				n.anterior = anterior;
				anterior.proximos.put(m.toString(), n);
				int novoTurno = 0;
				if(turno == 0){
					novoTurno = 1;
				}
				int valor = expandir(n, i+1, max,novoTurno,id);
				if(turno == 0){
					int v = (int) Math.max(no.valor,valor);
					n.valor = v;
				}else{
					int v = (int) Math.min(no.valor,valor);
					n.valor = v;
				}
			}
		}
		
		return avaliar(no.jogo,id);
	}
	
	public int avaliar(JogoSimulacao jogo,int id){
		int valor = 0;
		if(id == 1){
			valor+=jogo.getJogador1().getPecasNaMao().size();
		}else{
			valor+=jogo.getJogador2().getPecasNaMao().size();
		}
		
		for(PecaCore p:jogo.getTabuleiro().getPecas()){
			if(p.getDono().getId() == id){
				valor++;
			}
		}
		
		return valor;
	}
	
	public int ehFinal(JogoSimulacao jogo){
		JogoSimulacao novoJogo = null;
		try{
			novoJogo = duplicarJogo(jogo);
		}catch(NullPointerException e){
			System.out.println(Utils.infoToString(jogo.getInfo()));
		}
		
		novoJogo.turno();
		if(novoJogo.getGanhador() != null){
			return novoJogo.getGanhador().getId();
		}
		return 0;
	}
	
	public JogoSimulacao proximoEstado(JogoSimulacao jogo, Movimento m){
		JogoSimulacao novoJogo = duplicarJogo(jogo);
		novoJogo.criarInfo();
		Info i = novoJogo.getInfo();
		
		for(Movimento nm: i.getMovimentos() ){
			if(Utils.compararMovimentos(nm, m)){
				novoJogo.turno(nm);
				break;
			}
		}
		JogoSimulacao novissimoJogo = duplicarJogo(novoJogo);
		return novissimoJogo;
	}
	
	public HashMap<Movimento,JogoSimulacao> getProximosEstados(JogoSimulacao jogo){
		jogo.criarInfo();
		Info i = jogo.getInfo();
		
		HashMap<Movimento,JogoSimulacao> jogos = new HashMap<Movimento,JogoSimulacao>();
		for(Movimento m: i.getMovimentos()){
			JogoSimulacao j = this.proximoEstado(jogo,m);
			
			int ganhadorFilho = ehFinal(j); 
			if(ganhadorFilho == 0){			
				jogos.put(m,j);
			}
		}
		return jogos;
	}
	
	public JogoSimulacao duplicarJogo(JogoSimulacao jogo){
		JogoSimulacao novoJogo = new JogoSimulacao(new EstrategiaParaTeste(), new EstrategiaParaTeste());
		LogJava l = new LogJava();
		Replay r = new ReplayJava(l.getTimeStamp());
		String estado = jogo.infoToString();
		novoJogo.setLog(l);
		novoJogo.setReplay(r);
		novoJogo.stringToInfo(jogo.getJogadorAtivo().getId(),estado);
		return novoJogo;
	}
}
