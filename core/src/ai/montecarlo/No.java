package ai.montecarlo;

import java.util.HashMap;

import ai.JogoSimulacao;
import core.Movimento;

class No{
	public No anterior;
	public JogoSimulacao jogo;
	public HashMap<String,No> proximos;
	public int simulacoes;
	public int vitorias;
	public double valor;
	public Movimento movimento;
	
	public No(){
		this.proximos = new HashMap<String,No>();
		this.vitorias = 0;
		this.simulacoes = 0;
	}
}