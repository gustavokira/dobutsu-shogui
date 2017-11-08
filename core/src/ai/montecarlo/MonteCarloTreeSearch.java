package ai.montecarlo;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Random;

import ai.EstrategiaAleatoriaSimulacao;
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
	private No atual;
    static double epsilon = 1e-6;
    private int qty;
	
	public MonteCarloTreeSearch(int id,String estadoStr,int qty){
		this.meuId = id;
		this.qty = qty;
		JogoSimulacao jogo = new JogoSimulacao(new EstrategiaAleatoriaSimulacao(), new EstrategiaAleatoriaSimulacao());
		LogJava l = new LogJava();
		Replay r = new ReplayJava(l.getTimeStamp());
		jogo.setLog(l);		
		jogo.setReplay(r);
		if(estadoStr != null){
			jogo.stringToInfo(id, estadoStr);
		}
		jogo.iniciar();
		
		if(this.meuId == 2){
			jogo.turno();
		}
		jogo.criarInfo();

		this.arvore = new Arvore(jogo);
		this.atual = this.arvore.raiz;
	}
	
	public void run(){
		
		for(int i =0;i<this.qty;i++){
			this.atual = selecionar();
			
			this.expandir(this.atual);
			for(No n:this.atual.proximos.values()){
				this.simular(n);
				this.atualizar(n);
			}
		}
		
//		HashMap<String,ArrayList<No>> saidas = new HashMap<String,ArrayList<No>>(); 
//		for(No n:arvore.nos){
//			String s = n.jogo.infoToString();
//			ArrayList<No> ms = saidas.get(s);
//			if(ms == null){
//				ms = new ArrayList<No>();
//				saidas.put(s, ms);
//			}
//			ms.add(n);
//		}
//		
//		for(String s:saidas.keySet()){
//			System.out.println("-------");
//			System.out.println(s);
//			for(No n: saidas.get(s)){
//				System.out.println("chegou aqui:"+n.movimento+" "+n.valor);
//				System.out.println("-");
//				ArrayList<No> nos = new ArrayList<No>(n.proximos.values());
//				Collections.sort(nos,new Comparator<No>(){
//					public int compare(No n1,No n2){
//						if(n1.valor > n2.valor){
//							return -1;
//						}else{
//							return 1;
//						}
//					}
//				});
//				for(No f: nos){
//					System.out.println("\t "+f.valor+" "+f.movimento);
//				}
//
//			}
//			System.out.println("");
//		}
		
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
	
	public No selecionar(){
		No escolhido = null;
		for(No n:arvore.nos){
			int ni = n.simulacoes;
			int N = 1;
			if(n.anterior != null){
				N = N+n.anterior.simulacoes;
			}
			Random r = new Random();
			n.valor = calcularValor(n);
			
			if(escolhido == null){
				escolhido = n;
			}else if(escolhido.valor < n.valor){
				escolhido = n;
			}
		}
			
			return escolhido;
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
