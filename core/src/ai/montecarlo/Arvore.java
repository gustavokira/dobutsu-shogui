package ai.montecarlo;

import java.util.ArrayList;

import ai.JogoSimulacao;

public class Arvore {	
	No raiz;
	ArrayList<No>nos;
	public Arvore(JogoSimulacao jogo){
		this.raiz = new No();
		this.raiz.jogo = jogo;
		this.nos = new ArrayList<No>();
		this.nos.add(this.raiz);
	}
}