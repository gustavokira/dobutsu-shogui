package ai;

import java.util.ArrayList;
import java.util.Random;

import core.Estrategia;
import core.Info;
import core.Movimento;

public class EstrategiaParaTeste extends Estrategia{
	
	public Movimento atual;
	
	@Override
	public Movimento escolherMovimento(Info info, ArrayList<Movimento> movimentos) {
		Estrategista e = new Estrategista();
		Movimento escolha = null;
		
		escolha = e.leaoIrParaOFim(info,movimentos);
		if(escolha != null){ return escolha;}
		
		escolha = e.fecharLeao(info, movimentos);
		if(escolha != null){ return escolha;}   
		
		escolha = e.material(info, movimentos);
		if(escolha != null){ return escolha;}
		
		Random r = new Random();
		int i = r.nextInt(movimentos.size());
		escolha = movimentos.get(i);
		return escolha;
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
