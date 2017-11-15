package ai;

import java.util.ArrayList;

public class Arvore {	
	public No raiz;
	public ArrayList<No>nos;
	public Arvore(JogoSimulacao jogo){
		this.raiz = new No();
		this.raiz.jogo = jogo;
		this.nos = new ArrayList<No>();
		this.nos.add(this.raiz);
	}
}