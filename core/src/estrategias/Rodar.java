package estrategias;


import ai.EstrategiaAleatoriaSimulacao;
import ai.EstrategiaParaTeste;
import ai.JogoSimulacao;
import core.Estrategia;
import core.JogadorCore;
import core.LogJava;
import core.Replay;
import core.ReplayJava;

public class Rodar {
	
	public Estrategia jogo(Estrategia e1, Estrategia e2){
		JogoSimulacao jogo = new JogoSimulacao(e1,e2);
		LogJava l = new LogJava();
		Replay r = new ReplayJava(l.getTimeStamp());
		jogo.setLog(new LogJava());
		jogo.setReplay(r);
		jogo.iniciar();
		
		while(jogo.continuar()){
			jogo.turno();
		}
		JogadorCore j = jogo.getGanhador();
		if(j != null){
			Estrategia ganhadora = j.getEstrategia();
			return ganhadora;
		}else{
			return null;
		}
	}
	
	public static void main(String[] args) {
		
		Rodar r = new Rodar();
		int qty = 1000;
		Estrategia[] estrategias = {
				//new EstrategiaMinMax(),
				new EstrategiaParaTeste(),
				new EstrategiaAleatoriaSimulacao(),
				new EstrategiaAlemaoJava(),
				new EstrategiaChacinaJava(),
				new EstrategiaGirafaGodiJava(),
				new EstrategiaMatarJava(),
				new EstrategiaBigBeijoJava(),
				new EstrategiaGirafaAntesDeTudoJava(),
				new EstrategiaMaterialJava()
		};
		
		for(int i=0;i<estrategias.length;i++){
			for(int j=i+1;j<estrategias.length;j++){
				Estrategia e1 = estrategias[i];
				Estrategia e2 = estrategias[j];
				
				int v1 = 0;
				int v2 = 0;
				
				for(int k =0;k<qty;k++){
					Estrategia e = r.jogo(e1, e2);
					if(e != null){
						if(e.getNome() == e1.getNome()){
							v1++;
						}else if(e.getNome() == e2.getNome()){
							v2++;
						}
					}
				}
		
				System.out.println(e1.getNome()+" "+v1+" - "+v2+" "+e2.getNome());
				v1 = 0;
				v2 = 0;
		
				for(int k =0;k<qty;k++){
					Estrategia e = r.jogo(e2, e1);
					if(e != null){
						if(e.getNome() == e1.getNome()){
							v1++;
						}else if(e.getNome() == e2.getNome()){
							v2++;
						}
					}
				}
				System.out.println(e2.getNome()+" "+v2+" - "+v1+" "+e1.getNome());
				System.out.println("");
			}
		}
	}
}
