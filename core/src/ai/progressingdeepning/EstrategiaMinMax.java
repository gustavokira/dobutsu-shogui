package ai.progressingdeepning;

import java.util.ArrayList;
import java.util.Random;

import ai.Utils;
import core.Estrategia;
import core.Info;
import core.Movimento;

public class EstrategiaMinMax extends Estrategia{

	public Movimento atual;
	
	@Override
	public Movimento escolherMovimento(Info info, ArrayList<Movimento> movimentos) {
		
		MinMax ab = new MinMax(Utils.infoToString(info), info.getEu().getId());
		Movimento analogo = ab.run(3);
		
		Movimento escolhido = null;
		
		if(analogo != null){
			escolhido = Utils.acharMovimento(analogo,movimentos);
		}
		if(escolhido != null){
			
			return escolhido;
		}
		Random r = new Random();
		int i = r.nextInt(movimentos.size());
		Movimento m = movimentos.get(i);
		this.atual = m;
		return m;
	}

	@Override
	public String getNome() {
		return "minmax";
	}

	@Override
	public String getEquipe() {
		return "ash";
	}

}
