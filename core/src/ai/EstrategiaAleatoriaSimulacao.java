package ai;

import java.util.ArrayList;
import java.util.Random;

import core.Estrategia;
import core.Info;
import core.Movimento;

public class EstrategiaAleatoriaSimulacao extends Estrategia{

	public Movimento atual;
	
	@Override
	public Movimento escolherMovimento(Info info, ArrayList<Movimento> movimentos) {
		Random r = new Random();
		int i = r.nextInt(movimentos.size());
		Movimento m = movimentos.get(i);
		this.atual = m;
		return m;
	}

	@Override
	public String getNome() {
		return "aleatória";
	}

	@Override
	public String getEquipe() {
		return "aleatorio";
	}

}
