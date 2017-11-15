package ai.montecarlo;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Random;

import ai.EstrategiaAleatoriaSimulacao;
import ai.EstrategiaParaTeste;
import ai.JogoSimulacao;
import core.Info;
import core.JogadorCore;
import core.LogJava;
import core.Movimento;
import core.PecaCore;
import core.Replay;
import core.ReplayJava;

public class MonteCarloTreeSearch {
	
	private Arvore arvore;
	private int meuId;
	private No inicial;
	private No atual;
    static double epsilon = 1e-6;
    private int qty;
    private long inicio;
    private int tipo;
	
	public MonteCarloTreeSearch(int id,String estadoStr,int qty, int tipo){
		this.meuId = id;
		this.qty = qty;
		this.inicio = System.currentTimeMillis();
		JogoSimulacao jogo = new JogoSimulacao(new EstrategiaParaTeste(), new EstrategiaParaTeste());
		LogJava l = new LogJava();
		Replay r = new ReplayJava(l.getTimeStamp());
		jogo.setLog(l);		
		jogo.setReplay(r);
		if(estadoStr != null){
			jogo.stringToInfo(id, estadoStr);
		}
		this.tipo = tipo;
		jogo.iniciar();
		
		
		jogo.criarInfo();

		this.arvore = new Arvore(jogo);
		this.atual = this.arvore.raiz;
		this.inicial = this.arvore.raiz;
	}
	
	
	
	public void run(){
		if(tipo == 1){
			this.runInterate();
		}else{
			this.runTempo();
		}
	}
	
	public void runTempo(){
		long agora = System.currentTimeMillis();
		
		while(agora - this.inicio < this.qty){
			this.ciclo();
			agora = System.currentTimeMillis();
		}
	}
	
	public void runInterate(){
		int i = 0;
		while(i < this.qty){
			this.ciclo();
			i++;
		}
	}
	
	public void ciclo(){
		this.atual = selecionar(atual);
		this.expandir(this.atual);
		for(No n:this.atual.proximos.values()){
			this.simular(n);
			this.atualizar(n);
		}
	}
	
	public Movimento getMovimento(){
		ArrayList<No> filhos = new ArrayList<No>(inicial.proximos.values());
		No maior = Collections.max(filhos, new Comparator<No>(){
			public int compare(No a, No b) {
		        if (a.valor < b.valor)
		            return -1;
		        if (a.valor == b.valor)
		            return 0;
		        return 1;
		    }
		});
		return maior.movimento;
	}
	
	public double calcularValor(No n){
		
		No pai = n.anterior;
		if(pai == null){
			return -1;
		}
		if(n.simulacoes == 0){
			return Integer.MAX_VALUE;
		}
		return ((double) n.vitorias / (double) n.simulacoes) 
				+ 1.41 * Math.sqrt(Math.log(pai.simulacoes) / (double) n.simulacoes);
	}
	
	public No selecionar(No atual){
		No escolhido = atual;
		ArrayList<No> filhos = new ArrayList<No>(atual.proximos.values());
		if(filhos.size()>0){
			for(No n:filhos){
				n.valor = calcularValor(n);
				if(escolhido == null){
					escolhido = n;
				}else if(escolhido.valor < n.valor){
					escolhido = n;
				}
			}
		}
		return escolhido;
		
//		for(No n:arvore.nos){
//			int ni = n.simulacoes;
//			int N = 1;
//			if(n.anterior != null){
//				N = N+n.anterior.simulacoes;
//			}
//			Random r = new Random();
//			n.valor = calcularValor(n);
//			
//			if(escolhido == null){
//				escolhido = n;
//			}else if(escolhido.valor < n.valor){
//				escolhido = n;
//			}
//		}
			
		
	}
		
	public JogoSimulacao duplicarJogo(JogoSimulacao jogo){
		JogoSimulacao novoJogo = new JogoSimulacao(new EstrategiaAleatoriaSimulacao(), new EstrategiaAleatoriaSimulacao());
		LogJava l = new LogJava();
		Replay r = new ReplayJava(l.getTimeStamp());
		String estado = jogo.infoToString();
		novoJogo.setLog(l);
		novoJogo.setReplay(r);
		novoJogo.stringToInfo(jogo.getJogadorAtivo().getId(),estado);
		novoJogo.criarInfo();
		
		return novoJogo;
	}
	
	public void expandir(No n){
		JogoSimulacao jogo = n.jogo;
		
		Info info = jogo.getInfo();
		
		ArrayList<Movimento> movimentos = info.getMovimentos();
		for(Movimento m:movimentos){
			JogoSimulacao novoJogo = duplicarJogo(jogo);
			novoJogo.criarInfo();
			Info novoInfo = novoJogo.getInfo();
			ArrayList<Movimento> novosMovimentos = novoInfo.getMovimentos();
			Movimento novoMovimento = null;
			for(Movimento nm:novosMovimentos){
				if( nm.getJogador().getId() == m.getJogador().getId() &&
					nm.getPeca().getNome().equals(m.getPeca().getNome()) &&
					nm.getTipo().equals(m.getTipo()) &&
					nm.getX() == m.getX() &&
					nm.getY() == m.getY()
				){
					novoMovimento = nm;
					break;
				}
			}
			novoJogo.turno(novoMovimento);
			novoJogo.criarInfo();
			String novoEstado = novoJogo.infoToString();
			
			if(n.proximos.get(novoEstado) == null){
				No novoNo = new No();
				novoNo.movimento = novoMovimento;
				novoNo.jogo = novoJogo;
				novoNo.anterior = n;
				
				arvore.nos.add(novoNo);
				n.proximos.put(novoEstado, novoNo);
			}
		}	
	}
	
	public void simular(No n){
		
		JogoSimulacao jogo = duplicarJogo(n.jogo);
		jogo.iniciar();
		
		//bug
		if(jogo.getTabuleiro().getPecasLeoes().size() < 2){
//			String infoStr = jogo.infoToString();
//			System.out.println(infoStr);
		}else{
		
			while(jogo.continuar()){
				jogo.turno();
				String infoStr = jogo.infoToString();
			}
			
		    JogadorCore ganhador = jogo.getGanhador();
		    if(ganhador != null && ganhador.getId() == this.meuId){
		    	n.vitorias+=1;
		    }
		    n.simulacoes+=1;
		}
	}
	
	public void atualizar(No n){
		No atual = n;
		No anterior = null;
		while(atual.anterior != null){
			anterior = atual.anterior;
			anterior.vitorias+=atual.vitorias;
			anterior.simulacoes+=atual.simulacoes;
			atual = anterior;
		}
	}
}
